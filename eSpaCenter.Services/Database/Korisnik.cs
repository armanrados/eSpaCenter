using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services.Database
{
    public class Korisnik
    {
        public int KorisnikID { get; set; }
        public string Ime { get; set; } = null!;
        public string Prezime { get; set; } = null!;
        public DateTime DatumRodjenja { get; set; }
        public string? Email { get; set; }
        public string? Telefon { get; set; }
        public string KorisnickoIme { get; set; } = null!;
        public string LozinkaHash { get; set; } = null!;
        public string LozinkaSalt { get; set; } = null!;

        public virtual ICollection<KorisnikUloga> KorisnikUlogas { get; set; }
    }
}
