//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Application as App;

class AttentionDelegate extends Ui.InputDelegate {

    // Handle key  events
    function onKey(evt) {
        var app = App.getApp();
        var key = evt.getKey();
        if (Ui.KEY_DOWN == key) {
            app.mainView.incIndex();
        } else if (Ui.KEY_UP == key) {
            app.mainView.decIndex();
        } else if (Ui.KEY_ENTER == key) {
            app.mainView.action();
        } else if (Ui.KEY_START == key) {
            app.mainView.action();
        } else {
            return false;
        }
        Ui.requestUpdate();
        return true;
    }

    // Handle touchscreen taps
    function onTap(evt) {
        var app = App.getApp();
        if (Ui.CLICK_TYPE_TAP == evt.getType()) {
            var coords = evt.getCoordinates();
            app.mainView.setIndexFromYVal(coords[1]);
            Ui.requestUpdate();
            app.mainView.action();
        }
        return true;
    }

    // Handle enter events
    function onSelect() {
        App.getApp().mainView.action();
    }

    // Handle swipe events
    function onSwipe(evt) {
        var direction = evt.getDirection();
        if (Ui.SWIPE_DOWN == direction) {
            app.mainView.incIndex();
        } else if (Ui.SWIPE_UP == direction) {
            app.mainView.decIndex();
        } else if (Ui.SWIPE_LEFT == direction) {
            app.mainView.decIndex();
        } else if (Ui.SWIPE_RIGHT == direction) {
            app.mainView.incIndex();
        }
        Ui.requestUpdate();
    }

}
