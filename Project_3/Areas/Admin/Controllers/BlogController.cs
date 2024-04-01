using PagedList;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace Project_3.Areas.Admin.Controllers
{
    public class BlogController : BaseController
    {
        private List<Blog> ListBlog()
        {
            return Data.DbConnect.Db.Blogs.Include(b => b.Campaign).Include(b => b.Employee).ToList();
        }
        // GET: Admin/Blog
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
                data = ListBlog().Where(b => b.Name.ToLower().Contains(text) && b.Status == 1).ToList();
            }
            else
            {
                data = ListBlog().Where(b => b.Status.Equals(1)).ToList();
            }
            ViewData["CurrentFilter"] = search;
            int pageSize = 3;
            int pageNumber = page ?? 1;
            return View(data.ToPagedList(pageNumber, pageSize));
        }

        // Check Img
        private byte[] CheckImg(HttpPostedFileBase img)
        {

            if (img != null && img.ContentLength > 0)
            {
                if (!Path.GetExtension(img.FileName).ToLower().Equals(".png") && !Path.GetExtension(img.FileName).ToLower().Equals(".jpg") && !Path.GetExtension(img.FileName).ToLower().Equals(".jpeg"))
                {
                    ModelState.AddModelError("Image", "Please choose file type .png or .jpg or .jpeg");
                }
                try
                {
                    using (var binaryReader = new BinaryReader(img.InputStream))
                    {
                        byte[] images = binaryReader.ReadBytes(img.ContentLength);
                        return images;
                    }
                }
                catch (Exception)
                {

                    throw;
                }
            }
            return null;
        }

        private bool Check(Blog blog, int id_check, int? id)
        {
            if (string.IsNullOrEmpty(blog.Name))
            {
                ModelState.AddModelError("Name", "Blog Name can not be null");
            }
            if (string.IsNullOrEmpty(blog.CurrentTime.ToString()))
            {
                ModelState.AddModelError("CurrentTime", "Current Time can not be null");
            }
            var blogName = Data.DbConnect.Db.Blogs.ToList().FirstOrDefault(b => b.Name.Equals(blog.Name) && b.Status == 1);
            if (id_check == 1)
            {
                blogName = Data.DbConnect.Db.Blogs.ToList().FirstOrDefault(b => b.Name.Equals(blog.Name) && b.Status == 1 && b.BlogId != id);
            }    
            if (blogName != null)
            {
                ModelState.AddModelError("Name", "Blog Name already exist");
            }
            return true;
        }

        // GET: Admin/Blog/Add
        public ActionResult Add()
        {
            ViewBag.CampItem = new SelectList(Data.DbConnect.Db.Campaigns, "CampId", "Name");
            ViewBag.EmpItem = new SelectList(Data.DbConnect.Db.Employees, "EmpId", "Fullname");
            return View();
        }

        // POST: Admin/Blog/Add
        [HttpPost]
        public ActionResult Add([Bind(Include = "BlogId,Name,CurrentTime,Title1,Script1,Title2,Script2,Title3,Script3,Title4,Script4,CampId,EmpId")]
        Blog blog, HttpPostedFileBase Img1, HttpPostedFileBase Img2, HttpPostedFileBase Img3, HttpPostedFileBase Img4)
        {
            ViewBag.CampItem = new SelectList(Data.DbConnect.Db.Campaigns, "CampId", "Name");
            ViewBag.EmpItem = new SelectList(Data.DbConnect.Db.Employees, "EmpId", "Fullname");
            if (Check(blog, 0, 0) && ModelState.IsValid)
            {
                blog.Img1 = CheckImg(Img1);
                blog.Img2 = CheckImg(Img2);
                blog.Img3 = CheckImg(Img3);
                blog.Img4 = CheckImg(Img4);
                blog.Status = 1;
                Data.DbConnect.Db.Blogs.Add(blog);
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index", "Blog");
            }
            return View(blog);
        }

        // GET: Admin/Blog/Edit
        public ActionResult Edit(int? id)
        {
            ViewBag.CampItem = new SelectList(Data.DbConnect.Db.Campaigns, "CampId", "Name");
            ViewBag.EmpItem = new SelectList(Data.DbConnect.Db.Employees, "EmpId", "Fullname");
            var data = ListBlog().FirstOrDefault(b => b.BlogId == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }

        // POST: Admin/Blog/Edit
        [HttpPost]
        public ActionResult Edit([Bind(Include = "BlogId,Name,CurrentTime,Title1,Script1,Title2,Script2,Title3,Script3,Title4,Script4,CampId,EmpId")]
        Blog blog, HttpPostedFileBase Img1, HttpPostedFileBase Img2, HttpPostedFileBase Img3, HttpPostedFileBase Img4, int? id)
        {
            var data = ListBlog().FirstOrDefault(b => b.BlogId == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            ViewBag.CampItem = new SelectList(Data.DbConnect.Db.Campaigns, "CampId", "Name");
            ViewBag.EmpItem = new SelectList(Data.DbConnect.Db.Employees, "EmpId", "Fullname");
            if (Check(blog, 1, id) && ModelState.IsValid)
            {
                blog.Img1 = CheckImg(Img1);
                blog.Img2 = CheckImg(Img2);
                blog.Img3 = CheckImg(Img3);
                blog.Img4 = CheckImg(Img4);

                data.Name = blog.Name;
                data.CurrentTime = blog.CurrentTime;
                data.Title1 = blog.Title1;
                data.Title2 = blog.Title2;
                data.Title3 = blog.Title3;
                data.Title4 = blog.Title4;
                data.Script1 = blog.Script1;
                data.Script2 = blog.Script2;
                data.Script3 = blog.Script3;
                data.Script4 = blog.Script4;
                data.Img1 = blog.Img1 != null ? blog.Img1 : data.Img1;
                data.Img2 = blog.Img2 != null ? blog.Img2 : data.Img2;
                data.Img3 = blog.Img3 != null ? blog.Img3 : data.Img3;
                data.Img4 = blog.Img4 != null ? blog.Img4 : data.Img4;
                data.CampId = blog.CampId;
                data.EmpId = blog.EmpId;
                blog.Status = 1;
                Data.DbConnect.Db.Entry(data).State = System.Data.Entity.EntityState.Modified;
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index", "Blog");
            }
            else
            {
                return View(blog);
            }           
        }

        // GET: Admin/Blog/Delete
        [HttpGet]
        public ActionResult Delete(int? id)
        {
            var blog = Data.DbConnect.Db.Blogs.Find(id);
            if (blog == null)
            {
                return HttpNotFound();
            }
            blog.Status = 0;
            Data.DbConnect.Db.SaveChanges();
            return RedirectToAction("Index", "Blog");
        }
    }
}