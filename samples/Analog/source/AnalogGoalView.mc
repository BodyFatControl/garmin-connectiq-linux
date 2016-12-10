//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.System as Sys;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Calendar;
using Toybox.WatchUi as Ui;
using Toybox.Application as App;

// This implements a Goal View for the Analog face
class AnalogGoalView extends Ui.View {
    var goalString;
    var screenShape;

    function initialize(goal) {
        View.initialize();
        screenShape = Sys.getDeviceSettings().screenShape;

        goalString = "GOAL!";

        if(goal == App.GOAL_TYPE_STEPS) {
            goalString = "STEPS " + goalString;
        }
        else if(goal == App.GOAL_TYPE_FLOORS_CLIMBED) {
            goalString = "STAIRS " + goalString;
        }
        else if(goal == App.GOAL_TYPE_ACTIVE_MINUTES) {
            goalString = "ACTIVE " + goalString;
        }
    }

    //! Load the resources required for the watch face
    function onLayout(dc) {
    }

    function onShow() {
    }

    //! Update the clock face graphics during update
    function onUpdate(dc) {
        var width;
        var height;
        var clockTime = Sys.getClockTime();

        width = dc.getWidth();
        height = dc.getHeight();

        var now = Time.now();
        var info = Calendar.info(now, Time.FORMAT_LONG);

        var dateStr = Lang.format("$1$ $2$ $3$", [info.day_of_week, info.month, info.day]);

        // Clear the screen
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        dc.fillRectangle(0, 0, width, height);

        // Draw the gray rectangle
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_DK_GRAY);
        dc.fillPolygon([[0, 0], [width, 0], [width, height], [0, 0]]);

        // Draw the date
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(width / 2, (height / 4), Gfx.FONT_MEDIUM, dateStr, Gfx.TEXT_JUSTIFY_CENTER);

        // Draw the Goal
        dc.drawText(width / 2, (height / 2), Gfx.FONT_MEDIUM, goalString, Gfx.TEXT_JUSTIFY_CENTER);
    }
}
