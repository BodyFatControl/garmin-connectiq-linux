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

class PrimatesView extends Ui.View {

    hidden var color;
    hidden var index;
    hidden var images;
    hidden var indicator;
    hidden var bitmap;

    var primates = [ "Apes", "Monkeys", "Prosimians" ];

    function initialize() {
        View.initialize();
        index = 0;
        color = Gfx.COLOR_BLACK;
        images = [ Rez.Drawables.id_apes,
                   Rez.Drawables.id_monkeys,
                   Rez.Drawables.id_prosimians ];

        bitmap = Ui.loadResource(images[index]);

        indicator = new PageIndicator();
        var size = 3;
        var selected = Gfx.COLOR_DK_GRAY;
        var notSelected = Gfx.COLOR_LT_GRAY;
        var alignment = indicator.ALIGN_BOTTOM_RIGHT;
        indicator.setup(size, selected, notSelected, alignment, 3);
    }

    function setIndex(newIndex) {
        index = newIndex;
        bitmap = null;
        bitmap = Ui.loadResource(images[index]);
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        dc.setColor(color, Gfx.COLOR_TRANSPARENT);
        dc.drawText( (dc.getWidth() / 2), 5, Gfx.FONT_SMALL, primates[index], Gfx.TEXT_JUSTIFY_CENTER);

        var bx = (dc.getWidth() / 2) - (bitmap.getWidth() / 2);
        var by = (dc.getHeight() / 2) - (bitmap.getHeight() / 2);

        dc.drawBitmap(bx, by, bitmap);

        indicator.draw(dc, index);
    }

}
