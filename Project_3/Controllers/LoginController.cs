using PagedList;
using Project_3.Data;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace Project_3.Controllers
{
    public class LoginController : Controller
    {
        public bool CheckValidate(Donor donor)
        {
            if (string.IsNullOrEmpty(donor.Username))
            {
                ModelState.AddModelError("Username", "Please enter Username");
            }
            if (string.IsNullOrEmpty(donor.Password))
            {
                ModelState.AddModelError("Password", "Please enter Password");
            }

            if (donor.Birthday > DateTime.Now)
            {
                ModelState.AddModelError("Birthday", "Invalid date of birth.");
            }
            if (!string.IsNullOrEmpty(donor.Username) && !Regex.IsMatch(donor.Username, "^[a-zA-Z][\\w.]{2,14}$"))
            {
                ModelState.AddModelError("Username", "Username must start with a letter and be between 3-15 characters. Usernames can contain special characters: underscores and periods.");
            }
            if (!string.IsNullOrEmpty(donor.Password) && !Regex.IsMatch(donor.Password, "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"))
            {
                ModelState.AddModelError("Password", "Password minimum eight characters, at least one uppercase letter, one lowercase letter, and one number.");
            }

            var username = Data.DbConnect.Db.Donors.ToList().Where(c => c.Username == donor.Username).FirstOrDefault();
            if (username != null)
            {
                ModelState.AddModelError("Username", "Username already exists");
            }

            var email = Data.DbConnect.Db.Donors.ToList().Where(c => c.Email == donor.Email).FirstOrDefault();
            if (email != null)
            {
                ModelState.AddModelError("Email", "Email already exists");
            }

            var phone_number = Data.DbConnect.Db.Donors.ToList().Where(c => c.Phone == donor.Phone).FirstOrDefault();
            if (phone_number != null)
            {
                ModelState.AddModelError("Phone_number", "Phone Number already exists");
            }
            return true;
        }

        // Check text box null or empty
        public bool CheckNullOrEmpty(string username, string password)
        {
            if (string.IsNullOrEmpty(username))
            {
                ModelState.AddModelError("Username", "Please enter Username.");
            }
            if (string.IsNullOrEmpty(password))
            {
                ModelState.AddModelError("Password", "Please enter Password.");
            }
            return true;
        }

        // GET: Login
        public ActionResult Index()
        {
            return View();
        }

        // POST: Login
        [HttpPost]
        public ActionResult Index(string Username, string Password)
        {
            if (CheckNullOrEmpty(Username, Password) && ModelState.IsValid)
            {
                var data = Data.DbConnect.Db.Donors.ToList().Where(c => c.Username.Equals(Username.ToLower())).FirstOrDefault();
                if (data != null)
                {
                    if (data.Password.Equals(Data.DbConnect.Hash(Password)))
                    {
                        Session["DonorId"] = data.DonorId;
                        Session["DonorName"] = data.Fullname;
                        Session["DonorUsername"] = data.Username;
                        if (Session["Donate"] != null)
                        {
                            return RedirectToAction("Index", "Donate");
                        }
                        return RedirectToAction("Index", "Home");
                    }
                    ModelState.AddModelError("Password", "Incorrect password.");
                }
                else
                {
                    ModelState.AddModelError("Username", "Username does not exist.");
                }
                return View(ModelState);
            }
            return View();
        }

        // GET: Login/Register
        public ActionResult Register()
        {
            return View();
        }

        // POST: Login/Register
        [HttpPost]
        public ActionResult Register(Donor donor)
        {
            if (CheckValidate(donor) && ModelState.IsValid)
            {
                donor.Fullname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(donor.Fullname.ToLower());
                donor.Username = donor.Username.ToLower();
                donor.Password = Data.DbConnect.Hash(donor.Password);
                Data.DbConnect.Db.Donors.Add(donor);
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index", "Login");
            }
            return View(donor);
        }

        [HttpGet]
        // GET: User/Login/Logout
        public ActionResult Logout()
        {
            Session.Remove("DonorId");
            Session.Remove("DonorName");
            Session.Remove("DonorUsername");
            Session.Remove("Donate");
            return RedirectToAction("Index", "Home");
        }

        // GET: User/Login/EditAccount
        [HttpGet]
        public ActionResult EditAccount()
        {
            int id = Int32.Parse(Session["DonorId"].ToString());
            var data = Data.DbConnect.Db.Donors.ToList().FirstOrDefault(x => x.DonorId == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }

        public bool CheckValidate_Edit(Donor donor)
        {
            if (string.IsNullOrEmpty(donor.Fullname))
            {
                ModelState.AddModelError("Fullname", "Fullname can not be null.");
            }
            if (donor.Birthday > DateTime.Now)
            {
                ModelState.AddModelError("Birthday", "Invalid date of birth.");
            }            

            var email = Data.DbConnect.Db.Donors.ToList().Where(c => c.Email == donor.Email).FirstOrDefault();
            if (email != null)
            {
                ModelState.AddModelError("Email", "Email already exists");
            }
            var phone_number = Data.DbConnect.Db.Donors.ToList().Where(c => c.Phone == donor.Phone).FirstOrDefault();
            if (phone_number != null)
            {
                ModelState.AddModelError("Phone", "Phone Number already exists");
            }
            return true;
        }

        // POST: User/Login/EditAccount
        [HttpPost]
        public ActionResult EditAccount(Donor donor)
        {
            int id = Int32.Parse(Session["DonorId"].ToString());
            var data = Data.DbConnect.Db.Donors.ToList().FirstOrDefault(x => x.DonorId == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            if (CheckValidate_Edit(donor) && ModelState.IsValid)
            {
                data.Fullname = data.Fullname != null ? donor.Fullname : data.Fullname;
                data.Email = data.Email != null ? donor.Email : data.Email;
                data.Phone = data.Phone != null ? donor.Phone : data.Phone;
                data.Birthday = data.Birthday != null ? donor.Birthday : data.Birthday;
                Data.DbConnect.Db.SaveChanges();               
            }
            return View(data);
        }

        // GET: User/Login/YourCampaign
        [HttpGet]
        public ActionResult YourCampaign(string currentFilter, string search, int? page)
        {
            int pageSize = 3;
            int pageNumber = page ?? 1;
            int id = Int32.Parse(Session["DonorId"].ToString());
            var data = DbConnect.Db.REF_FUND_CAMP_DONOR.ToList().Where(x => x.DonorId == id).ToList();
            if (data == null)
            {
                return HttpNotFound();
            }
            ViewBag.data = data;
            ViewBag.donor = data.GroupBy(x => x.CampId).Select(camp => new
            {
                CampId = camp.Key,
                Total = camp.Sum(m => m.Amount)               
            }).ToPagedList(pageNumber, pageSize);

            var donor = data.GroupBy(x => x.CampId).Select(camp => new
            {
                CampId = camp.Key,
                Total = camp.Sum(m => m.Amount)
            }).ToList();
            /*ViewBag.donor = donor;
            foreach ( var item in donor )
            {
                ViewData["Total"] = item.Total;
            }*/
            if (search != null)
            {
                page = 1;
            }
            else
            {
                search = currentFilter;
            }
            if (!string.IsNullOrEmpty(search))
            {
                string text = search.ToLower();
                data = data.Where(c => c.Campaign.Name.ToLower().Contains(text) && c.Campaign.Status == 1).ToList();
            }
            else
            {
                data = data.Where(c => c.Campaign.Status.Equals(1)).ToList();
            }
            ViewData["CurrentFilter"] = search;
            return View(data);
        }
    }
}