using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Manager;
using UniversityManagementSystemWebApp.Models;

namespace UniversityManagementSystemWebApp.Controllers
{
    public class TeacherController : Controller
    {
        TeacherManager aTeacherManager = new TeacherManager();
        DepartmentManager aDepartmentManager = new DepartmentManager();
        //
        // GET: /Teacher/
        public ActionResult Save()
        {
            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            List<SelectListItem> designations = aTeacherManager.GetAllDesignation();
            ViewBag.designations = designations;



            return View();
        }


        [HttpPost]
        public ActionResult Save(Teacher aTeacher)
        {
            List<SelectListItem> aDepartments = aDepartmentManager.GetAllDepartment();
            ViewBag.departments = aDepartments;

            List<SelectListItem> designations = aTeacherManager.GetAllDesignation();
            ViewBag.designations = designations;

            ViewBag.message = aTeacherManager.SaveTeacher(aTeacher);
            ViewBag.teacherName = aTeacher.Name;
            ViewBag.email = aTeacher.Email;


            if (ViewBag.message == "yes")
            {
                ModelState.Clear(); //clear after submiting
            }
            return View();
        }
        public ActionResult Assign()
        {
            List<Department> departments = aDepartmentManager.GetAllDepartmentsInfo();
            ViewBag.Departments = departments;
            return View();
        }

        [HttpPost]
        public ActionResult Assign(AssignCourse assignCourse)
        {
            string msg = aTeacherManager.AssignCourseToTeacher(assignCourse);
                ModelState.Clear(); 
            ViewBag.Message = msg;
            List<Department> departments = aDepartmentManager.GetAllDepartmentsInfo();
            
            ViewBag.Departments = departments;
            return View();
        }

        public JsonResult GetTeachersByDepartmentId(int departmentId)
        {
            List<Teacher> teachers = aTeacherManager.GetAllTeachers();
            List<Teacher> teacherList = teachers.Where(a => a.DepartmentId == departmentId).ToList();
            return Json(teacherList, JsonRequestBehavior.AllowGet);
        }
          
        public JsonResult GetCreditLimitByTeacherId(int teacherId)
        {
            List<Teacher> teachers = aTeacherManager.GetAllTeachers();
            List<Teacher> teacherList = teachers.Where(a => a.Id == teacherId).ToList();
            //double CreditLimit = aTeacher.CreditLimit;
            return Json(teacherList, JsonRequestBehavior.AllowGet);
        }
	}
}
        
        
       
    
