//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;

class PositionSampleView extends Ui.View {

    var posnInfo = null;

    //! Load your resources here
    function onLayout(dc) {
    }

    function onHide() {
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        var string;

        // Set background color
        dc.setColor( Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        if( posnInfo != null ) {
            string = "Location lat = " + posnInfo.position.toDegrees()[0].toString();
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 40), Gfx.FONT_SMALL, string, Gfx.TEXT_JUSTIFY_CENTER );
            string = "Location long = " + posnInfo.position.toDegrees()[1].toString();
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) - 20), Gfx.FONT_SMALL, string, Gfx.TEXT_JUSTIFY_CENTER );
            string = "speed = " + posnInfo.speed.toString();
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) ), Gfx.FONT_SMALL, string, Gfx.TEXT_JUSTIFY_CENTER );
            string = "alt = " + posnInfo.altitude.toString();
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) + 20), Gfx.FONT_SMALL, string, Gfx.TEXT_JUSTIFY_CENTER );
            string = "heading = " + posnInfo.heading.toString();
            dc.drawText( (dc.getWidth() / 2), ((dc.getHeight() / 2) + 40), Gfx.FONT_SMALL, string, Gfx.TEXT_JUSTIFY_CENTER );
        }
        else {
            dc.drawText( (dc.getWidth() / 2), (dc.getHeight() / 2), Gfx.FONT_SMALL, "No position info", Gfx.TEXT_JUSTIFY_CENTER );
        }
    }

    function setPosition(info) {
        posnInfo = info;
        Ui.requestUpdate();
    }


}
