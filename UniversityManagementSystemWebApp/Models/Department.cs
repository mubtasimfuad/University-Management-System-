using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UniversityManagementSystemWebApp.Models
{
    public class Department
    {
        public int Id { get; set; }
                [Required]

        public string Code { get; set; }
                        [Required]

        public string Name { get; set; }

    }
}