using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Web;

namespace UniversityManagementSystemWebApp.Models
{
    public class CourseEnrollment
    {

        public int Id { get; set; }
        [DisplayName("Student Registration No")]
        public int StudentId { get; set; }

        public int CourseId { get; set; }
        [DisplayName("Enroll Date")]
        public DateTime EnrollDate { get; set; }
        public string Grade { get; set; }
        public string Valid { get; set; }
    }
}