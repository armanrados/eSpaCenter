using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models
{
    public class Termin
    {
        [Browsable(false)]
        public int TerminID { get; set; }
        [DisplayName("Termin kod")]
        public string TerminZaposlenik => $"{Korisnik?.Ime} {Korisnik?.Prezime}";
        [DisplayName("Datum termina")]
        public DateTime DatumTermina { get; set; }
        [DisplayName("Datum kreiranja")]
        public DateTime DatumKreiranja { get; set; }
        [DisplayName("Vrijeme")]
        public string VrijemeTermina { get; set; }
        [Browsable(false)]
        public bool IsBooked { get; set; }
        [Browsable(false)]
        public int KorisnikID { get; set; }
        [Browsable(false)]
        public Korisnik Korisnik { get; set; }
    }
}
