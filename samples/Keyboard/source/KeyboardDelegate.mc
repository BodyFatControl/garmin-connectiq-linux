//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;

var lastText = "";

class KeyboardDelegate extends Ui.InputDelegate {

    // Push a text picker if the up button is pressed
    // or the screen receives a tap.
    function onKey(key) {
        if (Ui has :TextPicker) {
            if (key.getKey() == Ui.KEY_UP) {
                Ui.pushView(new Ui.TextPicker(lastText), new KeyboardListener(), Ui.SLIDE_DOWN);
            }
        }
    }

    function onTap(evt) {
        if (Ui has :TextPicker) {
            Ui.pushView(new Ui.TextPicker(lastText), new KeyboardListener(), Ui.SLIDE_DOWN);
        }
    }

}

class KeyboardListener extends Ui.TextPickerDelegate {
    function onTextEntered(text, changed) {
        globalText = text + "\n" + "Changed: " + changed;
        lastText = text;
    }

    function onCancel() {
        globalText = "Cancelled";
    }
}