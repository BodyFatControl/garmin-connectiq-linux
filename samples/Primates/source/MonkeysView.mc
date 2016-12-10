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

class MonkeysView extends Ui.View {

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
        dc.drawText(10, 20, Gfx.FONT_LARGE, "Monkeys", Gfx.TEXT_JUSTIFY_LEFT);

        dc.drawText(10, 50, Gfx.FONT_MEDIUM, "Monkeys are divided", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(10, 70, Gfx.FONT_MEDIUM, "into two types: Old", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(10, 90, Gfx.FONT_MEDIUM, "World and New World.", Gfx.TEXT_JUSTIFY_LEFT);
    }

}
