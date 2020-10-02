using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using UniversityManagementSystemWebApp.Gateway;
using UniversityManagementSystemWebApp.Models;
using UniversityManagementSystemWebApp.Models.View_Model;

namespace UniversityManagementSystemWebApp.Manager
{
    public class CourseManager:Gateway.Gateway
    {
        CourseGateway courseGateway=new CourseGateway();
         public string SaveCourse(Course aCourse)
        {
            if (courseGateway.IsUniqeCode(aCourse.Code) != null)
            {
                return "Code Not Unique";
            }

            if (courseGateway.IsUniqeName(aCourse.Name) != null)
            {
                return "Name Not Unique";
            }


            int rowAffected = courseGateway.SaveCourse(aCourse);
            if (rowAffected > 0)
            {
                return "Saved";
            }
            else
            {
                return "Saving Failed";
            }
        }

        public List<Course> GetAllCourses()
        {
            return  courseGateway.GetAllCourses();
        }


        public List<CourseStatisticView> GetAllCourseDetailsByDeptId(int deptId)
        {
            return courseGateway.GetAllCourseDetailsByDeptId(deptId);
        }

        public string UnAssignAllCourse()
        {
            string message = "";
            int rowAffected =courseGateway.UnAssignAllCourse();
            if (rowAffected > 0)
                message = "yes";
            else
            {
                message = "no";
            }
            return message;
        }
    }
}