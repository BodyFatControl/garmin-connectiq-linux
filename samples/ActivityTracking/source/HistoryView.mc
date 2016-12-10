//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.ActivityMonitor as Act;

class HistoryView extends Ui.View {

    // Constructor
    function initialize() {
    }

    // Handle the update event
    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        var actHistArray = Act.getHistory();
        var padding = 5;
        var smallFontHeight = Gfx.getFontHeight(Gfx.FONT_SMALL);
        var smallFont = Gfx.FONT_SMALL;
        var string = "";

        dc.drawText(dc.getWidth() / 2, padding, Gfx.FONT_MEDIUM, "Act History", Gfx.TEXT_JUSTIFY_CENTER);
        if (null != actHistArray && actHistArray.size() > 0) {
            // Draw headers
            dc.drawText(padding, padding + smallFontHeight, smallFont, "Day", Gfx.TEXT_JUSTIFY_LEFT);
            dc.drawText(dc.getWidth() / 2, padding + smallFontHeight, smallFont, "Steps / Goal", Gfx.TEXT_JUSTIFY_CENTER);
            dc.drawText(dc.getWidth(), padding + smallFontHeight, smallFont, "Floors", Gfx.TEXT_JUSTIFY_RIGHT);

            // Loop through array of history items
            for (var i = 0; i < actHistArray.size(); i += 1) {
                dc.drawText(padding, padding + smallFontHeight * (i+2), smallFont, (i+1).toString(), Gfx.TEXT_JUSTIFY_LEFT);
                // Validate that each element is non-null
                if (null != actHistArray[i] && null != actHistArray[i].steps) {
                    string = actHistArray[i].steps.toString() + " / " + actHistArray[i].stepGoal.toString();
                    dc.drawText(dc.getWidth() / 2, padding + smallFontHeight * (i+2), smallFont, string, Gfx.TEXT_JUSTIFY_CENTER);
                    // Check if the device supports floors climbed info and validate that element is non-null
                    if (actHistArray[i] has :floorsClimbed && null != actHistArray[i].floorsClimbed) {
                        dc.drawText(dc.getWidth(), padding + smallFontHeight * (i+2), smallFont, actHistArray[i].floorsClimbed.toString(), Gfx.TEXT_JUSTIFY_RIGHT);
                    }
                }
            }
        }
    }
}