﻿<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.Master" CodeBehind="CreateUser.aspx.cs" Inherits="habit.CreateUser" Title="Create User" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div>
        <h3>Get started today!</h3>
        <h2 runat="server" id="error" style="color: red;"></h2>
        <input type="text" name="username" placeholder="Username" /><br />
        <input type="password" name="password" placeholder="Password" /><br />
        <input type="submit" value="Create user" class="btn btn-primary" />

        <br /><br />
        <p>
            <a href="/">Back to Login</a>
        </p>

    </div>

</asp:Content>
