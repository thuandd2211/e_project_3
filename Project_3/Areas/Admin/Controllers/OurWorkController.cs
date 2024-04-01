using PagedList;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Project_3.Areas.Admin.Controllers
{
    public class OurWorkController : BaseController
    {
        // GET: Admin/OurWork
        [HttpGet]
        public ActionResult Index(string currentFilter, string search, int? page)
        {
            var data = new List<Category>();
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
                data = Data.DbConnect.Db.Categories.ToList().Where(c => c.Name.ToLower().Contains(text) && c.Status == 1).ToList();
            }
            else
            {
                data = Data.DbConnect.Db.Categories.ToList().Where(c => c.Status.Equals(1)).ToList();
            }
            ViewData["CurrentFilter"] = search;
            int pageSize = 3;
            int pageNumber = page ?? 1;
            return View(data.ToPagedList(pageNumber, pageSize));

        }

        // GET: Admin/OurWork/Add
        [HttpGet]
        public ActionResult Add()
        {
            return View();
        }

        //POST: Admin/OurWork/Add
        [HttpPost]
        public ActionResult Add([Bind(Include = "CategoryId,Name,Title1,Script1,Title2,Script2,Title3,Script3,Status")] Category category, HttpPostedFileBase img1)
        {
            if (ModelState.IsValid)
            {
                var bTitle = Data.DbConnect.Db.Categories.Where(x => x.Name.Equals(category.Name, StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
                if (bTitle != null)
                {
                    ModelState.AddModelError("BigTitle", "Title already exist");
                    return View(category);
                }
                if (img1 != null && img1.ContentLength > 0)
                {
                    if (!Path.GetExtension(img1.FileName).ToLower().Equals(".png") && !Path.GetExtension(img1.FileName).ToLower().Equals(".jpg") && !Path.GetExtension(img1.FileName).ToLower().Equals(".jpeg"))
                    {
                        ModelState.AddModelError("Image", "Please choose file type .png or .jpg or .jpeg");
                        return View(category);
                    }
                    try
                    {
                        using (var binaryReader = new BinaryReader(img1.InputStream))
                        {
                            category.Img1 = binaryReader.ReadBytes(img1.ContentLength);
                        }
                    }
                    catch (Exception)
                    {

                        throw;
                    }
                }
                category.Status = 1;
                Data.DbConnect.Db.Categories.Add(category);
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index");
            }
            return View(category);
        }

        // GET: Admin/OurWork/Edit
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            var categories = Data.DbConnect.Db.Categories.Find(id);
            if (categories == null)
            {
                return HttpNotFound();
            }
            return View(categories);
        }

        //POST: Admim/OurWork/Edit
        [HttpPost]
        public ActionResult Edit([Bind(Include = "CategoryId,Name,Title1,Script1,Title2,Script2,Title3,Script3,Status")] Category category, HttpPostedFileBase img1, int id)
        {
            var data = Data.DbConnect.Db.Categories.Where(c => c.CategoryId == id).FirstOrDefault();
            if (data == null)
            {
                return HttpNotFound();
            }
            if (ModelState.IsValid)
            {
                var bTitle = Data.DbConnect.Db.Categories.Where(x => x.Name.Equals(category.Name, StringComparison.OrdinalIgnoreCase) && x.CategoryId != id).FirstOrDefault();
                if (bTitle != null)
                {
                    ModelState.AddModelError("BigTitle", "Title already exist");
                    return View(category);
                }
                if (img1 != null && img1.ContentLength > 0)
                {
                    if (!Path.GetExtension(img1.FileName).ToLower().Equals(".png") && !Path.GetExtension(img1.FileName).ToLower().Equals(".jpg") && !Path.GetExtension(img1.FileName).ToLower().Equals(".jpeg"))
                    {
                        ModelState.AddModelError("Image", "Please choose file type .png or .jpg or .jpeg");
                        return View(category);
                    }
                    try
                    {
                        using (var binaryReader = new BinaryReader(img1.InputStream))
                        {
                            category.Img1 = binaryReader.ReadBytes(img1.ContentLength);
                        }
                    }
                    catch (Exception)
                    {
                        throw;
                    }
                }
                data.Name = category.Name;
                data.Title1 = category.Title1;
                data.Script1 = category.Script1;
                data.Img1 = category.Img1 != null ? category.Img1 : data.Img1;
                data.Title2 = category.Title2;
                data.Script2 = category.Script2;
                data.Title3 = category.Title3;
                data.Script3 = category.Script3;
                data.Status = 1;
                Data.DbConnect.Db.Entry(data).State = System.Data.Entity.EntityState.Modified;
                Data.DbConnect.Db.SaveChanges(); 
            }
            return RedirectToAction("Index","OurWork");
        }

        //GET: Admin/OurWork/Delete
        [HttpGet]
        public ActionResult Delete(int? id)
        {
            var data = Data.DbConnect.Db.Categories.Find(id);
            if (data == null)
            {
                return HttpNotFound();
            }
            data.Status = 0;
            Data.DbConnect.Db.SaveChanges();
            return RedirectToAction("Index","OurWork");
        }
    }
}