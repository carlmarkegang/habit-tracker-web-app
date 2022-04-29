<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="CreateUser.aspx.cs" Inherits="habit.CreateUser" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div>
        <h1>Create User</h1>
        <h2 runat="server" id="error" style="color: red;"></h2>
        <input type="text" name="username" placeholder="username" /><br />
        <input type="text" name="password" placeholder="password" /><br />
        <input type="submit" value="Login" />
    </div>

</asp:Content>
