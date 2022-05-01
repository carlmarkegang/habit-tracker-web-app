<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="Login.aspx.cs" Inherits="habit.Login" Title="Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div>

        <div style="width: 50%; float: right; display: inline-block; padding-top: 110px; padding-left: 50px;">
            <h1>Login</h1>
            <h2 runat="server" id="error" style="color: red;"></h2>
            <input type="text" name="username" placeholder="Username" /><br />
            <input type="password" name="password" placeholder="Password" /><br />
            <input type="submit" value="Login" class="btn btn-primary" />
        </div>

        <div style="width: 50%; float: right; display: inline-block;">
            <h1>Quit you bad habits today!</h1>
            <p>The first days are hardest when you are breaking you bad habits.</p>

            <p>Use this calender to get you motivated to get started!</p>
            <img src="/Content/Images/Screenshot.png" style="width: 350px;" alt="Example of what the website looks like logged in" title="Example of what the website looks like logged in">
        </div>


        <div style="width: 100%; float: left; display: inline-block;">
            <hr />
            <p><a href="/CreateUser.aspx" class="btn btn-success" role="button"><strong>Create new user</strong></a></p>
            <p><a href="/Example.aspx" class="btn btn-info" role="button"><strong>See example</strong></a></p>
        </div>
    </div>

</asp:Content>
