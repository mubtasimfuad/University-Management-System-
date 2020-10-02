using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace UniversityManagementSystemWebApp.Models
{
    public class Teacher
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Please Provide a Name")]
        [DisplayName("Name :")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Please Provide a Address")]
        [DisplayName("Address :")]
        public string Address { get; set; }

        [Required(ErrorMessage = "Please Provide a Email")]
        [DisplayName("Email :")]
        [EmailAddress]

        public string Email { get; set; }

        [Required(ErrorMessage = "Please Provide a Contact Number")]
        [DisplayName("Contact No :")]

        [StringLength(11, MinimumLength = 11, ErrorMessage = "Please Provide a Contact Number of 11 digits")]
        public string ContactNo { get; set; }

        [Required(ErrorMessage = "Select a Designation")]
        [DisplayName("Designation :")]
        public string Designation { get; set; }

        [Required(ErrorMessage = "Select a Department")]
        [DisplayName("Department :")]
        public int DepartmentId { get; set; }


        [Required(ErrorMessage = "Please Provide a Credit Limit")]
        [DisplayName("Credit :")]
        [Range(typeof(double), "0.0", "99.0", ErrorMessage = "Cradit range must be 0.0 to 99.0")]
        public double CreditLimit { get; set; }
        public double RemainingCredit { get; set; }
    }
}