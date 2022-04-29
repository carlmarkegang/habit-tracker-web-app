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
            var res = ProcessUsers();
            Response.Redirect("/");
        }


        public string ProcessUsers()
        {
            string LockFile = AppDomain.CurrentDomain.BaseDirectory + "files\\Users\\Process\\Lock\\Lock.txt";
            if (!File.Exists(LockFile))
            {
                File.AppendAllLines(LockFile, new[] { "Locked" });

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
                        var textSplit = text.Split(new string[] { Environment.NewLine }, StringSplitOptions.None);
                        XmlElement CreatedUser = doc.CreateElement("User");
                        CreatedUser.InnerText = textSplit[0];
                        CreatedUser.SetAttribute("password", textSplit[1]);
                        CreatedUser.SetAttribute("id", NewId.ToString());
                        UsersNode.AppendChild(CreatedUser);

                        File.Move(file.FullName, AppDomain.CurrentDomain.BaseDirectory + "files\\Users\\Process\\Done\\" + file.Name);
                        File.Delete(LockFile);
                    }

                }


                doc.Save(filePath + FileName);
            }
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