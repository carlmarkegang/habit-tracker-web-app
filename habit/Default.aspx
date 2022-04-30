<%@ Page Title="Habits" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="habit._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="rectangles_wrap">
        <div>
            <h1><br /></h1>
            <h4>
                <div id="startdatetext" style="display: none;">Enter the date you started you new habit and click "Start!"</div>
                <input type="text" id="datepicker" style="cursor: pointer; background-color: #f0ece3; border: 0px; width: 130px;" title="Click here to change date">
                <a id="startdatesubmit" style="display: none;" href="#">Start!</a>
            </h4>
            <div id="rectangles" style="display: none;">
            </div>
        </div>

        <div id="rectangles_submenu" style="display: none;">
            <a href="#" title="Resets ALL your progress" id="resetprogress">Reset</a>
            <label class="switch" title="Automatically marks boxes as done when you hover your mouse over them">
                <input type="checkbox" id="specialAbility">
                <span class="slider round"></span>
            </label>
            <span title="Automatically marks boxes as done when you hover your mouse over them">Autoclick</span>
        </div>
    </div>
     <div id="rectangles_description_wrap">
         <h2>Habits</h2>
         <p>Each block represent a small part of your day.</p>
         <p>As the day goes on more blocks will be unlocked for you to click.</p>
         
         
         <p><span class="individualRectangle" style="background-color: rgb(223, 201, 152); border: 3px solid rgb(173, 161, 135); box-shadow: 0px 0px 0px;"></span><span style="height: 40px;display: inline-block;vertical-align: top;line-height: 40px;">This type of block is not avaible yet</span></p>
         <p><span class="individualRectangle" style="pointer-events: none;"></span><span style="height: 40px;display: inline-block;vertical-align: top;line-height: 40px;">This type of block can be clicked</span></p>
         <p>You can click the larger block to complete all avalible blocks for the selected date.</p>
         <p>You can select another date by clicking the date above the blocks.</p>
         <p>If you fail to follow your new habit you can click the reset button to start fresh</p>
         
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
