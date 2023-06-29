using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class NovostiController : BaseCRUDController<Models.Novosti, NovostiSearchObject, NovostiInsertRequest, NovostiUpdateRequest>
    {

        public NovostiController(INovostiService service) : base(service) { }
    }
}
