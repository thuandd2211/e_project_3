using Microsoft.Ajax.Utilities;
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
    public class CampaignController : BaseController
    {
        //private readonly ngoEntities Db = new ngoEntities();
        //public CampaignController(ngoEntities Db)
        //{
        //    this.Db = Db;
        //}
        public List<Campaign_Detail> ListCampaign()
        {
            return Data.DbConnect.Db.Campaign_Detail.Include(c => c.Campaign).Include(c => c.Campaign.Category).ToList();
            //return Data.DbConnect.Db.Campaigns.Include(c => c.CategoryId).Include(c=>c.Campaign_Detail).ToList();
        }
        // GET: Admin/Campaign
        [HttpGet]
        public ActionResult Index(string currentFilter, string search, int? page)
        {
            var data = new List<Campaign_Detail>();
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
                data = ListCampaign().Where(c => c.Campaign.Name.ToLower().Contains(text) && c.Campaign.Status == 1).ToList();
            }
            else
            {
                data = ListCampaign().Where(c => c.Campaign.Status.Equals(1)).ToList();
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

        // GET: Admin/Campaign/Add
        [HttpGet]
        public ActionResult Add()
        {

            ViewBag.CateItem = new SelectList(Data.DbConnect.Db.Categories, "CategoryId", "Name");
            ViewBag.EmpItem = new SelectList(Data.DbConnect.Db.Employees, "EmpId", "Fullname");
            return View();
        }

        private bool Check(FormCollection form, DateTime? StartTime, DateTime? EndTime)
        {
            if (string.IsNullOrWhiteSpace(form["Name"]))
            {
                ModelState.AddModelError("Name", "Campaign Name can not be null");
            }
            string nameCheck = form["Name"];
            var campName = Data.DbConnect.Db.Campaigns.ToList().FirstOrDefault(c => c.Name.Equals(nameCheck) && c.Status == 1);
            if (campName != null)
            {
                ModelState.AddModelError("Name", "Campaign Name already exist");
            }
            if (StartTime == null)
            {
                ModelState.AddModelError("StartTime", "Start Time can not be null");
            }
            if (EndTime == null)
            {
                ModelState.AddModelError("EndTime", "End Time can not be null");
            }
            if (EndTime < StartTime)
            {
                ModelState.AddModelError("EndTime", "End Time must be greater than Start Time");
            }
            if (string.IsNullOrWhiteSpace(form["Location"]))
            {
                ModelState.AddModelError("Location", "Location can not be null");
            }
            return true;
        }

        // POST: Admin/Campaign/Add
        [HttpPost]
        public ActionResult Add([Bind(Include = "Camp_DeId,Title1,Script1,Title2,Script2,Title3,Script3,Title4,Script4,CampId")] Campaign_Detail campaign_Detail,
            FormCollection form, HttpPostedFileBase img1, HttpPostedFileBase img2, HttpPostedFileBase img3, HttpPostedFileBase img4, DateTime? StartTime, DateTime? EndTime)
        {
            ViewBag.CateItem = new SelectList(Data.DbConnect.Db.Categories, "CategoryId", "Name", form["Category"]);
            ViewBag.EmpItem = new SelectList(Data.DbConnect.Db.Employees, "EmpId", "Fullname", form["Employee"]);
            if (Check(form, StartTime, EndTime) && ModelState.IsValid)
            {
                campaign_Detail.Img1 = CheckImg(img1);
                campaign_Detail.Img2 = CheckImg(img2);
                campaign_Detail.Img3 = CheckImg(img3);
                campaign_Detail.Img4 = CheckImg(img4);
                Campaign camp = new Campaign();
                camp.Name = form["Name"];
                camp.StartTime = StartTime;
                camp.EndTime = EndTime;
                camp.Location = form["Location"];
                camp.CategoryId = Int32.Parse(form["Category"]);
                camp.EmpId = Int32.Parse(form["Employee"]);
                camp.Status = 1;
                Data.DbConnect.Db.Campaigns.Add(camp);
                Data.DbConnect.Db.SaveChanges();

                var campaign = Data.DbConnect.Db.Campaigns.ToList().Last().CampId;
                campaign_Detail.CampId = campaign;
                Data.DbConnect.Db.Campaign_Detail.Add(campaign_Detail);
                Data.DbConnect.Db.SaveChanges();
            }
            else
            {
                return View(campaign_Detail);
            }
            return RedirectToAction("Index", "Campaign");
        }


        // GET: Admin/Campaign/Edit
        [HttpGet]
        public ActionResult Edit(int? id)
        {
            var camp_Detail = Data.DbConnect.Db.Campaign_Detail.Find(id);
            ViewBag.CateItem = new SelectList(Data.DbConnect.Db.Categories, "CategoryId", "Name");
            ViewBag.EmpItem = new SelectList(Data.DbConnect.Db.Employees, "EmpId", "Fullname");
            if (camp_Detail == null)
            {
                return HttpNotFound();
            }
            ViewBag.Id = id;
            return View(camp_Detail);
        }

        //POST: Admin/Campaign/Edit
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Camp_DeId,Title1,Script1,Title2,Script2,Title3,Script3,Title4,Script4,CampId")] Campaign_Detail campaign_Detail,
    FormCollection form, HttpPostedFileBase img1, HttpPostedFileBase img2, HttpPostedFileBase img3, HttpPostedFileBase img4, DateTime? StartTime, DateTime? EndTime)
        {
            var data = Data.DbConnect.Db.Campaign_Detail.Find(campaign_Detail.Camp_DeId);
            ViewBag.CateItem = new SelectList(Data.DbConnect.Db.Categories, "CategoryId", "Name", form["Category"]);
            ViewBag.EmpItem = new SelectList(Data.DbConnect.Db.Employees, "EmpId", "Fullname", form["Employee"]);
            if (data == null)
            {
                return HttpNotFound();
            }

            if (ModelState.IsValid)
            {
                if (form == null)
                {
                    return View(campaign_Detail);
                }
                if (form["Name"] == null)
                {
                    ModelState.AddModelError("Name", "Campaign Name can not be null");
                    return View(campaign_Detail);
                }
                string nameCheck = form["Name"];
                var campName = Data.DbConnect.Db.Campaigns.ToList().FirstOrDefault(c => c.Name.Equals(nameCheck) && c.Status == 1 && c.CampId != campaign_Detail.CampId);
                if (campName != null)
                {
                    ModelState.AddModelError("Name", "Campaign Name already exist");
                    return View(campaign_Detail);
                }
                if (StartTime == null)
                {
                    ModelState.AddModelError("StartTime", "Start Time can not be null");
                    return View(campaign_Detail);
                }
                if (EndTime == null)
                {
                    ModelState.AddModelError("EndTime", "End Time can not be null");
                    return View(campaign_Detail);
                }
                if (EndTime < StartTime)
                {
                    ModelState.AddModelError("EndTime", "End Time must be greater than Start Time");
                    return View(campaign_Detail);
                }
                if (form["Location"] == null)
                {
                    ModelState.AddModelError("Location", "Location can not be null");
                    return View(campaign_Detail);
                }
                campaign_Detail.Img1 = CheckImg(img1);
                campaign_Detail.Img2 = CheckImg(img2);
                campaign_Detail.Img3 = CheckImg(img3);
                campaign_Detail.Img4 = CheckImg(img4);
                Campaign camp = Data.DbConnect.Db.Campaigns.Find(data.CampId);
                camp.Name = form["Name"];
                camp.StartTime = StartTime;
                camp.EndTime = EndTime;
                camp.Location = form["Location"];
                camp.CategoryId = Int32.Parse(form["Campaign.Category.CategoryId"]);
                camp.EmpId = Int32.Parse(form["Campaign.Employee.EmpId"]);
                camp.Status = 1;
                Data.DbConnect.Db.Entry(camp).State = System.Data.Entity.EntityState.Modified;
                Data.DbConnect.Db.SaveChanges();


                data.Title1 = campaign_Detail.Title1;
                data.Script1 = campaign_Detail.Script1;
                data.Img1 = campaign_Detail.Img1 != null ? campaign_Detail.Img1 : data.Img1;
                data.Title2 = campaign_Detail.Title2;
                data.Script2 = campaign_Detail.Script2;
                data.Img2 = campaign_Detail.Img2 != null ? campaign_Detail.Img2 : data.Img2;
                data.Title3 = campaign_Detail.Title3;
                data.Script3 = campaign_Detail.Script3;
                data.Img3 = campaign_Detail.Img3 != null ? campaign_Detail.Img3 : data.Img3;
                data.Title4 = campaign_Detail.Title4;
                data.Script4 = campaign_Detail.Script4;
                data.Img4 = campaign_Detail.Img4 != null ? campaign_Detail.Img4 : data.Img4;
                Data.DbConnect.Db.Entry(data).State = System.Data.Entity.EntityState.Modified;
                Data.DbConnect.Db.SaveChanges();
            }
            else
            {
                return View(campaign_Detail);
            }
            return RedirectToAction("Index", "Campaign");
        }

        // GET: Admin/Campaign/Delete
        [HttpGet]
        public ActionResult Delete(int? id)
        {
            var camp = Data.DbConnect.Db.Campaigns.Find(id);
            if (camp == null)
            {
                return HttpNotFound();
            }
            camp.Status = 0;
            Data.DbConnect.Db.SaveChanges();
            return RedirectToAction("Index", "Campaign");
        }


        // GET: Admin/Campaign/PartnerOfCampaign
        [HttpGet]
        public ActionResult PartnerOfCampaign(int? id, string currentFilter, string search, int? page)
        {
            var camp = Data.DbConnect.Db.Campaigns.ToList().Where(c => c.CampId == id && c.Status == 1).FirstOrDefault();
            if (camp == null)
            {
                return HttpNotFound();
            }

            var data = new List<REF_CAMP_PARTNER>();
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
                data = Data.DbConnect.Db.REF_CAMP_PARTNER.Include(x => x.Campaign).Include(x => x.Partner).ToList()
                    .Where(c => c.CampId == id && c.Campaign.Status == 1 && c.Campaign.Name.ToLower().Contains(text)).ToList();
            }
            else
            {
                data = Data.DbConnect.Db.REF_CAMP_PARTNER.Include(x => x.Campaign).Include(x => x.Partner).ToList()
                    .Where(x => x.CampId == id && x.Campaign.Status == 1).ToList();
            }
            ViewData["CurrentFilter"] = search;
            ViewData["CampId"] = id;
            int pageSize = 3;
            int pageNumber = page ?? 1;
            return View(data.ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult DeletePartnerOfCampaign(int? id, int? partnerId)
        {
            var camp = Data.DbConnect.Db.Campaigns.ToList().Where(c => c.CampId == id && c.Status == 1).FirstOrDefault();
            if (camp == null || partnerId == null)
            {
                return HttpNotFound();
            }

            var data = Data.DbConnect.Db.REF_CAMP_PARTNER.ToList().Where(c => c.CampId == id && c.PartnerId == partnerId).FirstOrDefault();
            if (data != null)
            {
                Data.DbConnect.Db.REF_CAMP_PARTNER.Remove(data);
                Data.DbConnect.Db.SaveChanges();
            }
            return RedirectToAction("PartnerOfCampaign", "Campaign", new { @id = id });
        }

        // GET: Admin/Campaign/AddPartnerToCampaign
        public ActionResult AddPartnerToCampaign(int? id, string currentFilter, string search, int? page)
        {
            var camp = Data.DbConnect.Db.Campaigns.ToList().Where(c => c.CampId == id && c.Status == 1).FirstOrDefault();
            if (camp == null)
            {
                return HttpNotFound();
            }

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
            ViewData["CampId"] = id;
            int pageSize = 5;
            int pageNumber = page ?? 1;
            return View(data.ToPagedList(pageNumber, pageSize));
        }

        [HttpGet]
        public ActionResult AddPartnerToCamp(int? id, int? partnerId)
        {
            var camp = Data.DbConnect.Db.Campaigns.ToList().Where(c => c.CampId == id && c.Status == 1).FirstOrDefault();
            if (camp == null || partnerId == null)
            {
                return HttpNotFound();
            }

            var data = Data.DbConnect.Db.REF_CAMP_PARTNER.ToList().Where(c => c.CampId == id && c.PartnerId == partnerId).FirstOrDefault();
            if (data == null)
            {
                REF_CAMP_PARTNER cp = new REF_CAMP_PARTNER();
                cp.CampId = (int)id;
                cp.PartnerId = (int)partnerId;
                cp.CurrentTime = DateTime.Now;
                Data.DbConnect.Db.REF_CAMP_PARTNER.Add(cp);
                Data.DbConnect.Db.SaveChanges();
            }
            return RedirectToAction("AddPartnerToCampaign", "Campaign", new { @id = id });
        }
    }
}