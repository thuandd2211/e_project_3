using PagedList;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Project_3.Areas.Admin.Controllers
{
    public class OurTeamController : BaseController
    {
        private List<Member> ListMember()
        {
            return Data.DbConnect.Db.Members.Include(m => m.Business).ToList();
        }
        // GET: Admin/OurTeam
        public ActionResult Index(string currentFilter, string search, int? page)
        {
            var data = new List<Member>();
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
                data = ListMember().Where(m => m.FullName.ToLower().Contains(text) && m.Status == 1).ToList();
            }
            else
            {
                data = ListMember().Where(b => b.Status.Equals(1)).ToList();
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

        private bool Check(Member member, int id_check, int? id)
        {
            if (string.IsNullOrEmpty(member.FullName))
            {
                ModelState.AddModelError("FullName", "Member Name can not be null");
            }
            if (string.IsNullOrEmpty(member.Biography))
            {
                ModelState.AddModelError("Biography", "Biography can not be null");
            }
            var blogName = Data.DbConnect.Db.Members.ToList().FirstOrDefault(b => b.FullName.Equals(member.FullName) && b.Status == 1);
            if (id_check == 1)
            {
                blogName = Data.DbConnect.Db.Members.ToList().FirstOrDefault(b => b.FullName.Equals(member.FullName) && b.Status == 1 && b.MemberId != id);
            }
            if (blogName != null)
            {
                ModelState.AddModelError("FullName", "Blog Name already exist");
            }
            return true;
        }

        // GET: Admin/OurTeam/Add
        public ActionResult Add()
        {
            ViewBag.BusiItem = new SelectList(Data.DbConnect.Db.Businesses, "BusinessId", "Name");
            return View();
        }

        // POST: Admin/OurTeam/Add
        [HttpPost]
        public ActionResult Add([Bind(Include = "MemberId,FullName,Biography,BusinessId")] Member member, HttpPostedFileBase Img)
        {
            ViewBag.BusiItem = new SelectList(Data.DbConnect.Db.Businesses, "BusinessId", "Name");
            if (Check(member, 0, 0) && ModelState.IsValid)
            {
                member.Img = CheckImg(Img);              
                member.Status = 1;
                Data.DbConnect.Db.Members.Add(member);
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index", "OurTeam");
            }
            return View(member);
        }

        // GET: Admin/OurTeam/Edit
        public ActionResult Edit(int? id)
        {
            ViewBag.BusiItem = new SelectList(Data.DbConnect.Db.Businesses, "BusinessId", "Name");
            var data = ListMember().FirstOrDefault(b => b.MemberId == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            return View(data);
        }

        // POST: Admin/OurTeam/Edit
        [HttpPost]
        public ActionResult Edit([Bind(Include = "MemberId,FullName,Biography,BusinessId")] Member member, HttpPostedFileBase Img, int? id)
        {
            var data = ListMember().FirstOrDefault(b => b.MemberId == id);
            if (data == null)
            {
                return HttpNotFound();
            }
            ViewBag.BusiItem = new SelectList(Data.DbConnect.Db.Businesses, "BusinessId", "Name");
            if (Check(member, 1, id) && ModelState.IsValid)
            {
                member.Img = CheckImg(Img);
                

                data.FullName = member.FullName;
                data.Biography = member.Biography;
                data.Img = member.Img != null ? member.Img : data.Img;               
                data.BusinessId = member.BusinessId;               
                member.Status = 1;
                Data.DbConnect.Db.Entry(data).State = System.Data.Entity.EntityState.Modified;
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index", "OurTeam");
            }
            else
            {
                return View(member);
            }
        }

        // GET: Admin/OurTeam/Delete
        [HttpGet]
        public ActionResult Delete(int? id)
        {
            var member = Data.DbConnect.Db.Members.Find(id);
            if (member == null)
            {
                return HttpNotFound();
            }
            member.Status = 0;
            Data.DbConnect.Db.SaveChanges();
            return RedirectToAction("Index", "OurTeam");
        }

    }
}