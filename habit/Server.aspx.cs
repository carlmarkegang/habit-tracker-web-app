﻿using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace habit
{
    public partial class Server : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Response.Redirect("/");

        }

        [WebMethod(EnableSession = true)]
        public static string GetFromServer(DateTime Date)
        {
            var LoginUser = HttpContext.Current.Session["LoginUser"];
            
            var filePath = AppDomain.CurrentDomain.BaseDirectory + "files\\Habits\\" ;
            var FileName = LoginUser.ToString() + "_" + Date.ToString("yyyy-MM-dd") + ".xml";

            if (!File.Exists(filePath))
            {
                return "";
            }
            List<string> Returnlist = new List<string>();
            
            XmlDocument doc = new XmlDocument();
            doc.Load(filePath + FileName);
            XmlNodeList ClickedNodeList = doc.SelectNodes("User/Date/Clicked");

            foreach (XmlNode Clicked in ClickedNodeList)
            {
                Returnlist.Add(Clicked.InnerText);
            }

            string returnstring = string.Join(",", Returnlist);

            return returnstring;
        }


        [WebMethod(EnableSession = true)]
        public static string UpdateAgainstServer(string[] Clicked, DateTime Date)
        {
            var LoginUser = HttpContext.Current.Session["LoginUser"];
            var SavePath = AppDomain.CurrentDomain.BaseDirectory + "files\\Habits\\";
            var FileName = LoginUser.ToString() + "_" + Date.ToString("yyyy-MM-dd") + ".xml";

            XmlDocument doc = new XmlDocument();
            XmlElement User = doc.CreateElement("User");
            doc.AppendChild(User);

            XmlElement DateNode = doc.CreateElement("Date");
            DateNode.InnerText = "";
            DateNode.SetAttribute("Date", Date.ToString());
            User.AppendChild(DateNode);


            foreach (string ClickedElement in Clicked)
            {
                XmlElement ClickedNode = doc.CreateElement("Clicked");
                ClickedNode.InnerText = ClickedElement;
                DateNode.AppendChild(ClickedNode);
            }

            doc.Save(SavePath + FileName);


            return "Ok";
        }



    }
}