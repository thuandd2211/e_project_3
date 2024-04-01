using Project_3.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Data.Entity;

namespace Project_3.Data
{
    public class DbConnect
    {
        public static ngoEntities Db = new ngoEntities();

        public static string Hash(string text)
        {
            MD5 md5 = MD5.Create();
            byte[] hash = md5.ComputeHash(Encoding.UTF8.GetBytes(text));
            StringBuilder hashSb = new StringBuilder();
            foreach (byte b in hash)
            {
                hashSb.Append(b.ToString("X2"));
            }
            return hashSb.ToString();
        }

        public static bool CheckPartnerInCamp(int campId, int partnerId)
        {
            return Db.REF_CAMP_PARTNER.ToList().Any(r => r.CampId == campId && r.PartnerId == partnerId);
        }

        public static List<REF_CAMP_PARTNER> REF_CAMP_(int? campId)
        {
            return Db.REF_CAMP_PARTNER.Include(x => x.Partner).ToList().Where(x => x.CampId == campId).ToList();
        }

        public static IEnumerable<Member> MemberList()
        {
            return Db.Members.Include(x => x.Business).ToList().Take(4);
        }
    }
}