//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Graphics as Gfx;
using Toybox.Lang as Lang;
using Toybox.Math as Math;
using Toybox.System as Sys;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Calendar;
using Toybox.WatchUi as Ui;

// This implements an analog watch face
// Original design by Austen Harbour
class AnalogView extends Ui.WatchFace
{
    var font;
    var isAwake;
    var screenShape;
    var dndIcon;

    function initialize() {
        WatchFace.initialize();
        screenShape = Sys.getDeviceSettings().screenShape;
    }

    function onLayout(dc) {
        font = Ui.loadResource(Rez.Fonts.id_font_black_diamond);
        if (Sys.getDeviceSettings() has :doNotDisturb) {
            dndIcon = Ui.loadResource(Rez.Drawables.DoNotDisturbIcon);
        } else {
            dndIcon = null;
        }
    }

    // Draw the watch hand
    // @param dc Device Context to Draw
    // @param angle Angle to draw the watch hand
    // @param length Length of the watch hand
    // @param width Width of the watch hand
    function drawHand(dc, angle, length, width) {
        // Map out the coordinates of the watch hand
        var coords = [[-(width / 2),0], [-(width / 2), -length], [width / 2, -length], [width / 2, 0]];
        var result = new [4];
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;
        var cos = Math.cos(angle);
        var sin = Math.sin(angle);

        // Transform the coordinates
        for (var i = 0; i < 4; i += 1) {
            var x = (coords[i][0] * cos) - (coords[i][1] * sin);
            var y = (coords[i][0] * sin) + (coords[i][1] * cos);
            result[i] = [centerX + x, centerY + y];
        }

        // Draw the polygon
        dc.fillPolygon(result);
        dc.fillPolygon(result);
    }

    // Draw the hash mark symbols on the watch
    // @param dc Device context
    function drawHashMarks(dc) {
        var width = dc.getWidth();
        var height = dc.getHeight();

        // Draw hashmarks differently depending on screen geometry
        if (Sys.SCREEN_SHAPE_ROUND == screenShape) {
            var sX, sY;
            var eX, eY;
            var outerRad = width / 2;
            var innerRad = outerRad - 10;
            // Loop through each 15 minute block and draw tick marks
            for (var i = Math.PI / 6; i <= 11 * Math.PI / 6; i += (Math.PI / 3)) {
                // Partially unrolled loop to draw two tickmarks in 15 minute block
                sY = outerRad + innerRad * Math.sin(i);
                eY = outerRad + outerRad * Math.sin(i);
                sX = outerRad + innerRad * Math.cos(i);
                eX = outerRad + outerRad * Math.cos(i);
                dc.drawLine(sX, sY, eX, eY);
                i += Math.PI / 6;
                sY = outerRad + innerRad * Math.sin(i);
                eY = outerRad + outerRad * Math.sin(i);
                sX = outerRad + innerRad * Math.cos(i);
                eX = outerRad + outerRad * Math.cos(i);
                dc.drawLine(sX, sY, eX, eY);
            }
        } else {
            var coords = [0, width / 4, (3 * width) / 4, width];
            for (var i = 0; i < coords.size(); i += 1) {
                var dx = ((width / 2.0) - coords[i]) / (height / 2.0);
                var upperX = coords[i] + (dx * 10);
                // Draw the upper hash marks
                dc.fillPolygon([[coords[i] - 1, 2], [upperX - 1, 12], [upperX + 1, 12], [coords[i] + 1, 2]]);
                // Draw the lower hash marks
                dc.fillPolygon([[coords[i] - 1, height-2], [upperX - 1, height - 12], [upperX + 1, height - 12], [coords[i] + 1, height - 2]]);
            }
        }
    }

    // Handle the update event
    function onUpdate(dc) {
        var width;
        var height;
        var screenWidth = dc.getWidth();
        var clockTime = Sys.getClockTime();
        var hourHand;
        var minuteHand;
        var secondHand;
        var secondTail;

        width = dc.getWidth();
        height = dc.getHeight();

        var now = Time.now();
        var info = Calendar.info(now, Time.FORMAT_LONG);

        var dateStr = Lang.format("$1$ $2$ $3$", [info.day_of_week, info.month, info.day]);

        // Clear the screen
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        // Draw the gray rectangle
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_DK_GRAY);
        dc.fillPolygon([[0, 0], [dc.getWidth(), 0], [dc.getWidth(), dc.getHeight()], [0, 0]]);

        // Draw the numbers
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText((width / 2), 2, font, "12", Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(width - 2, (height / 2) - 15, font, "3", Gfx.TEXT_JUSTIFY_RIGHT);
        dc.drawText(width / 2, height - 30, font, "6", Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(2, (height / 2) - 15, font, "9", Gfx.TEXT_JUSTIFY_LEFT);

        // Draw the date
        dc.drawText(width / 2, (height / 4), Gfx.FONT_MEDIUM, dateStr, Gfx.TEXT_JUSTIFY_CENTER);

        // Draw the hash marks
        drawHashMarks(dc);

        // Draw the do-not-disturb icon
        if (null != dndIcon && Sys.getDeviceSettings().doNotDisturb) {
            dc.drawBitmap( width * 0.75, height / 2 - 15, dndIcon);
        }

        // Draw the hour. Convert it to minutes and compute the angle.
        hourHand = (((clockTime.hour % 12) * 60) + clockTime.min);
        hourHand = hourHand / (12 * 60.0);
        hourHand = hourHand * Math.PI * 2;
        drawHand(dc, hourHand, 40, 3);

        // Draw the minute
        minuteHand = (clockTime.min / 60.0) * Math.PI * 2;
        drawHand(dc, minuteHand, 70, 2);

        // Draw the second
        if (isAwake) {
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
            secondHand = (clockTime.sec / 60.0) * Math.PI * 2;
            secondTail = secondHand - Math.PI;
            drawHand(dc, secondHand, 60, 2);
            drawHand(dc, secondTail, 20, 2);
        }

        // Draw the arbor
        dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_BLACK);
        dc.fillCircle(width / 2, height / 2, 7);
        dc.setColor(Gfx.COLOR_BLACK,Gfx.COLOR_BLACK);
        dc.drawCircle(width / 2, height / 2, 7);
    }

    function onEnterSleep() {
        isAwake = false;
        Ui.requestUpdate();
    }

    function onExitSleep() {
        isAwake = true;
    }
}
