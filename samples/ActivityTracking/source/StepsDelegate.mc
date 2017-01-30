//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;

class StepsDelegate extends Ui.BehaviorDelegate {
    // Constructor
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_UP);
        return true;
    }

    function onSelect() {
        Ui.pushView(new HistoryView(), new HistoryDelegate(), Ui.SLIDE_DOWN);
    }
}