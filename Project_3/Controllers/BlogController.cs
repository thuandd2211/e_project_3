using PagedList;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace Project_3.Controllers
{
    public class BlogController : Controller
    {
        // GET: Blog
        [HttpGet]
        public ActionResult Index(string currentFilter, string search, int? page)
        {
            var data = new List<Blog>();
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
                data = Data.DbConnect.Db.Blogs.Where(c => c.Name.ToLower().Contains(text) && c.Status == 1).ToList();
            }
            else
            {
                data = Data.DbConnect.Db.Blogs.Where(c => c.Status == 1).ToList();
            }
            ViewData["CurrentFilter"] = search;
            int pageSize = 6;
            int pageNumber = page ?? 1;
            return View(data.ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult Detail(int? id)
        {
            var data = Data.DbConnect.Db.Blogs.ToList().FirstOrDefault(x => x.BlogId == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }
    }
}