//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class CommandView extends Ui.View {
    hidden var mIcon;
    hidden var mIndex;
    hidden var mIndicator;
    hidden var mSensor;

    function initialize(sensor, index) {
        mIndex = index;

        mIndicator = new PageIndicator();
        var size = 4;
        var selected = Gfx.COLOR_DK_GRAY;
        var notSelected = Gfx.COLOR_LT_GRAY;
        var alignment = mIndicator.ALIGN_BOTTOM_RIGHT;
        mIndicator.setup(size, selected, notSelected, alignment, 0);

        mSensor = sensor;
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();
        var margin = 30;
        var font;
        var text;
        var fWidth;

        text = "Notifications";
        font = Gfx.FONT_LARGE;
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(width/2 - fWidth/2, margin, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        text = "UTC Time";
        font = Gfx.FONT_MEDIUM;
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(width/2 - fWidth/2, height/3 + margin, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        if (mSensor.data.utcTimeSet) {
            text = "Required";
            fWidth = dc.getTextWidthInPixels(text, font);
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
            dc.drawText(width/2 - fWidth/2, height*2/3, font, text, Gfx.TEXT_JUSTIFY_LEFT);

            text = "Tap to set";
            font = Gfx.FONT_SMALL;
            fWidth = dc.getTextWidthInPixels(text, font);
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(width/2 - fWidth/2, height*2/3 + margin, font, text, Gfx.TEXT_JUSTIFY_LEFT);
        } else {
            text = "Not Required";
            fWidth = dc.getTextWidthInPixels(text, font);
            dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
            dc.drawText(width/2 - fWidth/2, height*2/3, font, text, Gfx.TEXT_JUSTIFY_LEFT);
        }

        // Draw page indicator
        mIndicator.draw(dc, mIndex);
    }

}