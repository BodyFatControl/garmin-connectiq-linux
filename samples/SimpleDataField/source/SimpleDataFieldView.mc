//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Time as Time;

class DataField extends Ui.SimpleDataField {
    const METERS_TO_MILES = 0.000621371;
    const MILLISECONDS_TO_SECONDS = 0.001;

    var counter;

    // Constructor
    function initialize() {
        label = "HR, Dist, Time";
        counter = 0;
    }

    // Handle the update event
    function compute(info) {
        var value_picked = null;

        //Cycle between Heart Rate (int), Distance (float), and elapsedTime (Duration)
        if(counter == 0) {
            if(info.currentHeartRate != null) {
                value_picked = info.currentHeartRate;
            }
        }
        if(counter == 1) {
            if(info.elapsedDistance != null) {
                value_picked = info.elapsedDistance * METERS_TO_MILES;
            }
        }
        if(counter == 2) {
            if(info.elapsedTime != null) {
                //elapsedTime is in ms.
                var options = { :seconds => info.elapsedTime *  MILLISECONDS_TO_SECONDS};
                value_picked = Time.Gregorian.duration(options);
            }
        }

        counter += 1;
        if(counter > 2) {
            counter = 0;
        }

        return value_picked;
    }
}