using System.Collections.Generic;
using System.Data.SqlClient;

using System.Web.Mvc;
using UniversityManagementSystemWebApp.Models;
using UniversityManagementSystemWebApp.Models.View_Model;

namespace UniversityManagementSystemWebApp.Gateway
{
    public class CourseEnrollmentGateway : Gateway
    {
        public int SaveCourseEnrollment(CourseEnrollment courseEnrollment)
        {
            Query = "Insert Into CourseEnrollment Values ('" + courseEnrollment.StudentId + "','" + courseEnrollment.CourseId + "','" + courseEnrollment.EnrollDate.Date.ToString("yyyy-MM-dd") + "','Not Graded Yet','1') ";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();

            return rowAffected;
        }

        public bool AlreadyEnrolledInCourse(CourseEnrollment courseEnrollment)
        {
            Query = "Select * From CourseEnrollment Where StudentId = '" + courseEnrollment.StudentId + "' And CourseId = '" + courseEnrollment.CourseId + "' And Flag = '1'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            bool hasRows = Reader.HasRows;

            Reader.Close();
            Connection.Close();
            return hasRows;
        }

        public List<Course> GetAllCoursesTakenByStudentId(int studentId)
        {
            Query = "Select * From StudentCourseView Where StudentId = '" + studentId + "' And Flag = '1' ";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            List<Course> courses = new List<Course>();
            while (Reader.Read())
            {
                Course aCourse = new Course();
                aCourse.Id = (int)Reader["CourseId"];
                aCourse.Name = Reader["CourseName"].ToString();
                aCourse.Code = Reader["CourseCode"].ToString();
                courses.Add(aCourse);
            }

            Reader.Close();
            Connection.Close();
            return courses;
        }

        public List<SelectListItem> GetAllGradesSelectListItem()
        {
            Query = "Select * From Grade";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            List<SelectListItem> grades = new List<SelectListItem>();
            while (Reader.Read())
            {
                grades.Add(
                    new SelectListItem()
                    {
                        Value = Reader["LetterGrade"].ToString(),
                        Text = Reader["LetterGrade"].ToString()
                    });
            }

            Reader.Close();
            Connection.Close();
            return grades;

        }

        public int SaveCourseResult(CourseEnrollment courseEnrollment)
        {
            int rowAffected = 0;

            Query = "Update CourseEnrollment set Grade = '" + courseEnrollment.Grade + "' Where StudentId = '" + courseEnrollment.StudentId + "' And CourseId = '" + courseEnrollment.CourseId + "' And Flag = '1'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }

        public List<StudentCourseView> GetCourseResultByStudentId(int studentId)
        {
            Query = "Select * From StudentCourseView Where StudentId = '" + studentId + "' And Flag = '1' ";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            List<StudentCourseView> results = new List<StudentCourseView>();
            while (Reader.Read())
            {
                StudentCourseView aResult = new StudentCourseView
                {
                    CourseCode = Reader["CourseCode"].ToString(),
                    CourseName = Reader["CourseName"].ToString(),
                    Grade = Reader["Grade"].ToString()
                };
                results.Add(aResult);
            }

            Reader.Close();
            Connection.Close();
            return results;
        }
    }
}