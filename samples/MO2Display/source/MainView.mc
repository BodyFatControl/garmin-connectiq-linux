//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class MainView extends Ui.View {
    hidden var mIcon;
    hidden var mIndex;
    hidden var mIndicator;
    hidden var mSensor;

    function initialize(sensor, index) {
        mIndex = index;

        mIcon = Ui.loadResource(Rez.Drawables.id_mo2Icon);

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
        var margin = 20;
        var font = Gfx.FONT_SMALL;

        // Show icon
        dc.drawBitmap(width/5, 0, mIcon);

        // Update status
        if(true == mSensor.searching) {
            var status = "searching...";
            var fWidth = dc.getTextWidthInPixels(status, font);
            dc.setColor( Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT );
            dc.drawText(width/2 - fWidth/2, height-margin, font, status, Gfx.TEXT_JUSTIFY_LEFT);
        } else {
            var deviceNumber = mSensor.deviceCfg.deviceNumber;
            var status = "tracking - " + deviceNumber.toString();
            var fWidth = dc.getTextWidthInPixels(status, font);
            dc.setColor( Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT );
            dc.drawText(width/2 - fWidth/2, height-margin, Gfx.FONT_SMALL, status, Gfx.TEXT_JUSTIFY_LEFT);
        }

        // Draw page indicator
        mIndicator.draw(dc, mIndex);
    }

}