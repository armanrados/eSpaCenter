using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class VrstaProizvodaController : BaseCRUDController<Models.VrstaProizvoda,BaseSearchObject, VrstaProizvodaInsertUpdateRequest, VrstaProizvodaInsertUpdateRequest>
    {
        public VrstaProizvodaController(IVrstaProizvodaService service) : base(service) { }
    }
}
