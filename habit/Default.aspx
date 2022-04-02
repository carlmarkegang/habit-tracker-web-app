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
            $(".individualRectangle").each(function (index) {
       
                if (clickedRectangle.className.slice(-1) == this.className.slice(-1) || clickedRectangle.className.slice(-2)[0] == this.className.slice(-2)[0] ) {
                    $(this).css('background-color', '#7f5c89');
                }
                setTimeout(function () {                  
                    resetAllBackgroundColor()
                }, 5000);
                
            });

        });

        function resetAllBackgroundColor() {
            $(".individualRectangle").each(function (index) {
                $(this).css('background-color', '#A68DAD');
            });
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
