using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services.Database
{
    public class Galerija
    {
        public int GalerijaID { get; set; }
        public byte[]? SlikaByte { get; set; }
        public string? Opis { get; set; }
        public int KorisnikID { get; set; }
        public bool isDeleted { get; set; }
        public virtual Korisnik Korisnik { get; set; } = null!;
    }
}
