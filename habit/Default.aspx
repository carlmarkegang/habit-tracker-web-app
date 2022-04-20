<%@ Page Title="Habits" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="habit._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <h1>Habits</h1>
        <h4>
            <input type="text" id="datepicker" style="cursor: pointer;">
            
            <label class="switch">
                <input type="checkbox" id="specialAbility"> 
                <span class="slider round"></span>
            </label>
            Autoclick
        </h4>
        <div id="rectangles">
        </div>
    </div>

    <div>
        <a href="ResetProgress.aspx" id="resetprogress">Reset</a>
    </div>


    <script src="Scripts/main.js"></script>
    <script>
        $(function () {
            $("#datepicker").datepicker();
        });
    </script>

</asp:Content>
