using Microsoft.Ajax.Utilities;
using PagedList;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace Project_3.Areas.Admin.Controllers
{
    public class FundController : BaseController
    {
        // GET: Admin/Fund
        public ActionResult Index(string currentFilter, string search, int? page)
        {
            var data = new List<Fund>();
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
                data = Data.DbConnect.Db.Funds.ToList().Where(p => p.Name.ToLower().Contains(text)  && p.Status == 1).ToList();
            }
            else
            {
                data = Data.DbConnect.Db.Funds.ToList().Where(p => p.Status.Equals(1)).ToList();
            }
            ViewData["CurrentFilter"] = search;
            int pageSize = 5;
            int pageNumber = page ?? 1;
            return View(data.ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/Fund/Add
        [HttpGet]
        public ActionResult Add()
        {
            return View();
        }

        private bool Check(Fund fund, int id_check, int? id)
        {
            if (string.IsNullOrEmpty(fund.Name))
            {
                ModelState.AddModelError("Name", "Fund Name can not be null");
            }
            var fundName = Data.DbConnect.Db.Funds.ToList().FirstOrDefault(b => b.Name.Equals(fund.Name) && b.Status == 1);
            if (id_check == 1)
            {
                fund = Data.DbConnect.Db.Funds.ToList().FirstOrDefault(b => b.Name.Equals(fund.Name) && b.Status == 1 && b.FundId != id);
            }
            if (fundName != null)
            {
                ModelState.AddModelError("Name", "Fund Name already exist");
            }
            return true;
        }
        //POST: Admin/Fund/Add
        [HttpPost]
        public ActionResult Add(Fund fund)
        {
            if (Check(fund, 0, 0) && ModelState.IsValid)
            {               
                fund.Status = 1;
                Data.DbConnect.Db.Funds.Add(fund);
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index", "Fund");
            }
            return View(fund);
        }

        // GET: Admin/Fund/Edit
        public ActionResult Edit(int? id)
        {           
            var data = Data.DbConnect.Db.Funds.ToList().FirstOrDefault(b => b.FundId == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }

        // POST: Admin/Fund/Edit
        [HttpPost]
        public ActionResult Edit(Fund fund, int? id)
        {
            var data = Data.DbConnect.Db.Funds.ToList().FirstOrDefault(b => b.FundId == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            if (Check(fund, 1, id) && ModelState.IsValid)
            {
              
                data.Name = fund.Name;
                data.Description = fund.Description;
                data.Status = 1;
                Data.DbConnect.Db.Entry(data).State = System.Data.Entity.EntityState.Modified;
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index", "Fund");
            }
            else
            {
                return View(fund);
            }
        }

        // GET: Admin/OurTeam/Delete
        [HttpGet]
        public ActionResult Delete(int? id)
        {
            var fund = Data.DbConnect.Db.Funds.Find(id);
            if (fund == null)
            {
                return HttpNotFound();
            }
            fund.Status = 0;
            Data.DbConnect.Db.SaveChanges();
            return RedirectToAction("Index", "Fund");
        }
    }
}