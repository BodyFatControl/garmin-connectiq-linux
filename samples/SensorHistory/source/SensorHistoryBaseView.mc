//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.SensorHistory as SH;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class SensorHistoryBaseView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();

        dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Gfx.FONT_MEDIUM, "Press Select", Gfx.TEXT_JUSTIFY_CENTER);
    }
}


