using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class ProizvodController : BaseCRUDController<Models.Proizvod, ProizvodSearchObject, ProizvodInsertRequest,ProizvodUpdateRequest>
    {
        public ProizvodController(IProizvodService service) : base(service) { }
    }
}
