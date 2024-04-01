using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Project_3.Controllers
{
    public class OurWorkController : Controller
    {
        // GET: OurWork
        public ActionResult Index(int? id)
        {
            if (id == null)
            {
                id = 1;
            }
            var categories = Data.DbConnect.Db.Categories.Where(c=>c.CategoryId == id).FirstOrDefault();
            return View(categories);
        }
    }
}