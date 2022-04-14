using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace habit
{
    public partial class Server : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/");
        }


        [WebMethod]
        public static string UpdateAgainstServer(string[] Clicked, DateTime date)
        {
            return "Hello " + Clicked;
        }


    }
}