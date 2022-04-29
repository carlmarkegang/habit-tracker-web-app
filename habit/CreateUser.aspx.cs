using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace habit
{
    public partial class CreateUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (IsPostBack)
            {
                var UserId = GetUser(Request.Form["username"]);
                if (UserId == "")
                {
                    string UserFile = AppDomain.CurrentDomain.BaseDirectory + "files\\Users\\Process\\" + Request.Form["username"] + ".txt";
                    File.AppendAllLines(UserFile, new[] { Request.Form["username"] + Environment.NewLine + Request.Form["password"] });
                    Response.Redirect("/process");
                }
                else
                {
                    error.InnerText = "Username already taken";
                }

            }

        }


        public string GetUser(string username)
        {

            var filePath = AppDomain.CurrentDomain.BaseDirectory + "files\\Users\\";
            var FileName = "Users.xml";

            XmlDocument doc = new XmlDocument();
            doc.Load(filePath + FileName);
            XmlNodeList UserNode = doc.SelectNodes("Users/User");

            foreach (XmlNode user in UserNode)
            {
                if (user.InnerText.ToLower() == username.ToLower())
                {
                    return user.Attributes["id"].Value;
                }
            }

            return "";


        }
    }
}