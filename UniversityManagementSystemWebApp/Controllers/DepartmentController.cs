using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Manager;
using UniversityManagementSystemWebApp.Models;

namespace UniversityManagementSystemWebApp.Controllers
{
    public class DepartmentController : Controller
    {
        DepartmentManager aDepartmentManager = new DepartmentManager();
        

        public ActionResult Save()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Save(Department aDepartment)
        {

            ViewBag.message = aDepartmentManager.Save(aDepartment);
            ViewBag.code = aDepartment.Code;
            ViewBag.name = aDepartment.Name;

            if (ViewBag.message == "Saved")
            {
                ModelState.Clear(); 
            }

            return View();
        }

        public ActionResult ShowDepartment()
        {
            List<Department> aDepartments = aDepartmentManager.GetAllDepartmentsInfo();
            ViewBag.departments = aDepartments;
            return View();
        }
    }
}