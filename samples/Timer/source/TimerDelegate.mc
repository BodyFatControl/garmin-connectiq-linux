//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;

class InputDelegate extends Ui.BehaviorDelegate {
    function onMenu() {
        timer1.stop();
        return true;
    }
}