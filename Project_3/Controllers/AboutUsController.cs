using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Project_3.Controllers
{
    public class AboutUsController : Controller
    {
        // GET: AboutUs
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult WhatWedo()
        {
            return View();
        }

        public ActionResult Mission()
        {
            return View();
        }

        public ActionResult OurTeam()
        {
            var data = Data.DbConnect.Db.Members.Include(x => x.Business).ToList().Where(x => x.Status.Equals(1));
            return View(data);
        }

        public ActionResult Partner()
        {
            var data = Data.DbConnect.Db.Partners.ToList().Where(x => x.Status.Equals(1));
            return View(data);
        }
    }
}