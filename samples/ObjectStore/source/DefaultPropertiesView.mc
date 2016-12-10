//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class DefaultPropertiesView extends Ui.View
{

    hidden var mIndicator;

    function initialize() {
        mIndicator = new PageIndicator();
        var size = 2;
        var selected = Gfx.COLOR_DK_GRAY;
        var notSelected = Gfx.COLOR_LT_GRAY;
        var alignment = mIndicator.ALIGN_TOP_RIGHT;
        var margin = 3;
        mIndicator.setup(size, selected, notSelected, alignment, margin);
    }

    function onUpdate(dc)
    {
        var app = App.getApp();

        var int = app.getProperty("number_prop");
        var float = app.getProperty("float_prop");
        var string = app.getProperty("string_prop");
        var boolean = app.getProperty("boolean_prop");

        if(null==int)
        {
            int="Not set";
        }

        if(null==float)
        {
            float="Not set";
        }

        if(null==string)
        {
            string="Not set";
        }

        if(null==boolean)
        {
            boolean="Not set";
        }

        dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_BLACK);
        dc.clear();
        dc.drawText(3, 1, Gfx.FONT_SMALL, "Default Properties", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 89, Gfx.FONT_SMALL, "Edit these via Express/GCM", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 107, Gfx.FONT_SMALL, "Default properties can't", Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 125, Gfx.FONT_SMALL, "be cleared", Gfx.TEXT_JUSTIFY_LEFT);

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        dc.drawText(3, 20, Gfx.FONT_SMALL, "Int: " + int, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 37, Gfx.FONT_SMALL, "Float: " + float, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 54, Gfx.FONT_SMALL, "String: " + string, Gfx.TEXT_JUSTIFY_LEFT);
        dc.drawText(3, 71, Gfx.FONT_SMALL, "Boolean: " + boolean, Gfx.TEXT_JUSTIFY_LEFT);

        mIndicator.draw(dc, 1);
    }
}

class DefaultPropertiesViewDelegate extends Ui.BehaviorDelegate
{
    var count = 0;

    function onNextPage() {
        Ui.switchToView(new ObjectStoreView(), new ObjectStoreViewDelegate(), Ui.SLIDE_LEFT);
        return true;
    }

    function onPreviousPage() {
        Ui.switchToView(new ObjectStoreView(), new ObjectStoreViewDelegate(), Ui.SLIDE_RIGHT);
        return true;
    }

    function onKey(evt) {
        if (evt.getKey() == Ui.KEY_ENTER) {
            return onTap(null);
        }
        return false;
    }

    function onTap(evt) {
        var app = App.getApp();
        var int = app.getProperty("number_prop");
        int += 1;
        app.setProperty("number_prop", int );
        Ui.requestUpdate();
        return true;
    }
}