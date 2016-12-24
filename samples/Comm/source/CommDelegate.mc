//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Communications as Comm;

class CommListener extends Comm.ConnectionListener {
    function initialize() {
        Comm.ConnectionListener.initialize();
    }

    function onComplete() {
        Sys.println("Transmit Complete");
    }

    function onError() {
        Sys.println("Transmit Failed");
    }
}

class CommInputDelegate extends Ui.BehaviorDelegate {
    function initialize() {
        Ui.BehaviorDelegate.initialize();
    }

    function onMenu() {
        var menu = new Ui.Menu();
        var delegate;

        menu.addItem("Send Data", :sendData);
        menu.addItem("Set Listener", :setListener);
        delegate = new BaseMenuDelegate();
        Ui.pushView(menu, delegate, SLIDE_IMMEDIATE);

        return true;
    }

    function onTap(event) {
        if(page == 0) {
            page = 1;
        } else {
            page = 0;
        }
        Ui.requestUpdate();
    }
}

class BaseMenuDelegate extends Ui.MenuInputDelegate {
    function initialize() {
        Ui.MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        var menu = new Ui.Menu();
        var delegate = null;

        if(item == :sendData) {
            menu.addItem("Hello World.", :hello);
            menu.addItem("Ackbar", :trap);
            menu.addItem("Garmin", :garmin);
            delegate = new SendMenuDelegate();
        } else if(item == :setListener) {
            menu.setTitle("Listner Type");
            menu.addItem("Mailbox", :mailbox);
            if(Comm has :registerForPhoneAppMessages) {
                menu.addItem("Phone App", :phone);
            }
            menu.addItem("None", :none);
            menu.addItem("Crash if 'Hi'", :phoneFail);
            delegate = new ListnerMenuDelegate();
        }

        Ui.pushView(menu, delegate, SLIDE_IMMEDIATE);
    }
}

class SendMenuDelegate extends Ui.MenuInputDelegate {
    function initialize() {
        Ui.MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        var listener = new CommListener();

        if(item == :hello) {
            Comm.transmit("Hello World.", null, listener);
        } else if(item == :trap) {
            Comm.transmit("IT'S A TRAP!", null, listener);
        } else if(item == :garmin) {
            Comm.transmit("ConnectIQ", null, listener);
        }

        Ui.popView(SLIDE_IMMEDIATE);
    }
}

class ListnerMenuDelegate extends Ui.MenuInputDelegate {
    function initialize() {
        Ui.MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if(item == :mailbox) {
            Comm.setMailboxListener(mailMethod);
        } else if(item == :phone) {
            if(Comm has :registerForPhoneAppMessages) {
                Comm.registerForPhoneAppMessages(phoneMethod);
            }
        } else if(item == :none) {
            Comm.registerForPhoneAppMessages(null);
            Comm.setMailboxListener(null);
        } else if(item == :phoneFail) {
            crashOnMessage = true;
            Comm.registerForPhoneAppMessages(phoneMethod);
        }

        Ui.popView(SLIDE_IMMEDIATE);
    }
}

