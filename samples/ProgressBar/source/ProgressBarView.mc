//!
//! Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Timer as Timer;

class MyWatchView extends Ui.View
{

    function initialize() {
        View.initialize();
    }

    function onUpdate(dc)
    {
        var string;

        dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );
        string = "Tap or hit start/enter\nto test progress bar";
        dc.drawText( dc.getWidth() / 2, 30, Gfx.FONT_SMALL, string, Gfx.TEXT_JUSTIFY_CENTER );
    }

}

class ProgressDelegate extends Ui.BehaviorDelegate
{
    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onBack() {
        return true;
    }
}

class InputDelegate extends Ui.BehaviorDelegate
{
    var progressBar;
    var timer;
    var count;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect()
    {
        if( timer == null )
        {
            timer = new Timer.Timer();
        }

        progressBar = new Ui.ProgressBar( "Processing", null );
        Ui.pushView( progressBar, new ProgressDelegate(), Ui.SLIDE_DOWN );
        count = 0;
        timer.start( method(:timerCallback), 1000, true );
    }

    function timerCallback()
    {
        count += 1;

        if( count > 17 )
        {
            timer.stop();
            Ui.popView( Ui.SLIDE_UP );
        }
        else if( count > 15 )
        {
            progressBar.setDisplayString( "Complete" );
        }
        else if( count > 5 )
        {
            progressBar.setProgress( (count - 5) * 10 );
        }
    }

}
