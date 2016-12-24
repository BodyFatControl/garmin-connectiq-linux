using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class PickerView extends Ui.View {

    function initialize() {
        View.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This include
    //! loading resources into memory.
    function onShow() {
        var app = App.getApp();

        // find and modify the labels based on what is in the object store
        var string = findDrawableById("string");
        var date = findDrawableById("date");
        var time = findDrawableById("time");

        var prop = app.getProperty("string");
        if(prop != null) {
            string.setText(prop);
        }
        else {
            string.setText(Rez.Strings.string);
        }

        prop = app.getProperty("date");
        if(prop != null) {
            date.setText(prop);
        }

        prop = app.getProperty("time");
        if(prop != null) {
            time.setText(prop);
        }

        // set the color of each Text object
        prop = app.getProperty("color");
        if(prop != null) {
            time.setColor(prop);
            date.setColor(prop);
            string.setColor(prop);
        }
    }

    //! Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

}

class PickerDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        return pushPicker();
    }

    function onKey(evt) {
        var key = evt.getKey();
        if (Ui.KEY_START == key || Ui.KEY_ENTER == key) {
            return onSelect();
        }
        return false;

    }
    function onSelect() {
        return pushPicker();
    }

    function pushPicker() {
        Ui.pushView(new PickerChooser(), new PickerChooserDelegate(), Ui.SLIDE_IMMEDIATE);
        return true;
    }

}