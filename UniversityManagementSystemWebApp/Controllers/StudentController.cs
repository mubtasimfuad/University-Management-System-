using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Manager;
using UniversityManagementSystemWebApp.Models;
using UniversityManagementSystemWebApp.Models.View_Model;

namespace UniversityManagementSystemWebApp.Controllers
{
    public class StudentController : Controller
    {
        DepartmentManager aDepartmentManager = new DepartmentManager();
        StudentManager aStudentManager = new StudentManager();
         CourseManager aCourseManager = new CourseManager();
         CourseEnrollmentManager aCourseEnrollmentManager = new CourseEnrollmentManager();
        // GET: /Student/

        public ActionResult Register()
        {
            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            return View();
        }

        [HttpPost]
        public ActionResult Register(Student student)
        {
            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            ViewBag.message = aStudentManager.SaveStudent(student);

            ViewBag.RegNo = student.RegNo;
            ViewBag.name = student.Name;
            ViewBag.Email = student.Email;
            ViewBag.ContactNo = student.ContactNo;
            ViewBag.Address = student.Address;
            ViewBag.RegDate = student.RegDate.ToString("dd-MM-yyyy");
            ViewBag.DeptName = student.DeptName;

            if (ViewBag.message == "yes")
            {
                ModelState.Clear(); 
            }
            return View();

        }public ActionResult CourseEnrollment()
        {
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;
            return View();
        }

        [HttpPost]
        public ActionResult CourseEnrollment(CourseEnrollment courseEnrollment)
        {
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;
            string message = aCourseEnrollmentManager.SaveCourseEnrollment(courseEnrollment);
            if (message == "yes" || message == "conflict")
            {
                ModelState.Clear();
            }
            ViewBag.message = message;
            return View();
        }


        public JsonResult GetStudentById(int studentId)
        {
            List<Student> students = aStudentManager.GetStudentById(studentId);

            return Json(students, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCourseThatCanBeTakenByStudentId(int studentId)
        {
            List<Student> students = aStudentManager.GetStudentById(studentId);
            int deptId = students[0].DepartmentId;
            List<Course> courses = aCourseManager.GetAllCourses();
            List<Course> courseList = courses.Where(a => a.DepartmentId == deptId).ToList();
            return Json(courseList, JsonRequestBehavior.AllowGet);
        }

        public JsonResult GetCourseThatAreTakenByStudentId(int studentId)
        {

            List<Course> courses = aCourseEnrollmentManager.GetAllCoursesTakenByStudentId(studentId);
            //List<Course> courseList = courses.Where(a => a.DepartmentId == deptId).ToList();
            return Json(courses, JsonRequestBehavior.AllowGet);
        }

        public ActionResult SaveResult()
        {
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;

            List<SelectListItem> grades = aCourseEnrollmentManager.GetAllGradesSelectListItem();
            ViewBag.Grades = grades;

            return View();
        }

        [HttpPost]
        public ActionResult SaveResult(CourseEnrollment courseEnrollment)
        {
            string msg = aCourseEnrollmentManager.SaveCourseResult(courseEnrollment);
            ViewBag.message = msg;

            if (msg == "yes")
            {
                ModelState.Clear();
            }

            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;

            List<SelectListItem> grades = aCourseEnrollmentManager.GetAllGradesSelectListItem();
            ViewBag.Grades = grades;

            return View();
        }

        public ActionResult ViewResult()
        {
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;
            return View();
        }

        [HttpPost]
        public ActionResult ViewResult(int studentId)
        {

           
            List<SelectListItem> studentListItem = aStudentManager.GetAllStudentsSelectListItem();
            ViewBag.Students = studentListItem;
            return View();
        }

        public JsonResult GetCourseResultByStudentId(int studentId)
        {

            List<StudentCourseView> results = aCourseEnrollmentManager.GetCourseResultByStudentId(studentId);
            return Json(results, JsonRequestBehavior.AllowGet);
        }


       
    }
}