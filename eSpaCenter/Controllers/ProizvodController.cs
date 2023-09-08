using Azure.Core;
using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;
using Microsoft.AspNetCore.Mvc;

namespace eSpaCenter.Controllers
{
    public class ProizvodController : BaseCRUDController<Models.Proizvod, ProizvodSearchObject, ProizvodInsertRequest,ProizvodUpdateRequest>
    {
        public ProizvodController(IProizvodService service) : base(service) { }

        [HttpGet("{id}/Recommended")]
        public List<Models.Proizvod> Recommend(int id)
        {
            return ((IProizvodService)_service).Recommend(id);
        }
      
    }
}
