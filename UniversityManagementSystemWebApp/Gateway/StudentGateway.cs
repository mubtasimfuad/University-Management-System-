using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Net.Mime;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Models;
using UniversityManagementSystemWebApp.Models.View_Model;

namespace UniversityManagementSystemWebApp.Gateway
{
   public class StudentGateway : Gateway
    {
        public int SaveStudent(Student student)
        {
            Query = "Insert INTO Student(Name,RegNo,Email,ContactNo,RegDate,Address,DeptId) VALUES(@name, @regNo , @email, @contactNo, @regDate, @address, @deptId)";

            Command = new SqlCommand(Query, Connection);


            Command.Parameters.AddWithValue("@name", student.Name);
            Command.Parameters.AddWithValue("@regNo", 0);

            Command.Parameters.AddWithValue("@email", student.Email);

            Command.Parameters.AddWithValue("@contactNo", student.ContactNo);
            Command.Parameters.AddWithValue("@regDate", student.RegDate);
            Command.Parameters.AddWithValue("@address", student.Address);
            Command.Parameters.AddWithValue("@deptId", student.DepartmentId);

            Connection.Open();

            int rowAffected = Command.ExecuteNonQuery();

            Connection.Close();


            int deptId = student.DepartmentId;
            Query = "Select Name From Department Where Id = '" + deptId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            while (Reader.Read())
            {
                student.DeptName = Reader["Name"].ToString();
            }
            Reader.Close();
            Connection.Close();
           
            GenerateResgistrationNo(student);


            //GenerateResgistrationNo(student.Id, student.DeptName);
            //ShowStudentInfoByEmail(student.Email);


         
            return rowAffected;


        }

        public string GenerateResgistrationNo(Student student)
        {
            string code = "";
            Query = "SELECT Code From Department Where id = " + student.DepartmentId;
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            if (Reader.HasRows)
            {
                Reader.Read();
                code = Reader["Code"].ToString();
            }

            Reader.Close();
            int Id = 0;
            Connection.Close();
            Query = "SELECT TOP 1 * FROM Student ORDER BY ID DESC";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();
            if (Reader.HasRows)
            {
                Reader.Read();
                Id = Convert.ToInt32(Reader["Id"]);
            }
            Connection.Close();
            string newId = (Id).ToString().PadLeft(3, '0');
            
            string newRegNo = code + "-" + DateTime.Now.Year.ToString() + "-" + newId;
            Query = "Update Student Set RegNo = @regNo Where Email =@email";
           
            Command = new SqlCommand(Query, Connection);
            Command.Parameters.AddWithValue("@regNo", newRegNo);
            Command.Parameters.AddWithValue("@email", student.Email);

            Connection.Open();
            
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            student.RegNo = newRegNo;
            if (rowAffected > 0)
                return newRegNo;
            else
            {
                return "Problem in generating registration number";
            }


        }

       ////public List<Student> ShowStudentInfoByEmail(string email)
       ////{   
       ////    Query = "Select * From Student Where Id = '" + email + "'";
       ////    Command = new SqlCommand(Query, Connection);
       ////    Connection.Open();
       ////    Reader = Command.ExecuteReader();
       ////    List<Student> students = new List<Student>();

       ////    while (Reader.Read())
       ////    {
       ////        Student student = new Student();

       ////        student.Id = Convert.ToInt32(Reader["Id"]);
       ////        student.Name = Reader["Name"].ToString();
       ////        student.Address = Reader["Address"].ToString();
       ////        student.ContactNo = Reader["ContactNo"].ToString();
       ////        student.DepartmentId = Convert.ToInt32(Reader["DepartmentId"]);
       ////        student.DeptName = Reader["DeptName"].ToString();

       ////        student.Email = Reader["Email"].ToString();

       ////        student.RegDate = Convert.ToDateTime(Reader["RegDate"].ToString());

       ////        student.RegNo = Reader["RegNo"].ToString();




       ////    }

       ////    Connection.Close();
       ////    return students;


       ////}


      

       public Student IsUniqeEmail(string email)
        {
            Query = "SELECT * FROM Student WHERE Email = '" + email + "'";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();

            Reader = Command.ExecuteReader();

            Student aStudent = new Student();

            if (!Reader.HasRows)
            {

                aStudent = null;


            }

            Reader.Close();
            Connection.Close();
            return aStudent;
        }

       public List<SelectListItem> GetAllStudentsSelectListItem()
       {
           Query = "Select * From Student";
           Command = new SqlCommand(Query, Connection);
           Connection.Open();
           Reader = Command.ExecuteReader();

           List<SelectListItem> items = new List<SelectListItem>();
           while (Reader.Read())
           {

               items.Add(new SelectListItem()
               {
                   Value = Reader["Id"].ToString(),
                   Text = Reader["RegNo"].ToString()


               });

           }

           Reader.Close();
           Connection.Close();

           return items;
       }

