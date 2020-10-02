using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Models;

namespace UniversityManagementSystemWebApp.Gateway
{
    public class TeacherGateway : Gateway
    {
        public List<SelectListItem> GetAllDesignation()
        {
            Query = "SELECT * FROM Designation";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();
            List<SelectListItem> designations = new List<SelectListItem>();

            while (Reader.Read())
            {

                designations.Add(new SelectListItem()
                {
                    Value = Reader["Name"].ToString(),
                    Text = Reader["Name"].ToString()
                });

            }

            Reader.Close();
            Connection.Close();

            return designations;
        }

        public int SaveTeacher(Teacher aTeacher)
        {
            Query = "Insert INTO Teacher(Name,Address,Email,ContactNo,Designation,DepartmentId,CreditLimit,RemainingCredit) VALUES(@name, @address , @email, @contactNo, @designation, @departmentId, @creditLimit,@remainingCredit)";

            Command = new SqlCommand(Query, Connection);


            Command.Parameters.AddWithValue("@name",aTeacher.Name);

            Command.Parameters.AddWithValue("@address", aTeacher.Address);

            Command.Parameters.AddWithValue("@email", aTeacher.Email);

            Command.Parameters.AddWithValue("@contactNo", aTeacher.ContactNo);

            Command.Parameters.AddWithValue("@designation", aTeacher.Designation);

            Command.Parameters.AddWithValue("@departmentId", aTeacher.DepartmentId);

            Command.Parameters.AddWithValue("@creditLimit", aTeacher.CreditLimit);
            Command.Parameters.AddWithValue("@remainingCredit", aTeacher.CreditLimit);


            Connection.Open();

            int rowAffected = Command.ExecuteNonQuery();

            Connection.Close();

            return rowAffected;
        }

        public Teacher IsUniqeEmail(string email)
        {
            Query = "SELECT * FROM Teacher WHERE Email = '" + email + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Teacher aTeacher = new Teacher();

            if (!Reader.HasRows)
            {

                aTeacher = null;


            }

            Reader.Close();
            Connection.Close();
            return aTeacher;
        }
        public int AssignCourseToTeacher(AssignCourse assignCourse)
        {
            Query = "Insert into AssignCourse Values ('" + assignCourse.CourseId + "','" + assignCourse.TeacherId + "','1')";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();

            UpdateTeacherRemainingCredit(assignCourse);

            return rowAffected;

        }

        public int UpdateTeacherRemainingCredit(AssignCourse assignCourse)
        {
            double courseCredit = 0;
            Query = "SELECT Credit FROM Course Where Id = '" + assignCourse.CourseId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                courseCredit = Convert.ToDouble(Reader["Credit"]);
            }
            Reader.Close();
            Connection.Close();

            Query = "Update Teacher Set RemainingCredit = RemainingCredit - '" + courseCredit + "' Where Id = '" + assignCourse.TeacherId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }
        public bool IsCourseAlreadyAssigned(AssignCourse assignCourse)
        {
            Query = "SELECT * FROM AssignCourse  Where CourseId = '" + assignCourse.CourseId + "' AND Flag = '1'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            bool result = Reader.HasRows;
            Reader.Close();
            Connection.Close();
            return result;
        }
    

        public List<Teacher> GetAllTeachers()
        {
            Query = "SELECT * FROM Teacher";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            List<Teacher> teachers = new List<Teacher>();

            while (Reader.Read())
            {
                Teacher aTeacher = new Teacher();

                aTeacher.Id = (int)Reader["Id"];
                aTeacher.Name = Reader["Name"].ToString();
                aTeacher.Address = Reader["Address"].ToString();
                aTeacher.ContactNo = Reader["ContactNo"].ToString();
                aTeacher.Email = Reader["Email"].ToString();
                aTeacher.Designation = Reader["Designation"].ToString();
                aTeacher.DepartmentId = (int)Reader["DepartmentId"];

                aTeacher.CreditLimit = Convert.ToDouble(Reader["CreditLimit"]);
                aTeacher.RemainingCredit = Convert.ToDouble(Reader["RemainingCredit"]);
                teachers.Add(aTeacher);
            }
            Reader.Close();
            Connection.Close();
            return teachers;
        }

       
    }
}