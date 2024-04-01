using PagedList;
using Project_3.Data;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace Project_3.Areas.Admin.Controllers
{
    public class StatisticController : BaseController
    {
        // GET: Admin/Statistic
        public ActionResult Index(int? id, string currentFilter, string search, DateTime? currentF, DateTime? currentL, DateTime? FirstTime, DateTime? LastTime, int? page)
        {
            var data = new List<REF_FUND_CAMP_DONOR>();
            double total = 0;
            if (FirstTime != null || search != null)
            {
                page = 1;
            }
            else
            {
                FirstTime = currentF;
                LastTime = currentL;
                search = currentFilter;
            }
            if (!string.IsNullOrEmpty(search))
            {
                data = DbConnect.Db.REF_FUND_CAMP_DONOR.Where(x => x.Campaign.Name.ToLower().Contains(search.ToLower()) && x.FundId == id).ToList().OrderBy(x => x.Fund.Name).ToList();
                if (FirstTime != null)
                {
                    data = data.Where(x => x.CurrentTime >= FirstTime && x.FundId == id).ToList().OrderBy(x => x.Fund.Name).ToList();
                    if (LastTime != null && LastTime > FirstTime)
                    {
                        data = data.Where(x => x.CurrentTime < LastTime).ToList().OrderBy(x => x.Fund.Name).ToList();
                    }
                }
            }
            else
            {
                data = DbConnect.Db.REF_FUND_CAMP_DONOR.Where(x => x.FundId == id).ToList();
                if (FirstTime != null)
                {
                    data = data.Where(x => x.CurrentTime >= FirstTime && x.FundId == id).ToList().OrderBy(x => x.Fund.Name).ToList();
                    if (LastTime != null && LastTime > FirstTime)
                    {
                        data = data.Where(x => x.CurrentTime < LastTime).ToList().OrderBy(x => x.Fund.Name).ToList();
                    }
                }
            }
            var fundName = DbConnect.Db.Funds.ToList().FirstOrDefault(f => f.FundId == id).Name;
            int pageSize = 7;
            int pageNumber = page ?? 1;
            total = (double)data.ToPagedList(pageNumber, pageSize).Sum(x => x.Amount);
            ViewData["FundName"] = fundName;
            ViewData["CampName"] = search;
            ViewData["FirstTime"] = FirstTime?.ToString("yyyy-MM-ddTHH:mm:ss");
            ViewData["LastTime"] = LastTime?.ToString("yyyy-MM-ddTHH:mm:ss");
            ViewData["Total"] = total;
            return View(data.ToPagedList(pageNumber, pageSize));
        }

        // GET: Donor
        public ActionResult Donor(string currentFilter, string search, int? page)
        {
            var data = new List<Donor>();
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
                data = DbConnect.Db.Donors.Where(c => c.Fullname.ToLower().Contains(search.ToLower())).ToList();
            }
            else
            {
                data = DbConnect.Db.Donors.ToList();
            }
            ViewData["CurrentFilter"] = search;
            int pageSize = 7;
            int pageNumber = page ?? 1;
            return View(data.ToPagedList(pageNumber, pageSize));
        }

        // GET: Donor/Detail
        public ActionResult Detail(int? id, string currentFilter, string search, DateTime? currentF, DateTime? currentL, DateTime? FirstTime, DateTime? LastTime, int? page)
        {
            var data = new List<REF_FUND_CAMP_DONOR>();
            double total = 0;
            if (FirstTime != null || search != null)
            {
                page = 1;
            }
            else
            {
                FirstTime = currentF;
                LastTime = currentL;
                search = currentFilter;
            }
            if (!string.IsNullOrEmpty(search))
            {
                data = DbConnect.Db.REF_FUND_CAMP_DONOR.Where(x => x.Campaign.Name.ToLower().Contains(search.ToLower()) && x.DonorId == id).ToList().OrderBy(x => x.Fund.Name).ToList();
                if (FirstTime != null)
                {
                    data = data.Where(x => x.CurrentTime >= FirstTime && x.DonorId == id).ToList().OrderBy(x => x.Fund.Name).ToList();
                    if (LastTime != null && LastTime > FirstTime)
                    {
                        data = data.Where(x => x.CurrentTime < LastTime).ToList().OrderBy(x => x.Fund.Name).ToList();
                    }
                }
            }
            else
            {
                data = DbConnect.Db.REF_FUND_CAMP_DONOR.Where(x => x.DonorId == id).ToList();
                if (FirstTime != null)
                {
                    data = data.Where(x => x.CurrentTime >= FirstTime && x.DonorId == id).ToList();
                    if (LastTime != null && LastTime > FirstTime)
                    {
                        data = data.Where(x => x.CurrentTime < LastTime).ToList().OrderBy(x => x.Fund.Name).ToList();
                    }
                }
            }

            int pageSize = 3;
            int pageNumber = page ?? 1;
            total = (double)data.ToPagedList(pageNumber, pageSize).Sum(x => x.Amount);
            ViewData["CampName"] = search;
            ViewData["FirstTime"] = FirstTime?.ToString("yyyy-MM-ddTHH:mm:ss");
            ViewData["LastTime"] = LastTime?.ToString("yyyy-MM-ddTHH:mm:ss");
            ViewData["Total"] = total;
            return View(data.ToPagedList(pageNumber, pageSize));
        }
    }
}