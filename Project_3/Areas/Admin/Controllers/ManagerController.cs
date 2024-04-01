using PagedList;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace Project_3.Areas.Admin.Controllers
{
    public class ManagerController : BaseController
    {
        // GET: Admin/Manager
        public ActionResult Index(string currentFilter, string search, int? page)
        {
            var data = new List<Employee>();
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
                data = Data.DbConnect.Db.Employees.ToList().Where(e => e.Fullname.ToLower().Contains(text) || e.Username.Contains(text) && e.Status == 1).ToList();
            }
            else
            {
                data = Data.DbConnect.Db.Employees.Where(e => e.Status == 1).ToList();
            }
            ViewData["CurrentFilter"] = search;
            int pageSize = 8;
            int pageNumber = page ?? 1;
            return View(data.ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/Manager/Add
        public ActionResult Add()
        {
            return View();
        }

        public bool CheckValidate(Employee employee)
        {
            if (string.IsNullOrEmpty(employee.Username))
            {
                ModelState.AddModelError("Username", "Please enter Username");
            }
            if (string.IsNullOrEmpty(employee.Password))
            {
                ModelState.AddModelError("Password", "Please enter Password");
            }
            if (string.IsNullOrEmpty(employee.Phone))
            {
                ModelState.AddModelError("Phone_number", "Please enter Phone Number");
            }
            if (string.IsNullOrEmpty(employee.Email))
            {
                ModelState.AddModelError("Email", "Please enter Email");
            }
            if (employee.Birthday > DateTime.Now)
            {
                ModelState.AddModelError("Birth", "Invalid date of birth.");
            }
            if (!string.IsNullOrEmpty(employee.Username) && !Regex.IsMatch(employee.Username, "^[a-zA-Z][\\w.]{2,14}$"))
            {
                ModelState.AddModelError("Username", "Username must start with a letter and be between 3-15 characters. Usernames can contain special characters: underscores and periods.");
            }
            if (!string.IsNullOrEmpty(employee.Password) && !Regex.IsMatch(employee.Password, "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"))
            {
                ModelState.AddModelError("Password", "Password minimum eight characters, at least one uppercase letter, one lowercase letter, and one number.");
            }

            var username = Data.DbConnect.Db.Employees.Where(e => e.Username == employee.Username).FirstOrDefault();
            if (username != null)
            {
                ModelState.AddModelError("Username", "Username already exists");
            }

            var email = Data.DbConnect.Db.Employees.Where(e => e.Email == employee.Email).FirstOrDefault();
            if (email != null)
            {
                ModelState.AddModelError("Email", "Email already exists");
            }

            var phone_number = Data.DbConnect.Db.Employees.Where(e => e.Phone == employee.Phone).FirstOrDefault();
            if (phone_number != null)
            {
                ModelState.AddModelError("Phone_number", "Phone Number already exists");
            }
            return true;
        }
        // POST: Admin/Manager/Add
        [HttpPost]
        public ActionResult Add(Employee employee)
        {
            if (CheckValidate(employee) && ModelState.IsValid)
            {
                // Add Manager
                employee.Fullname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(employee.Fullname.ToLower());
                employee.Username = employee.Username.ToLower();
                employee.Password = Data.DbConnect.Hash(employee.Password);
                employee.Status = 1;
                Data.DbConnect.Db.Employees.Add(employee);
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index", "Manager");
            }
            return View(employee);
        }

        // GET: Admin/Manager/Edit
        public ActionResult Edit(int? id)
        {
            var data = Data.DbConnect.Db.Employees.Where(e => e.EmpId == id && e.Status == 1).FirstOrDefault();
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }
        // POST: Admin/Manager/Edit
        [HttpPost]
        public ActionResult Edit(Employee employee, int? id)
        {
            var data = Data.DbConnect.Db.Employees.Where(e => e.EmpId == id && e.Status == 1).FirstOrDefault();
            if (data == null)
            {
                return HttpNotFound();
            }
            if (ModelState.IsValid)
            {
                if (employee.Birthday > DateTime.Now)
                {
                    ModelState.AddModelError("Birth", "Invalid date of birth.");
                    return View(employee);
                }

                var email = Data.DbConnect.Db.Employees.Where(e => e.Email == employee.Email && e.EmpId != id).FirstOrDefault();
                if (email != null)
                {
                    ModelState.AddModelError("Email", "Email already exists");
                    return View(employee);
                }

                var phone_number = Data.DbConnect.Db.Employees.Where(e => e.Phone == employee.Phone && e.EmpId != id).FirstOrDefault();
                if (phone_number != null)
                {
                    ModelState.AddModelError("Phone_number", "Phone Number already exists");
                    return View(employee);
                }

                data.Fullname = CultureInfo.CurrentCulture.TextInfo.ToTitleCase(employee.Fullname.ToLower());
                data.Birthday = employee.Birthday;
                data.Phone = employee.Phone;
                data.Email = employee.Email;
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index", "Manager");
            }
            return View(data);
        }

        // GET: Admin/Manager/ResetPassword
        public ActionResult ResetPassword(int? id)
        {
            var data = Data.DbConnect.Db.Employees.Where(e => e.EmpId == id && e.Status ==1).FirstOrDefault();
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }

        // POST: Admin/Employee/ResetPassword
        [HttpPost]
        public ActionResult ResetPassword(string Password, int? id)
        {
            var data = Data.DbConnect.Db.Employees.Where(e => e.EmpId == id && e.Status == 1).FirstOrDefault();
            if (data == null)
            {
                return HttpNotFound();
            }
            if (!Regex.IsMatch(Password, "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"))
            {
                ModelState.AddModelError("Password", "Password minimum eight characters, at least one uppercase letter, one lowercase letter, and one number.");
                return View(data);
            }
            data.Password = Data.DbConnect.Hash(Password);
            Data.DbConnect.Db.SaveChanges();
            return RedirectToAction("Index", "Manager");
        }

        // GET: Admin/Employee/Delete
        [HttpGet]
        public ActionResult Delete(int? id)
        {
            var data = Data.DbConnect.Db.Employees.Where(e => e.EmpId == id && e.Status == 1).FirstOrDefault();
            if (data == null)
            {
                return HttpNotFound();
            }
            data.Status = 0;
            Data.DbConnect.Db.SaveChanges();
            return RedirectToAction("Index", "Manager");
        }
    }
}