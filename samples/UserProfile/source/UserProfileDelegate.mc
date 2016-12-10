//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

var page = 1;

class BaseInputDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {

        if (page == 3) {
            page = 1;
        } else {
            page = page + 1;
        }

        switchView(page);
        Ui.requestUpdate();
        return true;
    }

    function switchView(pageNum) {

        var newView = null;
        var inputDelegate = new BaseInputDelegate();

        if(page == 1) {
            newView = new UserProfileSectionOneView();
        }
        else if(page == 2) {
            newView = new UserProfileSectionTwoView();
        }
        else if(page == 3) {
            newView = new UserProfileSectionThreeView();
        }

        switchToView(newView, inputDelegate, Ui.SLIDE_IMMEDIATE);
    }
}