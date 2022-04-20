<%@ Page Title="Habits" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="habit._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <h1>Habits</h1>
        <h4>
            <input type="text" id="datepicker" style="cursor: pointer; background-color: #f0ece3; border: 0px;" title="Click here to change date">
        </h4>
        <div id="rectangles">
        </div>
    </div>

    <div>
        <a href="#" title="Resets ALL your progress" id="resetprogress">Reset</a>
        <label class="switch" title="Automatically marks boxes as done when you hover your mouse over them">
            <input type="checkbox" id="specialAbility" >
            <span class="slider round"></span>
        </label>
        <span title="Automatically marks boxes as done when you hover your mouse over them">Autoclick</span>
    </div>


    <script src="Scripts/main.js"></script>

</asp:Content>
