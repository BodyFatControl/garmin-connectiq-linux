//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

class SensorHistoryDelegate extends Ui.BehaviorDelegate {

    var mView;

    function initialize( view ) {
        BehaviorDelegate.initialize();
        mView = view;
    }

    function onNextPage() {
        mView.nextSensor();
        Ui.requestUpdate();
        return true;
    }

    function onPreviousPage() {
        mView.previousSensor();
        Ui.requestUpdate();
        return true;
    }
}