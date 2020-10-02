using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Gateway;
using UniversityManagementSystemWebApp.Models;

namespace UniversityManagementSystemWebApp.Manager
{
    public class TeacherManager
    {
        TeacherGateway teacherGateway = new TeacherGateway();

        public List<SelectListItem> GetAllDesignation()
        {
            return teacherGateway.GetAllDesignation();
        }

        public string SaveTeacher(Teacher aTeacher)
        {
            if (teacherGateway.IsUniqeEmail(aTeacher.Email) != null)
            {
                return "Email Not Unique";
            }



            int rowAffected = teacherGateway.SaveTeacher(aTeacher);
            if (rowAffected > 0)
            {
                return "yes";
            }
            else
            {
                return "no";
            }
        }

        public string AssignCourseToTeacher(AssignCourse assignCourse)
        {
            if (teacherGateway.IsCourseAlreadyAssigned(assignCourse))
            {
                return "Course Already Assigned";
            }
            int rowAffected = teacherGateway.AssignCourseToTeacher(assignCourse);
            if (rowAffected > 0)
                return "yes";
            else
            {
                return "no";
            }
        }

        public List<Teacher> GetAllTeachers()
        {
            return teacherGateway.GetAllTeachers();
        }
    }
}