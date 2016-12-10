//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

var globalText = "Push Up\nor Tap\nTo Start";

class KeyboardView extends Ui.View {

    // Load your resources here
    function onLayout(dc) {
    }

    // Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        if (Ui has :TextPicker) {
            dc.drawText( dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_SMALL, globalText, Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER );
        } else {
            dc.drawText( dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_SMALL, "TextPicker not supported", Gfx.TEXT_JUSTIFY_CENTER );
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of your app here.
    function onHide() {
    }

}