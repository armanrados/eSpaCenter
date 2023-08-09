using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models.Requests
{
    public class NovostiInsertRequest
    {
        [Required(AllowEmptyStrings = false, ErrorMessage = "Naslov je obavezan!")]
        public string Naslov { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Sadrzaj je obavezan!")]
        public string Sadrzaj { get; set; }
        [Required(ErrorMessage = "Slika je obavezna!")]
        public byte[] Slika { get; set; }
        public bool isDeleted { get; set; }


        public int KorisnikID { get; set; }




    }
}
