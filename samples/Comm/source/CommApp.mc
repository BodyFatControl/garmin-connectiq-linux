//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.Application as App;
using Toybox.Communications as Comm;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

var page = 0;
var strings = ["","","","",""];
var stringsSize = 5;
var mailMethod;
var crashOnMessage = false;

class CommExample extends App.AppBase {

    function initialize() {
        App.AppBase.initialize();

        mailMethod = method(:onMail);
        Comm.setMailboxListener(mailMethod);
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        return [new CommView(), new CommInputDelegate()];
    }

    function onMail(mailIter) {
        var mail;

        mail = mailIter.next();

        while(mail != null) {
            var i;
            for(i = (stringsSize - 1); i > 0; i -= 1) {
                strings[i] = strings[i-1];
            }
            strings[0] = mail.toString();
            page = 1;
            mail = mailIter.next();
        }

        Comm.emptyMailbox();
        Ui.requestUpdate();
    }
}