using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services.Database
{
    public class Proizvod
    {
        public int ProizvodID { get; set; }
        public string? Naziv { get; set; }
        public string? Sifra { get; set; }
        public float Cijena { get; set; }
        public byte[]? Slika { get; set; }
        public string? Opis { get; set; }
        public int VrstaProizvodaID { get; set; }
        public bool isDeleted { get; set; }


        public virtual VrstaProizvoda VrstaProizvoda { get; set; } = null!;
        public virtual ICollection<NarudzbaProizvodi> NarudzbaProizvodis { get; set; }

    }
}
