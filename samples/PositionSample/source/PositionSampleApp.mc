//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.Application as App;
using Toybox.Position as Position;

class PositionSampleApp extends App.AppBase {

    var positionView;

    //! onStart() is called on application start up
    function onStart(state) {
        Position.enableLocationEvents(Position.LOCATION_CONTINUOUS, method(:onPosition));
    }

    //! onStop() is called when your application is exiting
    function onStop(state) {
        Position.enableLocationEvents(Position.LOCATION_DISABLE, method(:onPosition));
    }

    function onPosition(info) {
        positionView.setPosition(info);
    }

    //! Return the initial view of your application here
    function getInitialView() {
        positionView = new PositionSampleView();
        return [ positionView ];
    }

}
