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

        [HttpGet("Authenticate")]
        [AllowAnonymous]
        public async Task<Korisnik> Authenticate()
        {
            string authorization = HttpContext.Request.Headers["Authorization"];

            string encodedHeader = authorization["Basic ".Length..].Trim();

            Encoding encoding = Encoding.GetEncoding("iso-8859-1");
            string usernamePassword = encoding.GetString(Convert.FromBase64String(encodedHeader));

            int seperatorIndex = usernamePassword.IndexOf(':');

            return await ((IKorisnikService)_service).Login(usernamePassword.Substring(0, seperatorIndex), usernamePassword[(seperatorIndex + 1)..]);
        }

    }
}
 