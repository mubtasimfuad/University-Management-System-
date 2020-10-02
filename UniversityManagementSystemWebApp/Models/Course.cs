using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UniversityManagementSystemWebApp.Models
{
    public class Course
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Please Provide a Code")]
        [StringLength(30, MinimumLength = 5, ErrorMessage = "Minimum Length atleast 5")]
        [DisplayName("Code :")]
        public string Code { get; set; }

        [Required(ErrorMessage = "Please Provide a Name")]
        [DisplayName("Name :")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Please Provide a Cradit")]
        [DisplayName("Credit :")]
        [Range(typeof(double), "0.5", "5.0", ErrorMessage = "Cradit range must be 0.5 to 5.0")]
        public double Credit { get; set; }

        [Required(ErrorMessage = "Please Provide a Description")]
        [DisplayName("Description :")]
        public string Description { get; set; }


        [Required(ErrorMessage = "Select a Department")]
        [DisplayName("Department :")]
        public int DepartmentId { get; set; }
        [Required(ErrorMessage = "Select a Semester")]
        [DisplayName("Semester :")]
        public int SemesterId { get; set; }


    }
}