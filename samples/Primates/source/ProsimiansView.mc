//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;

class ProsimiansView extends Ui.View {

    hidden var color;

    function initialize() {
        View.initialize();
        color = Gfx.COLOR_WHITE;
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();

        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.drawText(20, 20, Gfx.FONT_LARGE, "Prosimians", Gfx.TEXT_JUSTIFY_LEFT);

        dc.drawText(20, 50, Gfx.FONT_MEDIUM, "Prosimian means", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 70, Gfx.FONT_MEDIUM, "'before monkeys'", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 90, Gfx.FONT_MEDIUM, "and they are the", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(20, 110, Gfx.FONT_MEDIUM, "most primitive.", Gfx.TEXT_JUSTIFY_LEFT);
    }

}
