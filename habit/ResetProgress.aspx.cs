using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace habit
{
    public partial class ResetProgress : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            System.IO.DirectoryInfo di = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + "files\\Habits");

            foreach (FileInfo file in di.GetFiles())
            {
                if (file.Extension == ".xml")
                {
                    if (file.Name.StartsWith(Session["LoginUser"] + "_"))
                    {
                        file.Delete();
                    }
                }

            }

            System.IO.DirectoryInfo di2 = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + "files\\Users\\User");

            foreach (FileInfo file in di2.GetFiles())
            {
                if (file.Extension == ".xml")
                {
                    if (file.Name == Session["LoginUser"] + ".xml")
                    {
                        file.Delete();
                    }
                }

            }


            Response.Redirect("/");
        }
    }
}