       public List<Student> GetStudentById(int studentId)
       {
           Query = "Select * from Student where Id =@studentId";
           Command = new SqlCommand(Query, Connection);
           Command.Parameters.AddWithValue("@studentId", studentId);

           Connection.Open();
           Reader = Command.ExecuteReader();

           List<Student> students = new List<Student>();
           while (Reader.Read())
           {
               Student aStudent = new Student
               {
                   Id = (int) Reader["Id"],
                   Name = Reader["Name"].ToString(),
                   Email = Reader["Email"].ToString(),
                   RegNo = Reader["RegNo"].ToString(),
                   ContactNo = Reader["ContactNo"].ToString(),
                   DepartmentId = (int) Reader["DeptId"]
               };
               students.Add(aStudent);
           }

           Reader.Close();
           Connection.Close();

           for (int i = 0; i < students.Count; i++)
           {
               int deptId = students[i].DepartmentId;
               Query = "Select Name From Department Where Id = @deptId";

               Command = new SqlCommand(Query, Connection);
               Command.Parameters.AddWithValue("@deptId", deptId);

               Connection.Open();
               Reader = Command.ExecuteReader();
               while (Reader.Read())
               {
                   students[i].DeptName = Reader["Name"].ToString();
               }
               Reader.Close();
               Connection.Close();

           }

           return students;
       }
       // public List<Student> GetStudentByRegNo(string regNo)
       //{
       //    Query = "Select * from Student where RegNo =@regNo";
       //    Command = new SqlCommand(Query, Connection);
       //    Command.Parameters.AddWithValue("@regNo", regNo);

       //    Connection.Open();
       //    Reader = Command.ExecuteReader();

       //    List<Student> students = new List<Student>();
       //    while (Reader.Read())
       //    {
       //        Student aStudent = new Student
       //        {
       //            Id = (int) Reader["Id"],
       //            Name = Reader["Name"].ToString(),
       //            Email = Reader["Email"].ToString(),
       //            RegNo = Reader["RegNo"].ToString(),
       //            ContactNo = Reader["ContactNo"].ToString(),
       //            DepartmentId = (int) Reader["DeptId"]
       //        };
       //        students.Add(aStudent);
       //    }

       //    Reader.Close();
       //    Connection.Close();

       //    for (int i = 0; i < students.Count; i++)
       //    {
       //        int deptId = students[i].DepartmentId;
       //        Query = "Select Name From Department Where Id = @deptId";

       //        Command = new SqlCommand(Query, Connection);
       //        Command.Parameters.AddWithValue("@deptId", deptId);

       //        Connection.Open();
       //        Reader = Command.ExecuteReader();
       //        while (Reader.Read())
       //        {
       //            students[i].DeptName = Reader["Name"].ToString();
       //        }
       //        Reader.Close();
       //        Connection.Close();

       //    }

       //    return students;
       //}

       
      

        //public ResultSheet GenerateResultForStudentId(int  studentId)
        //{
        //    ResultSheet aResultSheet = new ResultSheet();
        //    Query = "Select Name, RegNo, Email, DeptId From Student Where Id = '" + studentId + "' ";
        //    Command = new SqlCommand(Query, Connection);
        //    Connection.Open();
        //    Reader = Command.ExecuteReader();
        //    int deptId = 0;
        //    while (Reader.Read())
        //    {
        //        aResultSheet.Name = Reader["Name"].ToString();
        //        aResultSheet.RegNo = Reader["RegNo"].ToString();
        //        aResultSheet.Email = Reader["Email"].ToString();
        //        deptId = (int) Reader["DeptId"];
        //    }

        //    Reader.Close();
        //    Connection.Close();

           
        //    Query = "Select Name From Department Where Id = '" + deptId + "'";
        //    Command = new SqlCommand(Query, Connection);
        //    Connection.Open();
        //    Reader = Command.ExecuteReader();
        //    while (Reader.Read())
        //    {
        //        aResultSheet.DeptName = Reader["Name"].ToString();
        //    }
        //    Reader.Close();
        //    Connection.Close();

        //    Query = "Select * From StudentCourseView Where StudentId = '" + studentId + "' And Flag = '1'";
        //    Command = new SqlCommand(Query, Connection);
        //    Connection.Open();
        //    Reader = Command.ExecuteReader();
        //    List<CourseResult> courseResults = new List<CourseResult>();

        //    while (Reader.Read())
        //    {
        //        CourseResult aCourseResult = new CourseResult();
        //        aCourseResult.CourseCode = Reader["CourseCode"].ToString();
        //        aCourseResult.CourseName = Reader["CourseName"].ToString();
        //        aCourseResult.Grade = Reader["Grade"].ToString();
        //        courseResults.Add(aCourseResult);
        //    }


        //    Reader.Close();
        //    Connection.Close();
        //    return aResultSheet;
        //}
    }
}

          
    