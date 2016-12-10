//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class DataView extends Ui.View {

    hidden var mIndex;
    hidden var mIndicator;
    hidden var mSensor;
    hidden var mHeadingFont;
    hidden var mDataFont;
    hidden var mUnitFont;

    function initialize(sensor, index) {
        mIndex = index;

        mHeadingFont = Gfx.FONT_SMALL;
        mDataFont = Gfx.FONT_LARGE;
        mUnitFont = Gfx.FONT_TINY;

        mIndicator = new PageIndicator();
        var size = 4;
        var selected = Gfx.COLOR_DK_GRAY;
        var notSelected = Gfx.COLOR_LT_GRAY;
        var alignment = mIndicator.ALIGN_BOTTOM_RIGHT;
        mIndicator.setup(size, selected, notSelected, alignment, 0);

        mSensor = sensor;
    }

    function onUpdate(dc) {
        dc.setColor( Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();
        var marginTop = 5;
        var marginMid = height/2 - 5;
        var marginLeft = 3;
        var fWidth;
        var text;
        var font;

        // Update total
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        font = mHeadingFont;
        text = "Total";
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.drawText(width/4 - fWidth/2, marginTop, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        font = mDataFont;
        text = mSensor.data.totalHemoConcentration.format("%.2f");
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.drawText(width/4 - fWidth/2, marginTop + height/6, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
        font = mUnitFont;
        text = "g/dl";
        dc.drawText(width/4 + fWidth/2 + marginLeft, marginTop + height/6, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        //Update events
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        text = "Events";
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.drawText((width * 3 / 4) - fWidth/2, marginTop, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        font = mDataFont;
        text = mSensor.data.eventCount.format("%i");
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.drawText((width * 3 / 4) - fWidth/2, marginTop + height/6, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        //Update current
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        font = mHeadingFont;
        text = "Current";
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.drawText(width/4 - fWidth/2, marginMid, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        font = mDataFont;
        text = mSensor.data.currentHemoPercent.format("%.1f");
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.drawText(width/4 - fWidth/2, marginMid + height/6, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
        font = mUnitFont;
        text = "%";
        dc.drawText(width/4 + fWidth/2 + marginLeft, marginMid + height/6, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        //Update Previous
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        font = mHeadingFont;
        text = "Previous";
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.drawText((width * 3 / 4) - fWidth/2, marginMid, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
        font = mDataFont;
        text = mSensor.data.previousHemoPercent.format("%.1f");
        fWidth = dc.getTextWidthInPixels(text, font);
        dc.drawText((width * 3 / 4) - fWidth/2, marginMid + height/6, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
        font = mUnitFont;
        text = "%";
        dc.drawText((width * 3 / 4) + fWidth/2 + marginLeft, marginMid + height/6, font, text, Gfx.TEXT_JUSTIFY_LEFT);

        // Draw the page indicator
        mIndicator.draw(dc, mIndex);
    }

}