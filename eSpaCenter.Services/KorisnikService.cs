using AutoMapper;
using eSpaCenter.Models;
using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services.Database;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;


namespace eSpaCenter.Services
{
    public class KorisnikService : BaseCRUDService<Models.Korisnik, Database.Korisnik, KorisnikSearchObject,KorisnikInsertRequest,KorisnikUpdateRequest>, IKorisnikService
    {
        public KorisnikService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) { }

        
        public override IQueryable<Database.Korisnik> AddInclude(IQueryable<Database.Korisnik> entity, KorisnikSearchObject obj)
        {
            if (obj.IncludeUloge == true)
            {
                entity = entity.Include("KorisnikUlogas.Uloga");
            }

            return entity;
        }
        public override IQueryable<Database.Korisnik> AddFilter(IQueryable<Database.Korisnik> entity, KorisnikSearchObject obj)
        {
            if (!string.IsNullOrWhiteSpace(obj.Ime))
            {
                entity = entity.Where(x => x.Ime.ToLower().StartsWith(obj.Ime.ToLower()));
            }

            if (!string.IsNullOrWhiteSpace(obj.Prezime))
            {
                entity = entity.Where(x => x.Prezime.ToLower().StartsWith(obj.Prezime.ToLower()));
            }

            if (!string.IsNullOrWhiteSpace(obj.KorisnickoIme))
            {
                entity = entity.Where(x => x.KorisnickoIme.StartsWith(obj.KorisnickoIme));
            }

            return entity;
        }
        public override async Task BeforeInsert(Database.Korisnik entity ,KorisnikInsertRequest insert)
        {
            var salt = GenerateSalt();
            var hash = GenerateHash(salt, insert.Lozinka);
            entity.LozinkaSalt = salt;
            entity.LozinkaHash = hash;
        }
        public static string GenerateSalt()
        {
            RNGCryptoServiceProvider provider = new RNGCryptoServiceProvider();
            var byteArray = new byte[16];
            provider.GetBytes(byteArray);


            return Convert.ToBase64String(byteArray);
        }

        public static string GenerateHash(string salt, string password)
        {
            byte[] src = Convert.FromBase64String(salt);
            byte[] bytes = Encoding.Unicode.GetBytes(password);
            byte[] dst = new byte[src.Length + bytes.Length];

            System.Buffer.BlockCopy(src, 0, dst, 0, src.Length);
            System.Buffer.BlockCopy(bytes, 0, dst, src.Length, bytes.Length);

            HashAlgorithm algorithm = HashAlgorithm.Create("SHA1");
            byte[] inArray = algorithm.ComputeHash(dst);
            return Convert.ToBase64String(inArray);
        }
        public async Task<Models.Korisnik> Login(string username, string password)
        {
            var entity = await _db.Korisniks.Include("KorisnikUlogas.Uloga").FirstOrDefaultAsync(x => x.KorisnickoIme == username);

            if (entity == null) { throw new Exception("Korisnik ne postoji"); }

            var hash = GenerateHash(entity.LozinkaSalt, password);

            if (entity.LozinkaHash != hash) { throw new Exception("Pogrešna lozinka"); }

            return _mapper.Map<Models.Korisnik>(entity);
        }
        public async Task<Models.Korisnik> AddUloga(int id, KorisnikUpdateRequest request)
        {
            var entity = await _db.Korisniks.Include("KorisnikUlogas.Uloga").FirstOrDefaultAsync(x => x.KorisnikID == id);
            var uloga = await _db.Ulogas.FirstOrDefaultAsync(x => x.Naziv.ToLower() == request.Uloga);

            Database.KorisnikUloga nova = new Database.KorisnikUloga()
            {
                DatumIzmjene = DateTime.Now,
                KorisnikID = id,
                UlogaID = uloga.UlogaID
            };
           await _db.KorisnikUlogas.AddAsync(nova);
           await _db.SaveChangesAsync();

            return _mapper.Map<Models.Korisnik>(entity);
        }
        public async Task<Models.Korisnik> DeleteUloga(int id, KorisnikUpdateRequest request)
        {
            var entity = await _db.Korisniks.Include("KorisnikUlogas.Uloga").FirstOrDefaultAsync(x => x.KorisnikID == id);
            var uloga = await _db.Ulogas.FirstOrDefaultAsync(x => x.Naziv.ToLower() == request.Uloga);
            var korisnikUloga = await _db.KorisnikUlogas.FirstOrDefaultAsync(x => x.KorisnikID == entity.KorisnikID && x.UlogaID == uloga.UlogaID);

            _db.KorisnikUlogas.Remove(korisnikUloga);
            await _db.SaveChangesAsync();

            return _mapper.Map<Models.Korisnik>(entity);
        }
    }
}
