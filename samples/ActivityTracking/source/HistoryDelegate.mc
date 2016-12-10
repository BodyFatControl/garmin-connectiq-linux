//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;

class HistoryDelegate extends Ui.BehaviorDelegate {
    // Constructor
    function initialize() {
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_UP);
        return true;
    }
}