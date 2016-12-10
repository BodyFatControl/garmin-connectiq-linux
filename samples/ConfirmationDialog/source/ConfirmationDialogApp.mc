//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Application as App;
using Toybox.WatchUi as Ui;

var instructionString;
var resultString;
var dialogHeaderString;
var confirmString;
var cancelString;

class ConfirmationDialogApp extends App.AppBase {

    // onStart() is called on application start up
    function onStart(state) {
        instructionString = Ui.loadResource(Rez.Strings.TestInfo);
        resultString = Ui.loadResource(Rez.Strings.DefaultResponse);
        dialogHeaderString = Ui.loadResource(Rez.Strings.DialogHeader);
        confirmString = Ui.loadResource(Rez.Strings.Confirm);
        cancelString = Ui.loadResource(Rez.Strings.Cancel);
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [new ConfirmationDialogView(), new BaseInputDelegate()];
    }

}