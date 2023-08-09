using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models
{
    public class Galerija
    {
        public int GalerijaID { get; set; }
        public byte[] SlikaByte { get; set; }
        public string Opis { get; set; }
        public bool isDeleted { get; set; }


        public int KorisnikID { get; set; }
        public Korisnik Korisnik { get; set; }
    }
}
