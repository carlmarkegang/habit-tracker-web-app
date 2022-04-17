<%@ Page Title="Habits" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="habit._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <h1>Habits</h1>
        <div id="rectangles">
        </div>
    </div>

    <div>
        <a href="ResetProgress.aspx" id="resetprogress">Reset</a>
    </div>
    

    <script src="Scripts/main.js"></script>

</asp:Content>
