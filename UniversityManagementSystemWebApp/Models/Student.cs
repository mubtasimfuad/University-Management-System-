using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UniversityManagementSystemWebApp.Models
{
    public class Student
    {
        public int Id { get; set; }
        [Required]
        [DisplayName("Name :")]
        public string Name { get; set; }
        public string RegNo { get; set; }

        [EmailAddress]
        [Required(ErrorMessage = "Please Provide a Email")]
        [DisplayName("Email :")]
        public string Email { get; set; }

        [Required(ErrorMessage = "Please Provide a Contact Number")]
        [DisplayName("Contact No :")]
        [StringLength(11)]
        [RegularExpression(@"^(\d{11})$", ErrorMessage = "Enter a valid 11 digit Number")]
        public string ContactNo { get; set; }


        [Required]
        [DisplayName("Address :")]
        public string Address { get; set; }

        [Required]
        [DisplayName("Registration Date :")]

        public DateTime RegDate { get; set; }

        [Required]
        [DisplayName("Department :")]
        public int DepartmentId { get; set; }

        public string DeptName { get; set; }

    }
}