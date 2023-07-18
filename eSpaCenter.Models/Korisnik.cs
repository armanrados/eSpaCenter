using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models
{
    public class Korisnik
    {
        public int KorisnikID { get; set; }
        public string Ime { get; set; }
        public string Prezime { get; set; }
        public DateTime DatumRodjenja { get; set; }
        public string Email { get; set; }
        public string Telefon { get; set; }
        public string KorisnickoIme { get; set; }
        public string Uloge => string.Join(", ", KorisnikUlogas?.Select(x => x.Uloga?.Naziv)?.ToList());
        public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; set; }

    }
}
