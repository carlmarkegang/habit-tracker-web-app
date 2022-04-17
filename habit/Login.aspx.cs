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
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            var UserId = GetUser("User1");
            Session["LoginUser"] = UserId;

            Response.Redirect("/");
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
                if (user.InnerText == username)
                {
                    return user.Attributes["id"].Value;
                }
            }

            return "";
  

        }
    }
}