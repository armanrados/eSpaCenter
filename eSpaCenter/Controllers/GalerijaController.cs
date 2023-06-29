using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class GalerijaController : BaseCRUDController<Models.Galerija,GalerijaSearchObject, GalerijaInsertRequest, GalerijaUpdateRequest>
    {
        public GalerijaController(IGalerijaService service) : base(service) { }
    }
}
