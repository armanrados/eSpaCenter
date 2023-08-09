using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services.Database
{
    public class Novosti
    {
        public int NovostiID { get; set; }
        public string? Naslov { get; set; }
        public string? Sadrzaj { get; set; }
        public byte[]? Slika { get; set; }
        public DateTime DatumKreiranja { get; set; }
        public int KorisnikID { get; set; }
        public bool isDeleted { get; set; }


        public virtual Korisnik Korisnik { get; set; } = null!;
    }
}
