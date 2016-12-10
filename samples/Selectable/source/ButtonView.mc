//!
//! Copyright 2016 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;

class ButtonView extends Ui.View {

    //! Constructor
    function initialize() {
        View.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.ButtonLayout(dc));
    }

    //! Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);
    }
}
