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
        [Browsable(false)]
        public int GalerijaID { get; set; }
        [DisplayName("Dodao korisnik")]
        public string ZaposlenikIme => $"{Korisnik?.Ime} {Korisnik?.Prezime}";
        [DisplayName("Slika")]
        public byte[] SlikaByte { get; set; }
        public string Opis { get; set; }
        [Browsable(false)]
        public int KorisnikID { get; set; }
        [Browsable(false)]
        public Korisnik Korisnik { get; set; }
    }
}
