using eSpaCenter.Models;
using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Text;

namespace eSpaCenter.Controllers
{
    public class KorisnikController : BaseCRUDController<Models.Korisnik, KorisnikSearchObject, KorisnikInsertRequest,KorisnikUpdateRequest>
    {
        public KorisnikController(IKorisnikService service) : base(service) { }

        [AllowAnonymous]
        public override Task<Korisnik> Insert([FromBody] KorisnikInsertRequest request)
        {
            return base.Insert(request);
        }
        [HttpPut("{id}/AddUloga")]
        [Authorize(Roles = "Administrator")]
        public Task<Korisnik> AddUloga(int id, [FromBody] KorisnikUpdateRequest request)
        {
            return ((IKorisnikService)_service).AddUloga(id, request);
        }
        [HttpPut("{id}/DeleteUloga")]
        [Authorize(Roles = "Administrator")]
        public Task<Korisnik> DeleteUloga(int id, [FromBody] KorisnikUpdateRequest request)
        {
            return ((IKorisnikService)_service).DeleteUloga(id, request);
        }

      
      
    }
}
 