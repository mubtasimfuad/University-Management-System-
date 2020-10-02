using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Manager;
using UniversityManagementSystemWebApp.Models;
using UniversityManagementSystemWebApp.Models.View_Model;

namespace UniversityManagementSystemWebApp.Controllers
{
    public class CourseController : Controller
    {
        DepartmentManager departmentManager = new DepartmentManager();
        private CourseManager courseManager = new CourseManager();
        
        public ActionResult Save()
        {
           
            List<SelectListItem> aDepartments = departmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;


            List<SelectListItem> aSemesters = departmentManager.GetAllSemester();
            ViewBag.semesters = aSemesters;


            return View();
        }

        [HttpPost]
        public ActionResult Save(Course aCourse)
        {
            
            List<SelectListItem> aDepartments = departmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            List<SelectListItem> aSemesters = departmentManager.GetAllSemester();
            ViewBag.semesters = aSemesters;

            ViewBag.message = courseManager.SaveCourse(aCourse);

            ViewBag.code = aCourse.Code;
            ViewBag.name = aCourse.Name;


            if (ViewBag.message == "Saved")
            {
                ModelState.Clear();    
            }

            return View();
        }




        public JsonResult GetCoursesByDepartmentId(int departmentId)
        {
            List<Course> courses = courseManager.GetAllCourses();
            List<Course> courseList = courses.Where(a => a.DepartmentId == departmentId).ToList();
            return Json(courseList, JsonRequestBehavior.AllowGet);

        }

        public JsonResult GetCourseInfoByCourseId(int courseId)
        {
            List<Course> courses = courseManager.GetAllCourses();
            List<Course> courseList = courses.Where(a => a.Id == courseId).ToList();
            return Json(courseList, JsonRequestBehavior.AllowGet);

        }

        public ActionResult CourseDetails()
        {
            List<Department> departments = departmentManager.GetAllDepartmentsInfo();
            ViewBag.Departments = departments;
            return View();
        }




        public JsonResult GetCourseStatisticsByDeptId(int departmentId)
        {
            List<CourseStatisticView> courseDetailses = courseManager.GetAllCourseDetailsByDeptId(departmentId);
            return Json(courseDetailses, JsonRequestBehavior.AllowGet);
        }


        public ActionResult UnAssignAllCourse()
        {
            return View();
        }

        [HttpPost]
        public ActionResult UnAssignAllCourse(int? id)
        {
            ViewBag.message = courseManager.UnAssignAllCourse();
            return View();
        }
    }
}
