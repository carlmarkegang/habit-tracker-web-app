<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="habit._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div>

        <div id="rectangles">
        </div>
    </div>

    <script>
        var currentdate = new Date();
        var minutesPassedForDate = (currentdate.getHours() * 60) + currentdate.getMinutes();
        var totalMinutesInADay = 1440;


        var RectanglesAmount = 96; // 24 * 4;
        var RectanglesAdded = 0;
        var RectanglesMinutes = 0;
        var specialAbil = false;
        function DrawRects() {
            for (var i = 0; i < RectanglesAmount; i++) {

                // Add rectangle
                RectanglesMinutes += 15;
                $("#rectangles").append("<span class='individualRectangle individualRectangle" + i.toString() + " individualRectangleMinutes" + RectanglesMinutes + "'> </span>");

                // Is block avalible
                if (minutesPassedForDate > RectanglesMinutes) {
                    RectanglesAdded += 1;
                    $(".individualRectangle" + i.toString()).css("background-color", "#A68DAD");
                    $(".individualRectangle" + i.toString()).css("border", "solid 3px #78607e");

                    AddOnClickEvent(".individualRectangle" + i.toString());

                    if (specialAbil == true) {
                        AddOnClickEventAsHover(".individualRectangle" + i.toString());
                    } else {
                        AddHover(".individualRectangle" + i.toString());
                    }
                    

                    $(".individualRectangle" + i.toString()).css('cursor', 'pointer');
                }

                // Add linebreaks
                if (i.toString().slice(-1) == 9) {                  
                        $("#rectangles").append("<div> </div>");
                }

                // Add end block
                if (i == 95) {
                    $("#rectangles").append("<div class='RectanglesEndBlock'></div>");
                }
            }
            UpdateCompletedCount();

            
        }


        DrawRects();

        function AddHover(element) {
            $(element).hover(
                function () {
                    $(element).css('background-color', '#7f5c89');           
                }, function () {
                    $(element).css('background-color', '#A68DAD');
                }
            );
        }


        function AddOnClickEvent(element) {
            $(element).click(function () {
                var clickedRectangle = this;
                $(clickedRectangle).unbind('mouseenter mouseleave');
                $(clickedRectangle).unbind('click');
                $(clickedRectangle).css('background-color', 'rgb(133 169 140)');
                $(clickedRectangle).css('border', 'none');
                UpdateCompletedCount();
            });
        }

        function AddOnClickEventAsHover(element) {
            $(element).hover(function () {
                var clickedRectangle = this;
                $(clickedRectangle).unbind('mouseenter mouseleave');
                $(clickedRectangle).unbind('click');
                $(clickedRectangle).css('background-color', 'rgb(133 169 140)');
                $(clickedRectangle).css('border', 'none');
                UpdateCompletedCount();
            });
        }


        function resetBackgroundColor(element) {
            $("." + element).css('background-color', '#A68DAD');
        }

        function AddBackgroundColor(element) {
            $("." + element).css('background-color', '#7f5c89');
        }

        function UpdateCompletedCount() {
            var clickedRectangles = 0;
            for (var i = 0; i < RectanglesAmount; i++) {

                if ($(".individualRectangle" + i.toString()).css('border').includes('none')) {
                    clickedRectangles += 1;
                }
            };
            $(".RectanglesEndBlock").html(clickedRectangles + "/96");
        }


        function randomIntFromInterval(min, max) {
            return Math.floor(Math.random() * (max - min + 1) + min)
        }

    </script>

</asp:Content>
