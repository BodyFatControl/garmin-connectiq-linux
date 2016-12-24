using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class PickerApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    //! onStart() is called on application start up
    function onStart(state) {
        // make sure that there is a valid color in the object store to
        // prevent null checks in several places
        if(getProperty("color") == null) {
            setProperty("color", Gfx.COLOR_RED);
        }
    }

    //! onStop() is called when your application is exiting
    function onStop(state) {
    }

    //! Return the initial view of your application here
    function getInitialView() {
        return [ new PickerView(), new PickerDelegate() ];
    }

}
