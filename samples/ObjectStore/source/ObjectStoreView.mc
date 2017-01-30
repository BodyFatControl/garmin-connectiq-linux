//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class ObjectStoreView extends Ui.View {

    hidden var mIndicator;

    function initialize() {
        View.initialize();
        mIndicator = new PageIndicator();
        var size = 2;
        var selected = Gfx.COLOR_DK_GRAY;
        var notSelected = Gfx.COLOR_LT_GRAY;
        var alignment = mIndicator.ALIGN_TOP_RIGHT;
        var margin = 3;
        mIndicator.setup(size, selected, notSelected, alignment, margin);
    }

    function onUpdate(dc) {
        var app = App.getApp();

        var int = app.getProperty(INT_KEY);
        var float = app.getProperty(FLOAT_KEY);
        var string = app.getProperty(STRING_KEY);
        var boolean = app.getProperty(BOOLEAN_KEY);
        var array = app.getProperty(ARRAY_KEY);
        var dictionary = app.getProperty(DICTIONARY_KEY);

        if (null==int) {
            int="Not set";
        }

        if (null==float) {
            float="Not set";
        }

        if (null==string) {
            string="Not set";
        }

        if (null==boolean) {
            boolean="Not set";
        }

        if (null==array) {
            array="Not set";
        }

        if (null==dictionary) {
            dictionary="Not set";
        }

        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
        dc.clear();
        dc.drawText(3, 1, Gfx.FONT_SMALL, "Runtime Properties", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 125, Gfx.FONT_SMALL, "Tap to change, hold to clear", Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(3, 20, Gfx.FONT_SMALL, "Int: " + int, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 37, Gfx.FONT_SMALL, "Float: " + float, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 54, Gfx.FONT_SMALL, "String: " + string, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 71, Gfx.FONT_SMALL, "Boolean: " + boolean, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 88, Gfx.FONT_SMALL, "Array: " + array, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 105, Gfx.FONT_SMALL, "Dictionary: " + dictionary, Gfx.TEXT_JUSTIFY_LEFT);

        mIndicator.draw(dc, 0);
    }
}

enum {
    INT_KEY,
    FLOAT_KEY,
    STRING_KEY,
    BOOLEAN_KEY,
    ARRAY_KEY,
    DICTIONARY_KEY
}

class ObjectStoreViewDelegate extends Ui.BehaviorDelegate {
    var count;

    function initialize() {
        BehaviorDelegate.initialize();
        count = App.getApp().getProperty("count");
        if (count == null)
        {
            count = 0;
        }
    }

    function onNextPage() {
        Ui.switchToView(new DefaultPropertiesView(), new DefaultPropertiesViewDelegate(), Ui.SLIDE_LEFT);
        return true;
    }

    function onPreviousPage() {
        Ui.switchToView(new DefaultPropertiesView(), new DefaultPropertiesViewDelegate(), Ui.SLIDE_RIGHT);
        return true;
    }

    function onKey(evt) {
        if (evt.getKey() == Ui.KEY_ENTER) {
            return onTap(null);
        } else if (evt.getKey() == Ui.KEY_MENU) {
            return onHold(null);
        }
        return false;
    }

    function onTap(evt) {
        var app = App.getApp();

        if (0 == count) {
            app.setProperty(INT_KEY, 3);
        } else if (1 == count) {
            app.setProperty(FLOAT_KEY, 3.14159);
        } else if (2 == count) {
            app.setProperty(STRING_KEY, "pie");
        } else if (3 == count) {
            app.setProperty(BOOLEAN_KEY, true);
        } else if (4 == count) {
            app.setProperty(ARRAY_KEY, [1,2,3,null]);
        } else if (5 == count) {
            app.setProperty(DICTIONARY_KEY, {1=>"one", "two"=>2, "null"=>null});
        } else {
            app.deleteProperty(count - 6);
        }

        count += 1;

        if (count == 12) {
            count = 0;
        }

        app.setProperty("count", count);

        Ui.requestUpdate();
        return true;
    }

    function onHold(evt) {
        App.getApp().clearProperties();
        count = 0;
        Ui.requestUpdate();
        return true;
    }

}
