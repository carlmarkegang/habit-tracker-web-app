var currentdate = new Date();
var selectedDate = new Date();
var minutesPassedForDate = (currentdate.getHours() * 60) + currentdate.getMinutes();
var totalMinutesInADay = 1440;
var startdate = new Date();


var RectanglesAmount = 96; // 24 * 4;
var RectanglesAdded = 0;

var specialAbil = false;

function DrawRects() {
    var RectanglesMinutes = 0;
    $("#rectangles").html("");


    // Depending if its today, a date in the future or a date in the passed the blocks should be avalible or disabled
    var currentDateDrawRect = new Date(currentdate).toLocaleDateString('en-US', { day: '2-digit', month: '2-digit', year: 'numeric', });
    var selectedDateDrawRect = new Date(selectedDate).toLocaleDateString('en-US', { day: '2-digit', month: '2-digit', year: 'numeric', });
    if (currentDateDrawRect == selectedDateDrawRect) {
        minutesPassedForDate = (currentdate.getHours() * 60) + currentdate.getMinutes();
    } else if (currentDateDrawRect > selectedDateDrawRect) {
        minutesPassedForDate = 1440;
    } else if (currentDateDrawRect < selectedDateDrawRect) {
        minutesPassedForDate = 0;
    }

    // Draw the view
    for (var i = 0; i < RectanglesAmount; i++) {

        // Add rectangle
        RectanglesMinutes += 15;
        $("#rectangles").append("<span class='individualRectangle individualRectangle" + i.toString() + " individualRectangleMinutes" + RectanglesMinutes + "'> </span>");

        // Is block avalible
        if (minutesPassedForDate >= RectanglesMinutes && selectedDate >= startdate) {
            RectanglesAdded += 1;
            AddOnClickEvent(".individualRectangle" + i.toString());
            AddOnClickEventAsHover(".individualRectangle" + i.toString());
            $(".individualRectangle" + i.toString()).css('cursor', 'pointer');

        } else {
            // Inactive rectangle
            $(".individualRectangle" + i.toString()).css("background-color", "#dfc998");
            $(".individualRectangle" + i.toString()).css("border", "solid 3px #ada187");
            $(".individualRectangle" + i.toString()).css("box-shadow", "0px 0px 0px");
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



    $(".RectanglesEndBlock").click(function () {
        var time1 = 0;
        $(".individualRectangle").each(function (index) {
            var classnname = this.className.split(" ")[1];
            setTimeout(function () { $("." + classnname).click(); }, time1);
            time1 += 20;

        });
    });

}


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
        if (specialAbil == false) {
            var clickedRectangle = this;
            $(clickedRectangle).unbind('mouseenter mouseleave');
            $(clickedRectangle).unbind('click');
            $(clickedRectangle).css('background-color', 'rgb(133 169 140)');
            $(clickedRectangle).css('border', 'none');
            UpdateCompletedCount();
        }
    });
}


function AddOnClickEventAsHover(element) {
    $(element).hover(function () {
        if (specialAbil == true) {
            var clickedRectangle = this;
            $(clickedRectangle).unbind('mouseenter mouseleave');
            $(clickedRectangle).unbind('click');
            $(clickedRectangle).css('background-color', 'rgb(133 169 140)');
            $(clickedRectangle).css('border', 'none');
            UpdateCompletedCount();
        }
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

    if (clickedRectangles == "96") {
        $(".RectanglesEndBlock").css("background-color", "#85a98c");
    } else {
        $(".RectanglesEndBlock").css("background-color", "#a68dad");
    }
}


function UpdateAgainstServer() {
    selectedDate = new Date($("#datepicker").val())
    var clickedBlocks = [];

    for (var i = 0; i < RectanglesAmount; i++) {
        if ($(".individualRectangle" + i.toString()).css('border').includes('none')) {
            clickedBlocks.push("individualRectangle" + i.toString())
        }
    };

    $.ajax({
        type: "POST",
        cache: false,
        url: "Server.aspx/UpdateAgainstServer",
        data: JSON.stringify({ Clicked: clickedBlocks, Date: selectedDate }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            // Do something
        }
    });
}


function GetFromServer() {
    selectedDate = new Date($("#datepicker").val())

    $.ajax({
        type: "POST",
        cache: false,
        url: "Server.aspx/GetFromServer",
        data: JSON.stringify({ Date: selectedDate }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            $("label").click(function () {

                if ($("#specialAbility").is(':checked')) {
                    specialAbil = true;
                } else {
                    specialAbil = false;
                }

            });

            GetStartDate();
            setTimeout(function () { SetAsClicked(msg.d.split(',')); }, 200);
            
        }
    });
}



function UpdateStartDate() {
    selectedDate = new Date($("#datepicker").val())

    $.ajax({
        type: "POST",
        cache: false,
        url: "Server.aspx/UpdateStartDate",
        data: JSON.stringify({ Date: selectedDate }),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            location.reload();
        }
    });
}

function GetStartDate() {
    selectedDate = new Date($("#datepicker").val());
    $.ajax({
        type: "POST",
        cache: false,
        url: "Server.aspx/GetStartDate",
        data: "",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            if (msg.d == "FileNotCreated") {
                $("#rectangles").css("display", "none");
                $("#rectangles_submenu").css("display", "none");
                $("#startdatetext").css("display", "block");
                $("#startdatetext").css("padding", "10px 0px");
                $("#datepicker").css("background-color", "#ffffff");
                $("#datepicker").css("border", "2px solid #3c3c3c");
                $("#startdatesubmit").css("display", "inline-block");

                $("#startdatesubmit").click(function () {
                    UpdateStartDate();
                });
            }

            startdate = new Date(msg.d);

            $(function () {
                $("#datepicker").datepicker({
                    minDate: startdate,
                    changeMonth: true,
                    changeYear: true,
                    beforeShowDay: function (d) {
                        var a = new Date();
                        var b = new Date();
                        a.setDate(a.getDate() - 5);
                        b.setDate(b.getDate() + 5);
                        return [true, a <= d && d <= b ? ".highlightDate" : ""];
                    }
                });
            });



            DrawRects();          
            UpdateCompletedCount();
           


        }
    });
}

function SetAsClicked(clickedArray) {
    var clickedRectangles = 0;

    for (var i = 0; i < RectanglesAmount; i++) {

        if (clickedArray.includes("individualRectangle" + i.toString())) {
            $(".individualRectangle" + i.toString()).click();
            clickedRectangles++;
        }
    };

    $(".RectanglesEndBlock").html(clickedRectangles + "/96");

    $("#rectangles").fadeIn();
    $("#rectangles_submenu").fadeIn();

}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}

var DateFormatted = new Date(currentdate).toLocaleDateString('en-US', { day: '2-digit', month: '2-digit', year: 'numeric', });
$("#datepicker").val(DateFormatted);


$("#datepicker").change(function () {
    $("#rectangles").css("display", "none");
    $("#rectangles_submenu").css("display", "none");
    setTimeout(function () { GetFromServer(); }, 200);
   
    
});


$(function () {
    $(document).tooltip({
        position: { my: "left+10", at: "right" }
    });
});

$("#resetprogress").click(function () {
    var text = "Are you sure you want to reset your progress?";
    if (confirm(text) == true) {
        window.location.href = "/ResetProgress.aspx";
    } else {

    }
});



setInterval(UpdateAgainstServer, 2000);
GetFromServer();

