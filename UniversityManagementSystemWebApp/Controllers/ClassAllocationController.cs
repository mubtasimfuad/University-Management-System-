using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Manager;
using UniversityManagementSystemWebApp.Models;
using UniversityManagementSystemWebApp.Models.View_Model;

namespace UniversityManagementSystemWebApp.Controllers
{
    public class ClassAllocationController : Controller
    {
        DepartmentManager departmentManager = new DepartmentManager();
        TeacherManager aTeacherManager = new TeacherManager();
        ClassAllocationManager classAllocationManager = new ClassAllocationManager();
        //
        // GET: /ClassRoom/
        public ActionResult AllocateClassrooms()
        {
            List<SelectListItem> aDepartments = departmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            List<SelectListItem> aRoomNos = classAllocationManager.GetAllRoomNos();
            ViewBag.RoomNo = aRoomNos;

            List<SelectListItem> daysListItems = classAllocationManager.GetAllDays();
            ViewBag.Day = daysListItems;

            return View();
        }

        [HttpPost]
        public ActionResult AllocateClassrooms(ClassAllocation classroomAllocation, int fromHour, int fromMin, string fromAmPm, int toHour, int toMin, string toAmPm)
        {
            List<SelectListItem> aDepartments = departmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            List<SelectListItem> aRoomNos = classAllocationManager.GetAllRoomNos();
            ViewBag.RoomNo = aRoomNos;

            List<SelectListItem> daysListItems = classAllocationManager.GetAllDays();
            ViewBag.Day = daysListItems;

            classroomAllocation.From = ConvertTime(fromHour, fromMin, fromAmPm);
            classroomAllocation.To = ConvertTime(toHour, toMin, toAmPm);

            string message = classAllocationManager.SaveClassroomAllocationInfo(classroomAllocation);
            ViewBag.message = message;

         
            if (ViewBag.message == "invalid time")
            {
                ViewBag.From = GetTimeString(classroomAllocation.From);
                ViewBag.To = GetTimeString(classroomAllocation.To);
            }
            ModelState.Clear(); 

            return View();
        }
        public int ConvertTime(int hour, int minute, string ampm)
        {
            if (ampm == "pm")
            {
                if (hour != 12)
                    hour += 12;
                hour *= 60;
                minute += hour;
                return minute;
            }
            if (hour == 12)
                hour = 0;
            hour *= 60;
            minute += hour;
            return minute;

        }
        private string GetTimeString(int minuteTime)
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
        public ActionResult CompleteClassSchedule()
        {
            List<Department> departments = departmentManager.GetAllDepartmentsInfo();
            ViewBag.Departments = departments;
            return View();
        }

        public JsonResult GetTeachersByDepartmentId(int departmentId)
        {
            List<Teacher> teachers = aTeacherManager.GetAllTeachers();
            List<Teacher> teacherList = teachers.Where(a => a.DepartmentId == departmentId).ToList();
            return Json(teacherList, JsonRequestBehavior.AllowGet);
        }



        public JsonResult GetClassScheduleByDeptId(int departmentId)
        {
            List<ClassScheduleFinal> classScheduleFinals = classAllocationManager.GetClassScheduleByDeptId(departmentId);
            return Json(classScheduleFinals, JsonRequestBehavior.AllowGet);
        }
        public ActionResult UnallocateClassRoom()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UnallocateClassRoom(int? id)
        {
            ViewBag.message = classAllocationManager.UnallocateClassRoom();
            return View();
        }
    }
}