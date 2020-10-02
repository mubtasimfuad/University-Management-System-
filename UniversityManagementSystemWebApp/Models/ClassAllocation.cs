using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;


namespace UniversityManagementSystemWebApp.Models
{
    public class ClassAllocation
    {
    
        public int Id { get; set; }


        public int DepartmentId { get; set; }


        public int CourseId { get; set; }

        public string RoomNo { get; set; }

        public string Day { get; set; }

        public int From { get; set; }

        public int To { get; set; }

        public string Flag { get; set; }

    }
}
    
