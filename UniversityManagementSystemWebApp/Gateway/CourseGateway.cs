using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using UniversityManagementSystemWebApp.Models;
using UniversityManagementSystemWebApp.Models.View_Model;

namespace UniversityManagementSystemWebApp.Gateway
{
    public class CourseGateway:Gateway
    {
        public int SaveCourse(Course aCourse)
        {
            Query = "Insert INTO Course VALUES('" + aCourse.Code + "','" + aCourse.Name + "','" + aCourse.Credit + "','" + aCourse.Description + "','" + aCourse.DepartmentId + "','" + aCourse.SemesterId + "')";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            int rowAffected = Command.ExecuteNonQuery();

            Connection.Close();

            return rowAffected;
        }

        public Course IsUniqeCode(string code)
        {
            Query = "SELECT * FROM Course WHERE Code = '" + code + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Course aCourse = new Course();

            if (!Reader.HasRows)
            {

                aCourse = null;


            }

            Reader.Close();
            Connection.Close();
            return aCourse;
        }

        public Course IsUniqeName(string name)
        {
            Query = "SELECT * FROM Course WHERE Name = '" + name + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Course aCourse = new Course();

            if (!Reader.HasRows)
            {

                aCourse = null;


            }

            Reader.Close();
            Connection.Close();
            return aCourse;
        }

        public List<Course> GetAllCourses()
        {
            Query = "Select * From Course";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            List<Course> courses = new List<Course>();
            while (Reader.Read())
            {
                Course aCourse = new Course();
                aCourse.Id = (int)Reader["Id"];
                aCourse.Code = Reader["Code"].ToString();
                aCourse.Name = Reader["Name"].ToString();
                aCourse.Credit = Convert.ToDouble(Reader["Credit"]);
                aCourse.Description = Reader["Description"].ToString();
                aCourse.DepartmentId = (int)Reader["DepartmentId"];
                aCourse.SemesterId = (int)Reader["SemesterId"];
                courses.Add(aCourse);
            }
            Reader.Close();
            Connection.Close();
            return courses;
        }


        public List<CourseStatisticView> GetAllCourseDetailsByDeptId(int deptId)
        {
            Query = "Select * From CourseStatisticsViews Where DeptId = '" + deptId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            List<CourseStatisticView> courseDetailses = new List<CourseStatisticView>();
            while (Reader.Read())
            {

                CourseStatisticView courseDetails = new CourseStatisticView();
                courseDetails.CourseCode = Reader["Code"].ToString();
                courseDetails.CourseName = Reader["Title"].ToString();
                courseDetails.Semester = (int)Reader["Semester"];
                courseDetailses.RemoveAll(x => x.CourseCode == courseDetails.CourseCode);
                if (Reader["Flag"].ToString() == "1")
                {

                    courseDetails.TeacherName = Reader["AssignedTo"].ToString();
                }
                else
                {
                    courseDetails.TeacherName = "Not Assigned Yet";
                }
                courseDetailses.Add(courseDetails);
            }
            Reader.Close();
            Connection.Close();
            return courseDetailses;
        }

        public int UpdateForUnAssignAllCourse(string str)
        {
            Query = str;
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }

        public int UnAssignAllCourse()
        {
            if (UpdateForUnAssignAllCourse("Update CourseEnrollment Set Flag = '0'") == 0)
                return 0;
            if (UpdateForUnAssignAllCourse("Update AssignCourse Set Flag = '0'") == 0)
                return 0;
            if (UpdateForUnAssignAllCourse("Update Teacher Set RemainingCredit = CreditLimit") == 0)
                return 0;
            return 1;
        }
    }
}
    
