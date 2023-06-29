using eSpaCenter.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using AutoMapper;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Models;
using Microsoft.EntityFrameworkCore;
using AutoMapper.Execution;

namespace eSpaCenter.Services
{
    public class BaseService<T,TDb,TSearch> : IBaseService<T,TSearch> where T : class where TDb : class where TSearch : BaseSearchObject
    {
        protected eSpaCenterContext _db;
        protected IMapper _mapper;
        public BaseService(eSpaCenterContext db, IMapper mapper) 
        {
            _db = db;
            _mapper = mapper;
        }

        public virtual async Task<PagedResult<T>> Get(TSearch? search = null)
        {
            var entity = _db.Set<TDb>().AsQueryable();
            PagedResult<T> result = new PagedResult<T>();

            entity = AddFilter(entity, search);
            entity = AddInclude(entity, search);
            result.Count = await entity.CountAsync();
            if(search?.Page.HasValue == true && search?.PageSize.HasValue == true)
            {
                entity = entity.Take(search.PageSize.Value).Skip(search.Page.Value *  search.PageSize.Value);
            }
            var list = await entity.ToListAsync();
            var tmp = _mapper.Map<List<T>>(list);
            result.Result = tmp;
            return result;
        }

        public virtual async Task<T> GetById(int id)
        {
            var entity = await _db.Set<TDb>().FindAsync(id);
            return _mapper.Map<T>(entity);
        }

        public virtual IQueryable<TDb> AddFilter(IQueryable<TDb> entity, TSearch? search = null)
        {
            return entity;
        }

        public virtual IQueryable<TDb> AddInclude(IQueryable<TDb> entity, TSearch? search = null)
        {
            return entity;

        }
    }
}
