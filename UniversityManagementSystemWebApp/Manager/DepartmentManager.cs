using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Gateway;
using UniversityManagementSystemWebApp.Models;

namespace UniversityManagementSystemWebApp.Manager
{
    public class DepartmentManager
    {
        private DepartmentGateway aDepartmentGateway = new DepartmentGateway();

        public string Save(Department aDepartment)
        {
            if (aDepartment.Code.Length <=7 && aDepartment.Code.Length>=2 && aDepartment.Name!=null)
            {
                if (aDepartmentGateway.IsCodeExits(aDepartment.Code) != null)
                {
                    return "Code Not Unique";
                }

                if (aDepartmentGateway.IsDepartmentNameExists(aDepartment.Name) != null)
                {
                    return "Name Not Unique";
                }


                int rowAffected = aDepartmentGateway.Save(aDepartment);
                if (rowAffected > 0)
                {

                    return "Saved";

                }
                else
                {
                    return "Saving Failed";
                }
            }
            else
            {
                return "Note: 1. Code must contain atleast 2 or upto 6 digit /n 2.Code Name can't be empty"; ;
            }
           
        }


        public List<SelectListItem> GetAllDepartment()
        {
            return aDepartmentGateway.GetAllDepartment();
        }

        public List<SelectListItem> GetAllSemester()
        {
            return aDepartmentGateway.GetAllSemester();
        }



        public List<Department> GetAllDepartmentsInfo()
        {
            return aDepartmentGateway.GetAllDepartmentsInfo();
        }

    }
}
