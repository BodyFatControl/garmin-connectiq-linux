//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

var action_string;
var status_string;
var behavior_string;
var action_hits;
var behavior_hits;

function setStatusString(new_string) {
    status_string = new_string;
    Ui.requestUpdate();
}

function setActionString(new_string) {
    action_string = new_string;
    action_hits++;

    if (action_hits > behavior_hits) {
        behavior_string = "NO_BEHAVIOR";
        behavior_hits = action_hits;
    }

    Ui.requestUpdate();
}

function setBehaviorString(new_string) {
    behavior_string = new_string;
    behavior_hits++;
    Ui.requestUpdate();
}

class InputView extends Ui.View {
    function initialize() {
        action_string = "NO_ACTION";
        behavior_string = "NO_BEHAVIOR";
        status_string = "NO_EVENT";
        action_hits = 0;
        behavior_hits = 0;
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
        dc.clear();

        var x = dc.getWidth() / 2;
        var y = (dc.getHeight() / 2) - (3 * dc.getFontHeight(Gfx.FONT_SMALL) / 2);

        dc.drawText(x, y, Gfx.FONT_SMALL, action_string, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(x, y + dc.getFontHeight(Gfx.FONT_SMALL), Gfx.FONT_SMALL, behavior_string, Gfx.TEXT_JUSTIFY_CENTER);
        dc.drawText(x, y + 2 * dc.getFontHeight(Gfx.FONT_SMALL), Gfx.FONT_SMALL, status_string, Gfx.TEXT_JUSTIFY_CENTER);
    }
}
