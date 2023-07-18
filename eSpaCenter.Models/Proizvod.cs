using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models
{
    public class Proizvod
    {
        
        public int ProizvodID { get; set; }
        public string? Naziv { get; set; }
        public string Sifra { get; set; }
        public decimal Cijena { get; set; }
        public string Opis { get; set; }
        public byte[] Slika { get; set; }
       
        public int VrstaProizvodaID { get; set; }
       
        public virtual VrstaProizvoda VrstaProizvoda { get; set; }
        [DisplayName("Vrsta proizvoda")]
        public string VrstaProizvodaNaziv => VrstaProizvoda?.Naziv;
    }
}
