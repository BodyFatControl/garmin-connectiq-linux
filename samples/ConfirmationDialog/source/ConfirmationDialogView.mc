//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class ConfirmationDialogView extends Ui.View {

    // Load your resources here
    function onLayout(dc) {
        onUpdate(dc);
    }


    // Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText((dc.getWidth() / 2), (dc.getHeight() / 2) - 2 * Gfx.getFontHeight(Gfx.FONT_SMALL), Gfx.FONT_SMALL, instructionString, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText((dc.getWidth() / 2), (dc.getHeight() / 2) + Gfx.getFontHeight(Gfx.FONT_SMALL), Gfx.FONT_SMALL, resultString, Gfx.TEXT_JUSTIFY_CENTER);
    }


}