using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;

namespace UniversityManagementSystemWebApp.Gateway
{
    
    public class Gateway
    {
        string connectionString = WebConfigurationManager.ConnectionStrings["UniversityManagementDBConnection"].ConnectionString;

        public SqlConnection Connection { get; set; }
        public SqlCommand Command { get; set; }
        public SqlDataReader Reader { get; set; }
        public String Query { get; set; }

        public Gateway()
        {
            Connection = new SqlConnection(connectionString);
            Command = new SqlCommand();
            
        }
    }
}
