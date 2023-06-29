using eSpaCenter.Models;
using eSpaCenter.Services;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace eSpaCenter.Controllers
{
    [Route("[controller]")]
    [ApiController]
    [Authorize]
    public class BaseController<T,TSearch> : ControllerBase  where T : class where TSearch: class
    {
        public IBaseService<T,TSearch> _service;

        public BaseController(IBaseService<T, TSearch> service)
        {
            _service = service;
           
        }

        [HttpGet()]
        public async Task<PagedResult<T>> Get([FromBody] TSearch? search = null)
        {
            return await _service.Get(search);
        }

        [HttpGet("{id}")]
        public async Task<T> GetById(int id)
        {
            return await _service.GetById(id);
        }
    }
}
