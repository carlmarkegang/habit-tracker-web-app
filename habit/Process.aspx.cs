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
    public partial class Process : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["hash"] == "rehfgh5g43gset")
            {
                var res = ProcessUsers();
            }
        }


        public string ProcessUsers()
        {

            var filePath = AppDomain.CurrentDomain.BaseDirectory + "files\\Users\\";
            var FileName = "Users.xml";

            XmlDocument doc = new XmlDocument();
            doc.Load(filePath + FileName);
            XmlNode UsersNode = doc.SelectSingleNode("Users");

            System.IO.DirectoryInfo di = new DirectoryInfo(AppDomain.CurrentDomain.BaseDirectory + "files\\Users\\Process");

            foreach (FileInfo file in di.GetFiles())
            {
                if (file.Extension == ".txt")
                {
                    int id = GetHighestUserId(doc);
                    int NewId = id + 1;
                    var text = System.IO.File.ReadAllText(file.FullName);

                    XmlElement CreatedUser = doc.CreateElement("User");
                    CreatedUser.InnerText = text;
                    CreatedUser.SetAttribute("id", NewId.ToString());
                    UsersNode.AppendChild(CreatedUser);

                    File.Move(file.FullName, AppDomain.CurrentDomain.BaseDirectory + "files\\Users\\Process\\Done\\" + file.Name);

                }

            }


            doc.Save(filePath + FileName);
            return "Ok";
        }

        public int GetHighestUserId(XmlDocument doc)
        {
            XmlNodeList Users = doc.SelectNodes("Users/User");
            int higestId = 0;

            foreach (XmlNode User in Users)
            {
                int ID = Convert.ToInt32(User.Attributes["id"].Value);
                if (ID > higestId)
                {
                    higestId = ID;
                }
            }

            return higestId;
        }
    }


}