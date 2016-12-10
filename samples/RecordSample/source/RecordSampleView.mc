//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.ActivityRecording as Record;

var session = null;

class BaseInputDelegate extends Ui.BehaviorDelegate
{

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        if( Toybox has :ActivityRecording ) {
            if( ( session == null ) || ( session.isRecording() == false ) ) {
                session = Record.createSession({:name=>"Walk", :sport=>Record.SPORT_WALKING});
                session.start();
                Ui.requestUpdate();
            }
            else if( ( session != null ) && session.isRecording() ) {
                session.stop();
                session.save();
                session = null;
                Ui.requestUpdate();
            }
        }
        return true;
    }
}

class RecordSampleView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    //! Stop the recording if necessary
    function stopRecording() {
        if( Toybox has :ActivityRecording ) {
            if( session != null && session.isRecording() ) {
                session.stop();
                session.save();
                session = null;
                Ui.requestUpdate();
            }
        }
    }

    //! Load your resources here
    function onLayout(dc) {
    }


    function onHide() {
    }

    //! Restore the state of the app and prepare the view to be shown.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        // Set background color
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_WHITE);
        dc.clear();
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        dc.drawText(dc.getWidth()/2, 0, Gfx.FONT_XTINY, "M:"+Sys.getSystemStats().usedMemory, Gfx.TEXT_JUSTIFY_CENTER);

        if( Toybox has :ActivityRecording ) {
            // Draw the instructions
            if( ( session == null ) || ( session.isRecording() == false ) ) {
                dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
                dc.drawText(dc.getWidth() / 2, dc.getHeight() / 2, Gfx.FONT_MEDIUM, "Press Menu to\nStart Recording", Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
            }
            else if( ( session != null ) && session.isRecording() ) {
                var x = dc.getWidth() / 2;
                var y = dc.getFontHeight(Gfx.FONT_XTINY);
                dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_WHITE);
                dc.drawText(x, y, Gfx.FONT_MEDIUM, "Recording...", Gfx.TEXT_JUSTIFY_CENTER);
                y += dc.getFontHeight(Gfx.FONT_MEDIUM);
                dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_WHITE);
                dc.drawText(x, y, Gfx.FONT_MEDIUM, "Press Menu again\nto Stop and Save\nthe Recording", Gfx.TEXT_JUSTIFY_CENTER);
            }
        }
        // tell the user this sample doesn't work
        else {
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_WHITE);
            dc.drawText(dc.getWidth() / 2, dc.getWidth() / 2, Gfx.FONT_MEDIUM, "This product doesn't\nhave FIT Support", Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER);
        }
    }

}
