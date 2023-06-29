using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace eSpaCenter.Services
{
    public interface ICRUDService<T, TSearch, TInsert, TUpdate> : IBaseService<T,TSearch> where T: class where TSearch : class
    {
        Task<T> Insert(TInsert insert);
        Task<T> Update(TUpdate update, int id);
        Task<T> Delete (int id);

    }
}
