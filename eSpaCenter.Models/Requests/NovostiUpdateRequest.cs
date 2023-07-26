using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class NovostiUpdateRequest
    {
        public string Naslov { get; set; }
        public string Sadrzaj { get; set; }
        public byte[] Slika { get; set; }
        public int KorisnikID { get; set; }



    }
}
