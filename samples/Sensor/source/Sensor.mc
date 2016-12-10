//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time.Gregorian as Calendar;
using Toybox.Sensor as Snsr;
using Toybox.Application as App;
using Toybox.Position as GPS;

class SensorTester extends Ui.View
{
    var string_HR;
    var HR_graph;

    //! Constructor
    function initialize()
    {
        View.initialize();
        Snsr.setEnabledSensors( [Snsr.SENSOR_HEARTRATE] );
        Snsr.enableSensorEvents( method(:onSnsr) );
        HR_graph = new LineGraph( 20, 10, Gfx.COLOR_RED );

        string_HR = "---bpm";
    }

    //! Handle the update event
    function onUpdate(dc)
    {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );

        dc.drawText( 100, 90, Gfx.FONT_LARGE, string_HR, Gfx.TEXT_JUSTIFY_CENTER);

        HR_graph.draw( dc, [5,30], [200,129] );
    }

    function onSnsr(sensor_info)
    {
        var HR = sensor_info.heartRate;
        var bucket;
        if( sensor_info.heartRate != null )
        {
            string_HR = HR.toString() + "bpm";

            //Add value to graph
            HR_graph.addItem(HR);
        }
        else
        {
            string_HR = "---bpm";
        }

        Ui.requestUpdate();
    }
}

//! main is the primary start point for a Monkeybrains application
class SensorTest extends App.AppBase
{
    function initialize() {
        AppBase.initialize();
    }

    function onStart(state)
    {
        return false;
    }

    function getInitialView()
    {
        return [new SensorTester()];
    }

    function onStop(state)
    {
        return false;
    }
}
