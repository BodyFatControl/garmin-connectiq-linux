//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Application as App;
using Toybox.System as Sys;

var screenShape;

// This is the primary start point for a ConnectIQ application
class ActivityTrackerApp extends App.AppBase {
    function onStart(state) {
        screenShape = Sys.getDeviceSettings().screenShape;
        return false;
    }

    function getInitialView() {
        return [new ActivityTrackerView(), new ActivityTrackerDelegate()];
    }

    function onStop(state) {
        return false;
    }
}
