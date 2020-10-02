using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Models;
using UniversityManagementSystemWebApp.Models.View_Model;
using ClassSchedule = UniversityManagementSystemWebApp.Models;

namespace UniversityManagementSystemWebApp.Gateway
{
    public class ClassAllocationGateway : Gateway
    {
        public List<SelectListItem> GetAllRoomNos()
        {
            Query = "SELECT * FROM Room";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();

            List<SelectListItem> roomNoListItems = new List<SelectListItem>();

            while (Reader.Read())
            {
                roomNoListItems.Add(new SelectListItem()
                {
                    Value = Reader["RoomNo"].ToString(),
                    Text = Reader["RoomNo"].ToString()
                });
            }
            Reader.Close();
            Connection.Close();


            return roomNoListItems;
        }
        public List<SelectListItem> GetAllDays()
        {
            Query = "SELECT * FROM Day";

            Command = new SqlCommand(Query, Connection);

            Connection.Open();
            Reader = Command.ExecuteReader();

            List<SelectListItem> dayListItems = new List<SelectListItem>();

            while (Reader.Read())
            {
                dayListItems.Add(new SelectListItem()
                {
                    Value = Reader["Name"].ToString(),
                    Text = Reader["Name"].ToString()
                });
            }
            Reader.Close();
            Connection.Close();


            return dayListItems;
        }
        public int SaveClassAllocation(ClassAllocation classroomAllocation)
        {
            Query = "Insert Into ClassAllocation Values ('" + classroomAllocation.DepartmentId + "','" + classroomAllocation.CourseId + "','" + classroomAllocation.RoomNo + "','" + classroomAllocation.Day + "','" + classroomAllocation.From + "','" + classroomAllocation.To + "','1')";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }
        public bool IsClassRoomAlreadyAllocated(ClassAllocation classroomAllocation)
        {

            Query = "select * from ClassAllocation Where ((Day =@day And RoomNo=@roomNo) OR (Day =@day " +
                    "And CourseId=@courseId))" +
                    "And " +
                    "((@fromTime >=FromTime AND @fromTime<ToTime) OR (@toTime>FromTime AND @toTime<=ToTime) OR" +
                    " (@fromTime<=FromTime AND @toTime>=ToTime)) And Flag = '1'";
            Command = new SqlCommand(Query, Connection);
           Command.Parameters.AddWithValue("@day", classroomAllocation.Day);
           Command.Parameters.AddWithValue("@roomNo", classroomAllocation.RoomNo);
           Command.Parameters.AddWithValue("@courseId", classroomAllocation.CourseId);
           Command.Parameters.AddWithValue("@fromTime", classroomAllocation.From);
           Command.Parameters.AddWithValue("@toTime", classroomAllocation.To);

            Connection.Open();
            Reader = Command.ExecuteReader();
            bool Bool = Reader.HasRows;
            Connection.Close();



            return Bool;
        }
        public List<ClassRoutineView> GenerateTemporaryClassScheduleByDeptId(int deptId)
        {
            List<ClassRoutineView> classRoutineViews = new List<ClassRoutineView>();
            Query = "Select * From ClassRoutineView Where DeptId = '" + deptId + "'";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            Reader = Command.ExecuteReader();

            while (Reader.Read())
            {
                ClassRoutineView classRoutineView = new ClassRoutineView
                {
                    CourseCode = Reader["CourseCode"].ToString(),
                    CourseName = Reader["CourseName"].ToString(),
                    Day = Reader["Day"].ToString(),
                    RoomNo = Reader["RoomNo"].ToString()
                };




                if (!(Reader["FromTime"] is DBNull))
                    classRoutineView.From = Convert.ToInt32(Reader["FromTime"]);
               
                if (!(Reader["ToTime"] is DBNull))
                    classRoutineView.To = Convert.ToInt32(Reader["ToTime"]);
                
                classRoutineView.Flag = Reader["Flag"].ToString();
                classRoutineViews.Add(classRoutineView);
               
            }

            Reader.Close();
            Connection.Close();
            return classRoutineViews;
        }

        public string GetFullInformation(ClassRoutineView classRoutineView)
        {
            string information = String.Empty;
            if (classRoutineView.Flag != "1")
                return information;
            information += "Room No.: " + classRoutineView.RoomNo + ", Day : " + classRoutineView.Day + ", ";
            information += " Time : " + ConvertTime(classRoutineView.From);

            information += " - " + ConvertTime(classRoutineView.To);
            information += ";<br/><br/>";
            return information;
        }

        private string ConvertTime(int minuteTime)
        {
            string time = "";
            int hour = minuteTime / 60;
            string division;
            if (hour >= 12)
            {
                division = "pm";
                if (hour > 12)
                    hour -= 12;
            }
            else
            {
                division = "am";
                if (hour == 0)
                    hour = 12;
            }

            int min = minuteTime % 60;
            if (hour < 10)
                time += "0";
            time += hour + ":";
            if (min < 10)
                time += "0";
            time += min;
            time += " " + division;
            return time;

        }

        public int DayIndex(string day)
        {
            if (day == "Saturday")
                return 1;
            else if (day == "Sunday")
                return 2;
            else if (day == "Monday")
                return 3;
            else if (day == "Tuesday")
                return 4;
            else if (day == "Wednesday")
                return 5;
            else if (day == "Thursday")
                return 6;
            else
                return 7;

        }

        public List<ClassScheduleFinal> GetFinalClassScheduleByDeptId(int deptId)
        {
            List<ClassRoutineView> classRoutineViews = GenerateTemporaryClassScheduleByDeptId(deptId);
            List<ClassScheduleFinal> classScheduleFinals = new List<ClassScheduleFinal>();
            if (classRoutineViews.Count == 0)
                return classScheduleFinals;
            string info = "";

            string code = classRoutineViews[0].CourseCode;
            string name = classRoutineViews[0].CourseName;
            info += GetFullInformation(classRoutineViews[0]);
            var temp = code;

            for (int i = 1; i < classRoutineViews.Count; i++)
            {
                ClassRoutineView aClassScheduleTemp = classRoutineViews[i];
                if (aClassScheduleTemp.CourseCode != temp)
                {
                    ClassScheduleFinal aClassScheduleFinal = new ClassScheduleFinal();
                    aClassScheduleFinal.CourseCode = code;
                    aClassScheduleFinal.CourseName = name;
                    if (info == "")
                        aClassScheduleFinal.Info = "not scheduled yet";
                    else
                    {
                        aClassScheduleFinal.Info = info;
                    }
                    classScheduleFinals.Add(aClassScheduleFinal);
                    code = aClassScheduleTemp.CourseCode;
                    name = aClassScheduleTemp.CourseName;
                    info = "";
                }
                info += GetFullInformation(aClassScheduleTemp);
                temp = aClassScheduleTemp.CourseCode;
            }
            ClassScheduleFinal aClassScheduleFinal2 = new ClassScheduleFinal();
            aClassScheduleFinal2.CourseCode = code;
            aClassScheduleFinal2.CourseName = name;
            if (info == "")
                aClassScheduleFinal2.Info = "not scheduled yet";
            else
            {
                aClassScheduleFinal2.Info = info;
            }
            classScheduleFinals.Add(aClassScheduleFinal2);
            return classScheduleFinals;

        }


        public int UnallocateClassRoom()
        {
            Query = "Update ClassAllocation Set Flag = '0' ";
            Command = new SqlCommand(Query, Connection);
            Connection.Open();
            int rowAffected = Command.ExecuteNonQuery();
            Connection.Close();
            return rowAffected;
        }

       
    }
}