using PagedList;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Project_3.Controllers
{
    public class CampaignController : Controller
    {
        // GET: Campaign
        public List<Campaign_Detail> ListCampaign()
        {
            return Data.DbConnect.Db.Campaign_Detail.Include(c => c.Campaign).Include(c => c.Campaign.Category).ToList();           
        }

        // GET: User/Campaign
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


        //GET: Campaign Detail
        public ActionResult Detail(int? id)
        {
            var data = Data.DbConnect.Db.Campaigns.ToList().Where(x => x.CampId == id && x.Status == 1).ToList();
            if (data == null)
            {
                return HttpNotFound();
            }
            var datalist = Data.DbConnect.Db.Campaign_Detail.Include(c => c.Campaign).ToList().FirstOrDefault(x => x.CampId == id);
            if (datalist == null)
            {
                return HttpNotFound();
            }
            return View(datalist);
        }
    }
}