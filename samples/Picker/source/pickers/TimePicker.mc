using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.WatchUi as Ui;

const FACTORY_COUNT_24_HOUR = 3;
const FACTORY_COUNT_12_HOUR = 4;
const MINUTE_FORMAT = "%02d";

class TimePicker extends Ui.Picker {

    function initialize() {

        var title = new Ui.Text({:text=>Rez.Strings.timePickerTitle, :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        var factories;
        var hourFactory;
        var numberFactories;

        if(Sys.getDeviceSettings().is24Hour) {
            factories = new [FACTORY_COUNT_24_HOUR];
            factories[0] = new NumberFactory(0, 23, 1, {});
        }
        else {
            factories = new [FACTORY_COUNT_12_HOUR];
            factories[0] = new NumberFactory(1, 12, 1, {});
            factories[3] = new WordFactory([Rez.Strings.morning,Rez.Strings.afternoon], {});
        }

        factories[1] = new Ui.Text({:text=>Rez.Strings.timeSeparator, :font=>Gfx.FONT_MEDIUM, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER, :color=>Gfx.COLOR_WHITE});
        factories[2] = new NumberFactory(0, 59, 1, {:format=>MINUTE_FORMAT});

        var defaults = splitStoredTime(factories.size());
        if(defaults != null) {
            defaults[0] = factories[0].getIndex(defaults[0].toNumber());
            defaults[2] = factories[2].getIndex(defaults[2].toNumber());
            if(defaults.size() == FACTORY_COUNT_12_HOUR) {
                defaults[3] = factories[3].getIndex(defaults[3]);
            }
        }

        Picker.initialize({:title=>title, :pattern=>factories, :defaults=>defaults});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }

    function splitStoredTime(arraySize) {
        var storedValue = App.getApp().getProperty("time");
        var defaults = null;
        var separatorIndex = 0;
        var spaceIndex;

        if(storedValue != null) {
            defaults = new [arraySize];
            // the Drawable does not have a default value
            defaults[1] = null;

            // HH:MIN AM|PM
            separatorIndex = storedValue.find(Ui.loadResource(Rez.Strings.timeSeparator));
            if(separatorIndex != null ) {
                defaults[0] = storedValue.substring(0, separatorIndex);
            }
            else {
                defaults = null;
            }
        }

        if(defaults != null) {
            if(arraySize == FACTORY_COUNT_24_HOUR) {
                defaults[2] = storedValue.substring(separatorIndex + 1, storedValue.length());
            }
            else {
                spaceIndex = storedValue.find(" ");
                if(spaceIndex != null) {
                    defaults[2] = storedValue.substring(separatorIndex + 1, spaceIndex);
                    defaults[3] = storedValue.substring(spaceIndex + 1, storedValue.length());
                }
                else {
                    defaults = null;
                }
            }
        }

        return defaults;
    }
}

class TimePickerDelegate extends Ui.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var time = values[0] + Ui.loadResource(Rez.Strings.timeSeparator) + values[2].format(MINUTE_FORMAT);
        if(values.size() == FACTORY_COUNT_12_HOUR) {
            time += " " + Ui.loadResource(values[3]);
        }
        App.getApp().setProperty("time", time);

        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

}
