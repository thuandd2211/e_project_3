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
    public class PartnerController : BaseController
    {
        // GET: Admin/Partner
        public ActionResult Index(string currentFilter, string search, int? page)
        {
            var data = new List<Partner>();
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
                data = Data.DbConnect.Db.Partners.ToList().Where(p => p.Name.ToLower().Contains(text) || p.Email.ToLower().Contains(text) 
                || p.Phone.Equals(text) && p.Status == 1).ToList();
            }
            else
            {
                data = Data.DbConnect.Db.Partners.ToList().Where(p => p.Status.Equals(1)).ToList();
            }
            ViewData["CurrentFilter"] = search;
            int pageSize = 5;
            int pageNumber = page ?? 1;
            return View(data.ToPagedList(pageNumber, pageSize));
        }

        // GET: Admin/Partner/Add
        [HttpGet]
        public ActionResult Add()
        {
            return View();
        }

        //POST: Admin/Partner/Add
        [HttpPost]
        public ActionResult Add([Bind(Include = "PartnerId,Name,Email,Phone,Address,Status")] Partner partner, HttpPostedFileBase Image)
        {
            if (ModelState.IsValid)
            {
                var pName = Data.DbConnect.Db.Partners.Where(p => p.Name.Equals(partner.Name, StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
                if (pName != null)
                {
                    ModelState.AddModelError("Name", "Partner Name already exist");
                    return View(partner);
                }
                var pPhone = Data.DbConnect.Db.Partners.Where(p => p.Phone.Equals(partner.Phone)).FirstOrDefault();
                if (pPhone != null)
                {
                    ModelState.AddModelError("Phone", "Partner Phone already exist");
                    return View(partner);
                }
                var pEmail = Data.DbConnect.Db.Partners.Where(p => p.Email.Equals(partner.Email, StringComparison.OrdinalIgnoreCase)).FirstOrDefault();
                if (pEmail != null)
                {
                    ModelState.AddModelError("Email", "Partner Email already exist");
                    return View(partner);
                }
                if (Image != null && Image.ContentLength > 0)
                {
                    if (!Path.GetExtension(Image.FileName).ToLower().Equals(".png") && !Path.GetExtension(Image.FileName).ToLower().Equals(".jpg") && !Path.GetExtension(Image.FileName).ToLower().Equals(".jpeg"))
                    {
                        ModelState.AddModelError("Image", "Please choose file type .png or .jpg or .jpeg");
                        return View(partner);
                    }
                    try
                    {
                        using (var binaryReader = new BinaryReader(Image.InputStream))
                        {
                            partner.Image = binaryReader.ReadBytes(Image.ContentLength);
                        }
                    }
                    catch (Exception)
                    {

                        throw;
                    }
                }
                partner.Status = 1;
                Data.DbConnect.Db.Partners.Add(partner);
                Data.DbConnect.Db.SaveChanges();
                return RedirectToAction("Index","Partner");
            }
            return View(partner);
        }

        // GET: Admin/Partner/Edit
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            var partners = Data.DbConnect.Db.Partners.Find(id);
            if (partners == null)
            {
                return HttpNotFound();
            }
            return View(partners);
        }

        //POST: Admim/Partner/Edit
        [HttpPost]
        public ActionResult Edit([Bind(Include = "PartnerId,Name,Email,Phone,Address,Status")] Partner partner, HttpPostedFileBase Image, int id)
        {
            var data = Data.DbConnect.Db.Partners.Where(c => c.PartnerId == id).FirstOrDefault();
            if (data == null)
            {
                return HttpNotFound();
            }
            if (ModelState.IsValid)
            {
                var pName = Data.DbConnect.Db.Partners.Where(p => p.Name.Equals(partner.Name, StringComparison.OrdinalIgnoreCase) && p.PartnerId != id).FirstOrDefault();
                if (pName != null)
                {
                    ModelState.AddModelError("Name", "Partner Name already exist");
                    return View(partner);
                }
                var pPhone = Data.DbConnect.Db.Partners.Where(p => p.Phone.Equals(partner.Phone) && p.PartnerId != id).FirstOrDefault();
                if (pPhone != null)
                {
                    ModelState.AddModelError("Phone", "Partner Phone already exist");
                    return View(partner);
                }
                var pEmail = Data.DbConnect.Db.Partners.Where(p => p.Email.Equals(partner.Email, StringComparison.OrdinalIgnoreCase) && p.PartnerId != id).FirstOrDefault();
                if (pEmail != null)
                {
                    ModelState.AddModelError("Email", "Partner Email already exist");
                    return View(partner);
                }
                if (Image != null && Image.ContentLength > 0)
                {
                    if (!Path.GetExtension(Image.FileName).ToLower().Equals(".png") && !Path.GetExtension(Image.FileName).ToLower().Equals(".jpg") && !Path.GetExtension(Image.FileName).ToLower().Equals(".jpeg"))
                    {
                        ModelState.AddModelError("Image", "Please choose file type .png or .jpg or .jpeg");
                        return View(partner);
                    }
                    try
                    {
                        using (var binaryReader = new BinaryReader(Image.InputStream))
                        {
                            partner.Image = binaryReader.ReadBytes(Image.ContentLength);
                        }
                    }
                    catch (Exception)
                    {

                        throw;
                    }
                }
                data.Name = partner.Name;
                data.Email = partner.Email;
                data.Phone = partner.Phone;
                data.Address = partner.Address;
                data.Image = partner.Image != null ? partner.Image : data.Image ;
                data.Status = 1;
                Data.DbConnect.Db.Entry(data).State = System.Data.Entity.EntityState.Modified;
                Data.DbConnect.Db.SaveChanges();
            }
            return RedirectToAction("Index", "Partner");
        }

        //GET: Admin/Partner/Delete
        [HttpGet]
        public ActionResult Delete(int? id)
        {
            var data = Data.DbConnect.Db.Partners.Find(id);
            if (data == null)
            {
                return HttpNotFound();
            }
            data.Status = 0;
            Data.DbConnect.Db.SaveChanges();
            return RedirectToAction("Index", "Partner");
        }
    }
}