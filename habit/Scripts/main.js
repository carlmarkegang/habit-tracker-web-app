var currentdate = new Date();
var selectedDate = new Date();
var minutesPassedForDate = (currentdate.getHours() * 60) + currentdate.getMinutes();
var totalMinutesInADay = 1440;


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
        if (minutesPassedForDate >= RectanglesMinutes) {
            RectanglesAdded += 1;


            AddOnClickEvent(".individualRectangle" + i.toString());

            AddOnClickEventAsHover(".individualRectangle" + i.toString());
            //AddHover(".individualRectangle" + i.toString());



            $(".individualRectangle" + i.toString()).css('cursor', 'pointer');
        } else {
            // Inactive
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

            DrawRects();
            SetAsClicked(msg.d.split(','));
            UpdateCompletedCount();
            setInterval(UpdateAgainstServer, 3000);



        }
    });
}

function SetAsClicked(clickedArray) {
    var clickedRectangles = 0;

    for (var i = 0; i < RectanglesAmount; i++) {

        if (clickedArray.includes("individualRectangle" + i.toString())) {
            $(".individualRectangle" + i.toString()).click();
        }
    };

    $(".RectanglesEndBlock").html(clickedRectangles + "/96");

}


function randomIntFromInterval(min, max) {
    return Math.floor(Math.random() * (max - min + 1) + min)
}

var DateFormatted = new Date(currentdate).toLocaleDateString('en-US', { day: '2-digit', month: '2-digit', year: 'numeric', });
$("#datepicker").val(DateFormatted);


$("#datepicker").change(function () {
    GetFromServer();
});

$(function () {
    $("#datepicker").datepicker();
});

$(function () {
    $(document).tooltip();
});

$("#resetprogress").click(function () {
    var text = "Are you sure you want to reset your progress?";
    if (confirm(text) == true) {
        window.location.href = "/ResetProgress.aspx";
    } else {

    }
});




GetFromServer();
