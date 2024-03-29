﻿using System;
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

            if (IsPostBack)
            {
                var UserId = GetUser(Request.Form["username"], Request.Form["password"]);
                if (UserId == "")
                {
                    error.InnerText = "Failed";
                }
                else
                {
                    Session["LoginUser"] = UserId;
                    Response.Redirect("/");
                }

            }
        }


        public string GetUser(string username, string password)
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
                    if (user.Attributes["password"].Value == password)
                    {
                        return user.Attributes["id"].Value;
                    }
                }
            }

            return "";


        }
    }
}