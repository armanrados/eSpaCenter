using eSpaCenter.Services;
using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Mvc;

namespace eSpaCenter.Controllers
{
    [Microsoft.AspNetCore.Mvc.Route("[controller]")]
    [ApiController]
    public class BaseCRUDController<T, TSearch, TInsert, TUpdate> : BaseController<T, TSearch> where T : class where TSearch : class
    {
        protected new readonly ICRUDService<T, TSearch, TInsert, TUpdate> _service;
      
        public BaseCRUDController(ICRUDService<T, TSearch, TInsert, TUpdate> service) : base(service) 
        {
            _service = service;
        }
        
        

        [HttpPost]
        public virtual async Task<T> Insert([FromBody] TInsert insert)
        {
            return await _service.Insert(insert);
        }

        [HttpPut("{id}")]
        public virtual async Task<T> Update([FromBody] TUpdate update, int id)
        {
            return await _service.Update(update, id);
        }

        [HttpDelete("{id}")]
        public virtual async Task<T> Delete(int id)
        {
            return await _service.Delete(id); 
        }

    }
}
