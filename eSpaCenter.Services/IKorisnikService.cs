using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services
{
    public interface IKorisnikService : ICRUDService<Models.Korisnik, KorisnikSearchObject, KorisnikInsertRequest, KorisnikUpdateRequest>
    {
        Task<Models.Korisnik> Login(string username, string password);
        Task<Models.Korisnik> AddUloga(int id, KorisnikUpdateRequest request);
        Task<Models.Korisnik> DeleteUloga(int id, KorisnikUpdateRequest request);
    }
}
