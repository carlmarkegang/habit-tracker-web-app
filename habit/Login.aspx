<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Login.aspx.cs" Inherits="habit.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div>
        <h1>Login</h1>
        <h2 runat="server" id="error" style="color: red;"></h2>
        <input type="text" name="username" placeholder="Username" /><br />
        <input type="password" name="password" placeholder="Password" /><br />
        <input type="submit" value="Login" />
        <br /><br />
        <p><a href="/CreateUser.aspx"><strong>Create new user</strong></a></p>
        <p><a href="/Example.aspx"><strong>See example</strong></a></p>
    </div>

</asp:Content>
