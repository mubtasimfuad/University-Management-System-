using System.Collections.Generic;
using System.Web.Mvc;
using UniversityManagementSystemWebApp.Gateway;
using UniversityManagementSystemWebApp.Models;
using UniversityManagementSystemWebApp.Models.View_Model;

namespace UniversityManagementSystemWebApp.Manager
{
    public class ClassAllocationManager
    {
        ClassAllocationGateway classAllocationGateway = new ClassAllocationGateway();
        public List<SelectListItem> GetAllRoomNos()
        {
            return classAllocationGateway.GetAllRoomNos();
        }

        public List<SelectListItem> GetAllDays()
        {
            return classAllocationGateway.GetAllDays();
        }


        public string SaveClassroomAllocationInfo(ClassAllocation classroomAllocation)
        {
            
            if (classAllocationGateway.IsClassRoomAlreadyAllocated(classroomAllocation))
                return "conflict";
            
            if (classroomAllocation.To < classroomAllocation.From)
                return "invalid time";
            int rowAffected = classAllocationGateway.SaveClassAllocation(classroomAllocation);
            if (rowAffected > 0)
                return "yes";
            else
            {
                return "no";
            }
        }

        public List<ClassScheduleFinal> GetClassScheduleByDeptId(int departmentId)
        {
            return classAllocationGateway.GetFinalClassScheduleByDeptId(departmentId);
        }


        public object UnallocateClassRoom()
        {
            int rowAffected = classAllocationGateway.UnallocateClassRoom();
            if (rowAffected > 0)
                return "yes";
            else
                return "no";
        }
    }
}