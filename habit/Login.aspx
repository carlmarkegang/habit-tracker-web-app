<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Login.aspx.cs" Inherits="habit.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


        <div>
             <h1>Login</h1>
            <h2 runat="server" id="error" style="color:red;"></h2>
            <input type="text" name="username" />
            <input type="submit" />
        </div>

</asp:Content>
