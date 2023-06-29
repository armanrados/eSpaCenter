using AutoMapper;
using eSpaCenter.Models.SearchObjects;
using eSpaCenter.Services.Database;
using Microsoft.EntityFrameworkCore.Metadata.Conventions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services
{
    public class BaseCRUDService<T,TDb,TSearch, TInsert,TUpdate> : BaseService<T,TDb,TSearch> where T : class where TDb : class where TSearch : BaseSearchObject
    {

        public BaseCRUDService(eSpaCenterContext db, IMapper mapper) : base(db, mapper) {}

        public virtual async Task BeforeInsert(TDb entity, TInsert insert)
        {

        }

        public virtual async Task<T> Insert(TInsert insert)
        {
            var set = _db.Set<TDb>();
            TDb entity = _mapper.Map<TDb>(insert);
            set.Add(entity);
            await BeforeInsert(entity, insert);
            await _db.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }

        public virtual async Task<T> Update(TUpdate update, int id)
        {
            var set = _db.Set<TDb>();
            var entity = await set.FindAsync(id);
            _mapper.Map(update,entity);
            await _db.SaveChangesAsync();
            return _mapper.Map<T>(entity);
        }

        public virtual async Task<T> Delete(int id)
        {
            var set = _db.Set<TDb>();
            var entity = await set.FindAsync(id);
            var tmp = entity;
            if (entity != null)
                _db.Remove(entity);
            await _db.SaveChangesAsync();
            return _mapper.Map<T>(tmp);

        }
    }
}
