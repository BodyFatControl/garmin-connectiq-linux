//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class ObjectStore extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new ObjectStoreView(), new ObjectStoreViewDelegate() ];
    }

    // For this app all that needs to be done is trigger a Ui refresh
    // since the settings are only used in onUpdate().
    function onSettingsChanged() {
        Ui.requestUpdate();
    }
}
