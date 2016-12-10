//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Attention as Attention;
using Toybox.System as Sys;

var selectedIndex;
var currentTone = null;
var currentVibe = null;

class AttentionView extends Ui.View {

    var backlightOn = false;
    var toneIdx = 0;
    var toneNames = [ "Key",
                      "Start",
                      "Stop",
                      "Message",
                      "Alert Hi",
                      "Alert Lo",
                      "Loud Beep",
                      "Interval Alert",
                      "Alarm",
                      "Reset",
                      "Lap",
                      "Canary",
                      "Time Alert",
                      "Distance Alert",
                      "Failure",
                      "Success",
                      "Power",
                      "Low Battery",
                      "Error" ];

    // Load your resources here
    function onLayout(dc) {
        selectedIndex = 0;
    }

    // Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        var medFontHeight = Gfx.getFontHeight(Gfx.FONT_MEDIUM);

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();

        // Draw selected box
        dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
        dc.fillRectangle(0, selectedIndex * dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3);
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);

        // Draw frames
        dc.drawLine(0, dc.getHeight() / 3, dc.getWidth(), dc.getHeight() / 3);
        dc.drawLine(0, 2 * dc.getHeight() / 3, dc.getWidth(), 2 * dc.getHeight() / 3);

        // Draw text
        dc.drawText(dc.getWidth() / 2, (dc.getHeight() / 6) - (medFontHeight / 2), Gfx.FONT_MEDIUM, "Toggle backlight", Gfx.TEXT_JUSTIFY_CENTER);

        if (currentVibe != null) {
            dc.drawText(dc.getWidth() / 2, 5 * dc.getHeight() / 6 - (medFontHeight / 2), Gfx.FONT_MEDIUM, "Vibe: " + currentVibe, Gfx.TEXT_JUSTIFY_CENTER);
        } else {
            dc.drawText(dc.getWidth() / 2, 5 * dc.getHeight() / 6 - (medFontHeight / 2), Gfx.FONT_MEDIUM, "Vibrate", Gfx.TEXT_JUSTIFY_CENTER);
        }

        if (currentTone != null) {
            dc.drawText(dc.getWidth() / 2, (dc.getHeight() - medFontHeight) / 2, Gfx.FONT_MEDIUM, "Tone: " + currentTone, Gfx.TEXT_JUSTIFY_CENTER);
        } else {
            dc.drawText(dc.getWidth() / 2, (dc.getHeight() - medFontHeight) / 2, Gfx.FONT_MEDIUM, "Play a tone", Gfx.TEXT_JUSTIFY_CENTER);
        }

    }

    // Called when this View is removed from the screen. Save the
    // state of your app here.
    function onHide() {
    }

    // Take a tap coordinate and correspond it to one of three sections
    function setIndexFromYVal(yval) {
        var screenHeight = Sys.getDeviceSettings().screenHeight;
        selectedIndex = (yval / (screenHeight / 3)).toNumber();
    }

    // Decrement the currently selected option index
    function incIndex() {
        if (null != selectedIndex) {
            selectedIndex += 1;
            if (2 < selectedIndex) {
                selectedIndex = 0;
            }
        }
    }

    // Decrement the currently selected option index
    function decIndex() {
        if (null != selectedIndex) {
            selectedIndex -= 1;
            if (0 > selectedIndex) {
                selectedIndex = 2;
            }
        }
    }

    // Process the current attention action
    function action() {
        if (0 == selectedIndex) {
            // Toggle backlight
            currentTone = null;
            backlightOn = !backlightOn;
            Attention.backlight(backlightOn);
            Ui.requestUpdate();
        } else if (1 == selectedIndex) {
            // Play a tone -- Note, sounds are not supported on the vivoactive
            if (Attention has :playTone) {
                currentTone = toneNames[toneIdx];
                Attention.playTone(toneIdx);
                ++toneIdx;

                if(toneIdx == toneNames.size()) {
                    toneIdx = 0;
                }
            } else {
                currentTone = "Not supported";
            }
            Ui.requestUpdate();
        } else if (2 == selectedIndex) {
            // Vibrate
            currentTone = null;
            if (Attention has :vibrate) {
                var vibrateData = [
                        new Attention.VibeProfile(  25, 100 ),
                        new Attention.VibeProfile(  50, 100 ),
                        new Attention.VibeProfile(  75, 100 ),
                        new Attention.VibeProfile( 100, 100 ),
                        new Attention.VibeProfile(  75, 100 ),
                        new Attention.VibeProfile(  50, 100 ),
                        new Attention.VibeProfile(  25, 100 )
                      ];

                Attention.vibrate(vibrateData);
            } else {
                currentVibe = "Not supported";
            }
            Ui.requestUpdate();
        }
    }

}
