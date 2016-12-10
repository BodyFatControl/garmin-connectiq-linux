//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;

class MyWatchView extends Ui.View {

    var train;
    var backdrop;
    var cloud;

    // Constructor
    function initialize() {
        View.initialize();
        train = new Rez.Drawables.train();
        backdrop = new Rez.Drawables.backdrop();
        cloud = new Ui.Bitmap({:rezId=>Rez.Drawables.cloud,:locX=>10,:locY=>30});
        Ui.animate( cloud, :locX, Ui.ANIM_TYPE_LINEAR, 10, 230, 10, null );
    }

    // Load your resources here
    function onLayout(dc) {
    }

    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_BLACK);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
        backdrop.draw(dc);
        train.draw(dc);
        cloud.draw(dc);
    }

}
