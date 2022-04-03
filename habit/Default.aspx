<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="habit._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div>

        <div id="rectangles">
        </div>
    </div>

    <script>
        var currentdate = new Date();

        var RectanglesAmount = 96; // 24 * 4;

        for (var i = 0; i < RectanglesAmount; i++) {
            var randomint = randomIntFromInterval(1, 6)
            $("#rectangles").append("<span class='individualRectangle individualRectangle" + i.toString() + "'> </span>");

            if (i.toString().slice(-1) == 9) {
                $("#rectangles").append("<div> </div>");
            }

            if (i == 95) {
                $("#rectangles").append("<div class='RectanglesEndBlock'>96/96</div>");
            }
        }

        $(".individualRectangle").click(function () {
            var clickedRectangle = this;

            var time1 = 10;
            var time2 = 10;
            $(".individualRectangle").each(function (index) {
       
                if (clickedRectangle.className.slice(-1) == this.className.slice(-1)) {
                    var classnname = this.className.split(" ")[1];
                    setTimeout(function () { AddBackgroundColor(classnname); }, time1);
                    setTimeout(function () { resetBackgroundColor(classnname); }, 800);
                    time1 += 20;
                }

                if (clickedRectangle.className.slice(-2)[0] == this.className.slice(-2)[0]) {
                    var classnname = this.className.split(" ")[1];
                    setTimeout(function () { AddBackgroundColor(classnname); }, time2);
                    setTimeout(function () { resetBackgroundColor(classnname); }, 800);
                    time2 += 20;
                }

                
                
            });

        });

        function resetBackgroundColor(element) {
            $("." + element).css('background-color', '#A68DAD');
        }

        function AddBackgroundColor(element) {

            $("." + element).css('background-color', '#7f5c89');
        }

        /*
        $(".individualRectangle").hover(function () {
            $(".individualRectangle").each(function (index) {
                $(this).css('border-radius','0%');
            });
        }, function () {
            $(".individualRectangle").each(function (index) {
               
                $(this).css('border-radius', this.className.split(" ")[1].slice(-1) + "0%");
            });
        });
        */

        function randomIntFromInterval(min, max) { // min and max included 
            return Math.floor(Math.random() * (max - min + 1) + min)
        }

    </script>
    <style>
        .individualRectangle:hover {
            background-color:#b16cc5;
        }
    </style>
</asp:Content>
