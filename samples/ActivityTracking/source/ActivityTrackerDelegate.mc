//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;

class ActivityTrackerDelegate extends Ui.BehaviorDelegate {

    // Constructor
    function initialize() {
    }

    function onSelect() {
        Ui.pushView(new StepsView(), new StepsDelegate(), Ui.SLIDE_DOWN);
    }
}