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

        var x = dc.getWidth() / 2;
        var y = 20;

        dc.drawText(x, y, Gfx.FONT_MEDIUM, "Monkeys", Gfx.TEXT_JUSTIFY_CENTER);
        y += dc.getFontHeight(Gfx.FONT_MEDIUM);
        dc.drawText(x, y, Gfx.FONT_SMALL, "Monkeys are", Gfx.TEXT_JUSTIFY_CENTER);
        y += dc.getFontHeight(Gfx.FONT_SMALL);
        dc.drawText(x, y, Gfx.FONT_SMALL, "divided into two", Gfx.TEXT_JUSTIFY_CENTER);
        y += dc.getFontHeight(Gfx.FONT_SMALL);
        dc.drawText(x, y, Gfx.FONT_SMALL, "types: Old World", Gfx.TEXT_JUSTIFY_CENTER);
        y += dc.getFontHeight(Gfx.FONT_SMALL);
        dc.drawText(x, y, Gfx.FONT_SMALL, "and New World.", Gfx.TEXT_JUSTIFY_CENTER);
    }

}
