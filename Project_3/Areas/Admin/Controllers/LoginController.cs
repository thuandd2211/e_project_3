using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Project_3.Areas.Admin.Controllers
{
    public class LoginController : Controller
    {
        // GET: Admin/Login
        public ActionResult Index()
        {
            if (Session["EmpId"] != null)
            {
                return RedirectToAction("Index","Home");
            }
            return View();
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

        [HttpPost]
        // POST: Admin/Login
        public ActionResult Index(string Username, string Password)
        {
            if (CheckNullOrEmpty(Username, Password) && ModelState.IsValid)
            {
                var data = Data.DbConnect.Db.Employees.ToList().Where(c => c.Username.Equals(Username.ToLower())).FirstOrDefault();
                if (data != null)
                {
                    if (data.Password.Equals(Data.DbConnect.Hash(Password)))
                    {
                        Session["EmpId"] = data.EmpId;
                        Session["EmpName"] = data.Fullname;
                        Session["EmpUsername"] = data.Username;
                        
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

        [HttpGet]
        // GET: Admin/Login/Logout
        public ActionResult Logout()
        {
            Session.Remove("EmpId");
            Session.Remove("EmpName");
            Session.Remove("EmpUsername");
            return RedirectToAction("Index", "Home");
        }
    }
}