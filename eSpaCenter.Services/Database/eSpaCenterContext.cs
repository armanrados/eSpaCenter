using eSpaCenter.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace eSpaCenter.Services.Database
{
    public class eSpaCenterContext : DbContext
    {
        public eSpaCenterContext()
        {
        }

        public eSpaCenterContext(DbContextOptions<eSpaCenterContext> options):base(options)
        {
        }

        public virtual DbSet<Korisnik> Korisniks { get; set; } = null!;
        public virtual DbSet<KorisnikUloga> KorisnikUlogas { get; set; } = null!;
        public virtual DbSet<Narudzba> Narudzbas { get; set; } = null!;
        public virtual DbSet<NarudzbaProizvodi> NarudzbaProizvodis { get; set; } = null!;
        public virtual DbSet<Novosti> Novostis { get; set; } = null!;
        public virtual DbSet<Proizvod> Proizvods { get; set; } = null!;
        public virtual DbSet<Recenzija> Recenzijas { get; set; } = null!;
        public virtual DbSet<Rezervacija> Rezervacijas { get; set; } = null!;
        public virtual DbSet<Galerija> Galerijas { get; set; } = null!;
        public virtual DbSet<Termin> Termins { get; set; } = null!;
        public virtual DbSet<Uloga> Ulogas { get; set; } = null!;
        public virtual DbSet<Usluga> Uslugas { get; set; } = null!;
        public virtual DbSet<VrstaProizvoda> VrstaProizvodas { get; set; } = null!;
        public virtual DbSet<Uplata> Uplatas { get; set; } = null!;

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (!optionsBuilder.IsConfigured)
            {
                optionsBuilder.UseSqlServer("Data Source=localhost;Initial Catalog=eSpaCenterDB;Trusted_Connection=true;MultipleActiveResultSets=true;");
            }
        }
        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            var saltAdmin = KorisnikService.GenerateSalt();
            var saltZaposlenik = KorisnikService.GenerateSalt();
            var saltZaposlenik2 = KorisnikService.GenerateSalt();
            var saltUser = KorisnikService.GenerateSalt();
            var saltUser2 = KorisnikService.GenerateSalt();

            

            modelBuilder.Entity<Uloga>().HasData(
                new Uloga { UlogaID = 1, Naziv = "Administrator", Opis = "Administrator" },
                new Uloga { UlogaID = 2, Naziv = "Zaposlenik", Opis = "Zaposlenik" }
                );

            modelBuilder.Entity<Korisnik>().HasData(
                new Korisnik { KorisnikID = 1, Ime = "Admin", Prezime = "Admin", DatumRodjenja = DateTime.Now, Email = "admin@gmail.com", KorisnickoIme = "admin", Telefon = "000000000", LozinkaSalt = saltAdmin, LozinkaHash = KorisnikService.GenerateHash(saltAdmin, "admin") },
                new Korisnik { KorisnikID = 2, Ime = "Zaposlenik", Prezime = "Zaposlenik", DatumRodjenja = DateTime.Now, Email = "zaposlenik@gmail.com", KorisnickoIme = "zaposlenik", Telefon = "000000001", LozinkaSalt = saltZaposlenik, LozinkaHash = KorisnikService.GenerateHash(saltZaposlenik, "zaposlenik") },
                new Korisnik { KorisnikID = 3, Ime = "User", Prezime = "User", DatumRodjenja = DateTime.Now,  Email = "user@gmail.com", KorisnickoIme = "user", Telefon = "000000002", LozinkaSalt = saltUser, LozinkaHash = KorisnikService.GenerateHash(saltUser, "user") },
                new Korisnik { KorisnikID = 4, Ime = "Zaposlenik2", Prezime = "Zaposlenik2", DatumRodjenja = DateTime.Now,  Email = "zaposlenik2@gmail.com", KorisnickoIme = "zaposlenik2", Telefon = "000000003", LozinkaSalt = saltZaposlenik2, LozinkaHash = KorisnikService.GenerateHash(saltZaposlenik2, "zaposlenik2") },
                new Korisnik { KorisnikID = 5, Ime = "User2", Prezime = "User2", DatumRodjenja = DateTime.Now,  Email = "user2@gmail.com", KorisnickoIme = "user2", Telefon = "000000002", LozinkaSalt = saltUser2, LozinkaHash = KorisnikService.GenerateHash(saltUser2, "user2") }

                );

            modelBuilder.Entity<KorisnikUloga>().HasData(
                new KorisnikUloga { KorisnikUlogaID = 1, DatumIzmjene = DateTime.Now, KorisnikID = 1, UlogaID = 1 },
                new KorisnikUloga { KorisnikUlogaID = 2, DatumIzmjene = DateTime.Now, KorisnikID = 1, UlogaID = 2 },
                new KorisnikUloga { KorisnikUlogaID = 3, DatumIzmjene = DateTime.Now, KorisnikID = 2, UlogaID = 2 },
                new KorisnikUloga { KorisnikUlogaID = 4, DatumIzmjene = DateTime.Now, KorisnikID = 4, UlogaID = 2 }
                );

            modelBuilder.Entity<VrstaProizvoda>().HasData(
                new VrstaProizvoda { VrstaProizvodaID = 1, Naziv = "Lak", Opis = "Lak" },
                new VrstaProizvoda { VrstaProizvodaID = 2, Naziv = "Losion", Opis = "Losion" },
                new VrstaProizvoda { VrstaProizvodaID = 3, Naziv = "Vosak", Opis = "Vosak" },
                new VrstaProizvoda { VrstaProizvodaID = 4, Naziv = "Cetkice", Opis = "Cetkice" }
                );

            modelBuilder.Entity<Recenzija>().HasData(
                new Recenzija { RecenzijaID = 1, DatumKreiranja = DateTime.Now, KorisnikID = 3, Ocjena = 4, SadrzajRecenzije = "Ovo je sadrzaj recenzije koju je napisao korisnik pod imenom User" }
            );
            modelBuilder.Entity<Proizvod>().HasData(
                new Proizvod { ProizvodID = 1, Cijena = 16, Naziv = "Lak ljubicasti", VrstaProizvodaID = 1, Sifra = Guid.NewGuid().ToString(), Slika = Convert.FromBase64String(Images.Images.Slike[0]), Opis = "Opis proizvoda" },
                new Proizvod { ProizvodID = 2, Cijena = 25, Naziv = "Losion sivi", VrstaProizvodaID = 2, Sifra = Guid.NewGuid().ToString(), Slika = Convert.FromBase64String(Images.Images.Slike[1]), Opis = "Opis proizvoda" },
                new Proizvod { ProizvodID = 3, Cijena = 40, Naziv = "Vosak za depilaciju", VrstaProizvodaID = 3, Sifra = Guid.NewGuid().ToString(), Slika = Convert.FromBase64String(Images.Images.Slike[2]), Opis = "Opis proizvoda" },
                new Proizvod { ProizvodID = 4, Cijena = 10, Naziv = "Cetkica za obrve", VrstaProizvodaID = 4, Sifra = Guid.NewGuid().ToString(), Slika = Convert.FromBase64String(Images.Images.Slike[3]), Opis = "Opis proizvoda" },
                new Proizvod { ProizvodID = 5, Cijena = 16, Naziv = "Lak crveni", VrstaProizvodaID = 1, Sifra = Guid.NewGuid().ToString(), Slika = Convert.FromBase64String(Images.Images.Slike[4]), Opis = "Opis proizvoda" },
                new Proizvod { ProizvodID = 6, Cijena = 30, Naziv = "Cetkica za ciscenje", VrstaProizvodaID = 4, Sifra = Guid.NewGuid().ToString(), Slika = Convert.FromBase64String(Images.Images.Slike[5]), Opis = "Opis proizvoda" },
                new Proizvod { ProizvodID = 7, Cijena = 40, Naziv = "Vosak topljeni", VrstaProizvodaID = 3, Sifra = Guid.NewGuid().ToString(), Slika = Convert.FromBase64String(Images.Images.Slike[6]), Opis = "Opis proizvoda" },
                new Proizvod { ProizvodID = 8, Cijena = 25, Naziv = "Losion plavi", VrstaProizvodaID = 2, Sifra = Guid.NewGuid().ToString(), Slika = Convert.FromBase64String(Images.Images.Slike[7]), Opis = "Opis proizvoda" },
                new Proizvod { ProizvodID = 9, Cijena = 16, Naziv = "Lak zuti", VrstaProizvodaID = 1, Sifra = Guid.NewGuid().ToString(), Slika = Convert.FromBase64String(Images.Images.Slike[8]), Opis = "Opis proizvoda" }
                );

            modelBuilder.Entity<Termin>().HasData(
                new Termin { TerminID = 1, KorisnikID = 2, DatumKreiranja = DateTime.Now, DatumTermina = DateTime.Parse("01/08/2023"), VrijemeTermina = "12:00" },
                new Termin { TerminID = 2, KorisnikID = 2, DatumKreiranja = DateTime.Now, DatumTermina = DateTime.Parse("02/08/2023"), VrijemeTermina = "13:00" },
                new Termin { TerminID = 3, KorisnikID = 2, DatumKreiranja = DateTime.Now, DatumTermina = DateTime.Parse("03/08/2023"), VrijemeTermina = "14:00" },
                new Termin { TerminID = 4, KorisnikID = 4, DatumKreiranja = DateTime.Now, DatumTermina = DateTime.Parse("01/09/2023"), VrijemeTermina = "13:00" },
                new Termin { TerminID = 5, KorisnikID = 4, DatumKreiranja = DateTime.Now, DatumTermina = DateTime.Parse("02/09/2023"), VrijemeTermina = "14:00" },
                new Termin { TerminID = 6, KorisnikID = 4, DatumKreiranja = DateTime.Now, DatumTermina = DateTime.Parse("03/09/2023"), VrijemeTermina = "15:00" },
                new Termin { TerminID = 7, KorisnikID = 2, DatumKreiranja = DateTime.Now, DatumTermina = DateTime.Parse("01/10/2023"), VrijemeTermina = "16:00", IsBooked = true },
                new Termin { TerminID = 8, KorisnikID = 4, DatumKreiranja = DateTime.Now, DatumTermina = DateTime.Parse("01/10/2023"), VrijemeTermina = "10:00", IsBooked = true }
                );

            modelBuilder.Entity<Rezervacija>().HasData(
                new Rezervacija { RezervacijaID = 1, DatumRezervacije = DateTime.Now, IsCompleted = true, IsCanceled = false, KorisnikID = 3, TerminID = 7, UslugaID = 1 },
                new Rezervacija { RezervacijaID = 2, DatumRezervacije = DateTime.Now, IsCompleted = false, IsCanceled = false, KorisnikID = 5, TerminID = 8, UslugaID = 2 }
            );
            modelBuilder.Entity<Novosti>().HasData(
            new Novosti { NovostiID = 1, DatumKreiranja = DateTime.Now, KorisnikID = 2, Naslov = "Novost 1", Sadrzaj = "Ovo je sadrzaj prve novosti", Slika = Convert.FromBase64String(Images.Images.Slike2[0]) }
           
            );
            modelBuilder.Entity<Galerija>().HasData(
                new Galerija { GalerijaID = 1, KorisnikID = 2, Opis = "Slika 1", SlikaByte = Convert.FromBase64String(Images.Images.Slike2[0]) }
              
                );

            modelBuilder.Entity<Usluga>().HasData(
                new Usluga { UslugaID = 1, Naziv = "Madero", Opis = "Madero terapija" },
                new Usluga { UslugaID = 2, Naziv = "Solarij", Opis = "Solarij kvarcanje" },
                new Usluga { UslugaID = 3, Naziv = "Masaza", Opis = "Masaza cijelog tijela" },
                new Usluga { UslugaID = 4, Naziv = "Depilacija", Opis = "Depilacija cijelog tijela" },
                new Usluga { UslugaID = 5, Naziv = "Manikura", Opis = "Manikura ruku" },
                new Usluga { UslugaID = 6, Naziv = "Pedikura", Opis = "Pedikura nogu" }


                );

            modelBuilder.Entity<Uplata>().HasData(
                new Uplata { UplataID = 1, BrojTransakcije = "pi_3MSSv3ANnFXjgSPx2LOrScMr", DatumTransakcije = DateTime.Now, Iznos = 146 },
                new Uplata { UplataID = 2, BrojTransakcije = "pi_3MSSwtANnFXjgSPx1GLV7ZWR", DatumTransakcije = DateTime.Now, Iznos = 196 },
                new Uplata { UplataID = 3, BrojTransakcije = "pi_3MSSxZANnFXjgSPx1h6sZONh", DatumTransakcije = DateTime.Now, Iznos = 122 },
                new Uplata { UplataID = 4, BrojTransakcije = "pi_3MSSykANnFXjgSPx0j7dwFvL", DatumTransakcije = DateTime.Now, Iznos = 132 },
                new Uplata { UplataID = 5, BrojTransakcije = "pi_3MSSzFANnFXjgSPx1K5yB3MP", DatumTransakcije = DateTime.Now, Iznos = 148 },
                new Uplata { UplataID = 6, BrojTransakcije = "pi_3MSSzgANnFXjgSPx30vUfLBv", DatumTransakcije = DateTime.Now, Iznos = 136 },
                new Uplata { UplataID = 7, BrojTransakcije = "pi_3MST02ANnFXjgSPx28dm4Ke1", DatumTransakcije = DateTime.Now, Iznos = 66 }
                );

            modelBuilder.Entity<Narudzba>().HasData(
                new Narudzba { NarudzbaID = 1, BrojNarudzbe = Guid.NewGuid().ToString(), DatumNarudzbe = DateTime.Now, IsCanceled = false, IsShipped = true, KorisnikID = 3, UplataID = 1 },
                new Narudzba { NarudzbaID = 2, BrojNarudzbe = Guid.NewGuid().ToString(), DatumNarudzbe = DateTime.Now, IsCanceled = false, IsShipped = true, KorisnikID = 3, UplataID = 2 },
                new Narudzba { NarudzbaID = 3, BrojNarudzbe = Guid.NewGuid().ToString(), DatumNarudzbe = DateTime.Now, IsCanceled = false, IsShipped = false, KorisnikID = 3, UplataID = 3 },
                new Narudzba { NarudzbaID = 4, BrojNarudzbe = Guid.NewGuid().ToString(), DatumNarudzbe = DateTime.Now, IsCanceled = false, IsShipped = false, KorisnikID = 5, UplataID = 4 },
                new Narudzba { NarudzbaID = 5, BrojNarudzbe = Guid.NewGuid().ToString(), DatumNarudzbe = DateTime.Now, IsCanceled = false, IsShipped = true, KorisnikID = 5, UplataID = 5 },
                new Narudzba { NarudzbaID = 6, BrojNarudzbe = Guid.NewGuid().ToString(), DatumNarudzbe = DateTime.Now, IsCanceled = false, IsShipped = true, KorisnikID = 5, UplataID = 6 },
                new Narudzba { NarudzbaID = 7, BrojNarudzbe = Guid.NewGuid().ToString(), DatumNarudzbe = DateTime.Now, IsCanceled = false, IsShipped = false, KorisnikID = 3, UplataID = 7 }
                );

            modelBuilder.Entity<NarudzbaProizvodi>().HasData(
                new NarudzbaProizvodi { NarudzbaProizvodiID = 1, NarudzbaID = 1, ProizvodID = 1, Kolicina = 2 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 2, NarudzbaID = 1, ProizvodID = 4, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 3, NarudzbaID = 1, ProizvodID = 9, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 4, NarudzbaID = 2, ProizvodID = 1, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 5, NarudzbaID = 2, ProizvodID = 2, Kolicina = 2 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 6, NarudzbaID = 2, ProizvodID = 7, Kolicina = 2 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 7, NarudzbaID = 2, ProizvodID = 9, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 8, NarudzbaID = 3, ProizvodID = 2, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 9, NarudzbaID = 3, ProizvodID = 1, Kolicina = 3 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 10, NarudzbaID = 3, ProizvodID = 6, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 11, NarudzbaID = 3, ProizvodID = 3, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 12, NarudzbaID = 4, ProizvodID = 1, Kolicina = 3 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 13, NarudzbaID = 4, ProizvodID = 2, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 14, NarudzbaID = 4, ProizvodID = 3, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 15, NarudzbaID = 4, ProizvodID = 7, Kolicina = 2 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 17, NarudzbaID = 5, ProizvodID = 8, Kolicina = 3 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 18, NarudzbaID = 5, ProizvodID = 9, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 19, NarudzbaID = 5, ProizvodID = 3, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 20, NarudzbaID = 5, ProizvodID = 6, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 21, NarudzbaID = 6, ProizvodID = 5, Kolicina = 3 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 22, NarudzbaID = 6, ProizvodID = 2, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 23, NarudzbaID = 6, ProizvodID = 1, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 24, NarudzbaID = 6, ProizvodID = 4, Kolicina = 1 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 25, NarudzbaID = 7, ProizvodID = 1, Kolicina = 2 },
                new NarudzbaProizvodi { NarudzbaProizvodiID = 26, NarudzbaID = 7, ProizvodID = 2, Kolicina = 1 }
                );
        }

    }
}
