//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

var last_key = null;

class InputDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onNextPage() {
        setBehaviorString("NEXT_PAGE");
        return false;
    }

    function onPreviousPage() {
        setBehaviorString("PREVIOUS_PAGE");
        return false;
    }

    function onMenu() {
        setBehaviorString("ON_MENU");
        return false;
    }

    function onBack() {
        setBehaviorString("ON_BACK");
        return false;
    }

    function onNextMode() {
        setBehaviorString("ON_NEXT_MODE");
        return false;
    }

    function onPreviousMode() {
        setBehaviorString("ON_PREVIOUS_MODE");
        return false;
    }

    function onSelect() {
        setBehaviorString("ON_SELECT");
        return false;
    }

    function onTap(evt) {
        setActionString("CLICK_TYPE_TAP");
        return true;
    }

    function onHold(evt) {
        setActionString("CLICK_TYPE_HOLD");
        return true;
    }

    function onRelease(evt) {
        setActionString("CLICK_TYPE_RELEASE");
        return true;
    }

    function onSwipe(evt) {
        var swipe = evt.getDirection();

        if (swipe == SWIPE_UP) {
            setActionString("SWIPE_UP");
        } else if (swipe == SWIPE_RIGHT) {
            setActionString("SWIPE_RIGHT");
        } else if (swipe == SWIPE_DOWN) {
            setActionString("SWIPE_DOWN");
        } else if (swipe == SWIPE_LEFT) {
            setActionString("SWIPE_LEFT");
        }

        return true;
    }

    function onKey(evt) {
        var key = evt.getKey();
        var keyString = getKeyString( key );

        if( keyString != null ) {
            setActionString( keyString );
        }

        if (key == KEY_ESC) {
            if (last_key == KEY_ESC) {
                Sys.exit();
            }
        }

        last_key = key;

        return true;
    }

    function onKeyPressed(evt) {
        var keyString = getKeyString( evt.getKey() );
        if( keyString != null ) {
            setStatusString( keyString + " PRESSED" );
        }

        return true;
    }

    function onKeyReleased(evt) {
        var keyString = getKeyString( evt.getKey() );
        if( keyString != null ) {
            setStatusString( keyString + " RELEASED" );
        }

        return true;
    }

    function getKeyString(key) {
        if (key == KEY_POWER) {
            return "KEY_POWER";
        } else if (key == KEY_LIGHT) {
            return "KEY_LIGHT";
        } else if (key == KEY_ZIN) {
            return "KEY_ZIN";
        } else if (key == KEY_ZOUT) {
            return "KEY_ZOUT";
        } else if (key == KEY_ENTER) {
            return "KEY_ENTER";
        } else if (key == KEY_ESC) {
            return "KEY_ESC";
        } else if (key == KEY_FIND) {
            return "KEY_FIND";
        } else if (key == KEY_MENU) {
            return "KEY_MENU";
        } else if (key == KEY_DOWN) {
            return "KEY_DOWN";
        } else if (key == KEY_DOWN_LEFT) {
            return "KEY_DOWN_LEFT";
        } else if (key == KEY_DOWN_RIGHT) {
            return "KEY_DOWN_RIGHT";
        } else if (key == KEY_LEFT) {
            return "KEY_LEFT";
        } else if (key == KEY_RIGHT) {
            return "KEY_RIGHT";
        } else if (key == KEY_UP) {
            return "KEY_UP";
        } else if (key == KEY_UP_LEFT) {
            return "KEY_UP_LEFT";
        } else if (key == KEY_UP_RIGHT) {
            return "KEY_UP_RIGHT";
        } else if (key == KEY_PAGE) {
            return "KEY_PAGE";
        } else if (key == KEY_START) {
            return "KEY_START";
        } else if (key == KEY_LAP) {
            return "KEY_LAP";
        } else if (key == KEY_RESET) {
            return "KEY_RESET";
        } else if (key == KEY_SPORT) {
            return "KEY_SPORT";
        } else if (key == KEY_CLOCK) {
            return "KEY_CLOCK";
        } else if (key == KEY_MODE) {
            return "KEY_MODE";
        }

        return null;
    }
}
