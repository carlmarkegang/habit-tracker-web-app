<%@ Page Title="Habits" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="habit._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <h1>Habits</h1>
        <h4>
            <div id="startdatetext" style="display:none;">Enter the date you started you new habit and click "Start!"</div>
            <input type="text" id="datepicker" style="cursor: pointer; background-color: #f0ece3; border: 0px;width: 130px;" title="Click here to change date"> <a id="startdatesubmit" style="display:none;" href="#">Start!</a>
        </h4>
        <div id="rectangles" style="display:none;">
        </div>
    </div>

    <div id="rectangles_submenu" style="display:none;">
        <a href="#" title="Resets ALL your progress" id="resetprogress">Reset</a>
        <label class="switch" title="Automatically marks boxes as done when you hover your mouse over them">
            <input type="checkbox" id="specialAbility" >
            <span class="slider round"></span>
        </label>
        <span title="Automatically marks boxes as done when you hover your mouse over them">Autoclick</span>
    </div>


    <script src="Scripts/main.js"></script>

    <script type="text/javascript">
    var idleTime = 0;
    $(document).ready(function () {
        // Increment the idle time counter every minute.
        var idleInterval = setInterval(timerIncrement, 60000); // 1 minute

        // Zero the idle timer on mouse movement.
        $(this).mousemove(function (e) {
            idleTime = 0;
        });
        $(this).keypress(function (e) {
            idleTime = 0;
        });
    });

    function timerIncrement() {
        idleTime = idleTime + 1;
        if (idleTime > 1) {
            // 2 minutes
            GetFromServer();
        }
    }
    </script>

</asp:Content>
