using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UniversityManagementSystemWebApp.Models
{
    public class AssignCourse
    {
    
        public int Id { get; set; }
        public int TeacherId { get; set; }
        public int  CourseId { get; set; }
        public string Flag { get; set; }
    }
}
