using Project_3.Data;
using Project_3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Mvc;

namespace Project_3.Controllers
{
    public class DonateController : Controller
    {
        // GET: Donate
        public ActionResult Index()
        {
            Session["Donate"] = "Donate";
            ViewBag.CampItem = new SelectList(Data.DbConnect.Db.Campaigns, "CampId", "Name");
            ViewBag.FundItem = new SelectList(Data.DbConnect.Db.Funds, "FundId", "Name");
            if (Session["DonorId"] == null)
            {
                return RedirectToAction("Index","Login");
            }
            
            return View();           
        }


        private bool CheckValidation(FormCollection form)
        {
            if (String.IsNullOrEmpty(form["Amount"]) && form["opt"] == null)
            {              
                ModelState.AddModelError("Amount", "Please Enter The Amount");
            }
            if (!Regex.IsMatch(form["Amount"],@"^[0-9]*(?:\.[0-9]*)?$"))
            {
                ModelState.AddModelError("Amount", "The Amount is invalid. Example: 12.5");
            }
            if (string.IsNullOrEmpty(form["CreditNumber"]))
            {
                ModelState.AddModelError("CreditNumber", "Please Enter CreditNumber");
            }
            if (string.IsNullOrEmpty(form["ExpDate"]))
            {
                ModelState.AddModelError("ExpDate", "Please Enter ExpDate");
            }
            if (string.IsNullOrEmpty(form["CVV"]))
            {
                ModelState.AddModelError("CVV", "Please Enter CVV");
            }
            if (string.IsNullOrEmpty(form["CardName"]))
            {
                ModelState.AddModelError("CardName", "Please Enter CardName");
            }
            return true;
        }
        // POST: Add
        [HttpPost]
        public ActionResult Index(FormCollection form)
        {
            ViewBag.CampItem = new SelectList(Data.DbConnect.Db.Campaigns, "CampId", "Name");
            ViewBag.FundItem = new SelectList(Data.DbConnect.Db.Funds, "FundId", "Name");
            int donorId = Int32.Parse(Session["DonorId"].ToString());
            var donate = new REF_FUND_CAMP_DONOR();
            if (CheckValidation(form) && ModelState.IsValid)
            {
                donate.Amount = !string.IsNullOrEmpty(form["Amount"]) ? Double.Parse(form["Amount"])  : Double.Parse(form["opt"].ToString());
                donate.CampId = Int32.Parse(form["CampId"]);
                donate.FundId = Int32.Parse(form["FundId"]);
                donate.DonorId = donorId;
                donate.CurrentTime = DateTime.Now;
                Data.DbConnect.Db.REF_FUND_CAMP_DONOR.Add(donate);
                Data.DbConnect.Db.SaveChanges();
            }
            else
            {
                return View(donate);
            }
            return RedirectToAction("Index", "Donate");
        }
    }
}