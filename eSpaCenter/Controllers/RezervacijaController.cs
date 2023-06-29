using eSpaCenter.Models.Requests;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services;

namespace eSpaCenter.Controllers
{
    public class RezervacijaController : BaseCRUDController<Models.Rezervacija, RezervacijaSearchObject, RezervacijaInsertUpdateRequest, RezervacijaInsertUpdateRequest>
    {
        public RezervacijaController(IRezervacijaService service) : base(service) { }
    }
}
