using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Models
{
    public class Rezervacija
    {
        [Browsable(false)]
        public int RezervacijaID { get; set; }
        [Browsable(false)]
        public int KorisnikID { get; set; }
        [Browsable(false)]
        public int TerminID { get; set; }
        [Browsable(false)]
        public int UslugaID { get; set; }
        [DisplayName("Termin rezervisao")]
        public string TerminRezervisao => $"{Korisnik?.Ime} {Korisnik?.Prezime}";
        [DisplayName("Datum termina")]
        public string TerminVrijeme => $"{Termin?.DatumTermina.Date}, {Termin?.VrijemeTermina}";
        [DisplayName("Datum rezervacije")]
        public DateTime DatumRezervacije { get; set; }
        [DisplayName("Vrsta usluge")]
        public string VrstaUsluge => Usluga?.Naziv;
        [DisplayName("Termin kod zaposlenika")]
        public string TerminKodZaposlenika => $"{Termin?.Korisnik?.Ime} {Termin?.Korisnik?.Prezime}";
        [DisplayName("Otkazano")]
        public bool IsCanceled { get; set; }
        [DisplayName("Završeno")]
        public bool IsCompleted { get; set; }
        [Browsable(false)]
        public virtual Korisnik Korisnik { get; set; }
        [Browsable(false)]
        public virtual Termin Termin { get; set; }
        [Browsable(false)]
        public virtual Usluga Usluga { get; set; }
    }
}
