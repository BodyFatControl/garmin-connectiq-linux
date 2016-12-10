//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Application as App;

class AttentionApp extends App.AppBase {
    var mainView;
    var mainDelegate;

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        mainView = new AttentionView();
        mainDelegate = new AttentionDelegate();
        return [mainView, mainDelegate];
    }

}
