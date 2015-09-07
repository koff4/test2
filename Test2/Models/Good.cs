using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data.Entity;
using System.ComponentModel.DataAnnotations;

namespace Test1.Models
{
    public class Good
    {
        [Key, Display(Name = "ID")]
        public int GoodID { get; set; }
        [Required, StringLength(40), Display(Name = "Наименование")]
        public string Name { get; set; }
        [Required, DataType(DataType.Currency)]
        public decimal Price { get; set; }
    }
    public class GoodContext : DbContext
    {
        public DbSet<Good> Goods { get; set; }
    }
    
}
