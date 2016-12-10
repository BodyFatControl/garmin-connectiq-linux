//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.SensorHistory as SH;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Gregorian;
using Toybox.Lang as Lang;

class SensorHistoryView extends Ui.View {

    hidden var mIndex = 0;
    hidden var mSensorSymbols = [:getHeartRateHistory,
                                 :getTemperatureHistory,
                                 :getPressureHistory,
                                 :getElevationHistory ];

    hidden var mSensorLabel = ["Heart Rate",
                               "Temperature",
                               "Pressure",
                               "Elevation" ];
    hidden var mSensorMin = [50,
                             0,
                             50000,
                             0 ];

    hidden var mSensorRange = [140,
                               45,
                               60000,
                               6000 ];
    function initialize() {
        View.initialize();
    }

    function getIterator() {
        if ( ( Toybox has :SensorHistory ) && ( Toybox.SensorHistory has mSensorSymbols[mIndex] ) ) {
            var getMethod = new Lang.Method( Toybox.SensorHistory, mSensorSymbols[mIndex] );
            return getMethod.invoke( {} );
        }
        return null;
    }

    // Load your resources here
    function onLayout(dc) {
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        if ( Toybox has :SensorHistory ) {
            var sensorIter = getIterator();
            if( sensorIter != null ) {
                var previous = sensorIter.next();
                var sample = sensorIter.next();
                var x = 0;
                var min = sensorIter.getMin();
                var max = sensorIter.getMax();
                var firstSampleTime = null;
                var lastSampleTime = null;
                var graphBottom = dc.getHeight()/2 + 45;
                var graphHeight = 90;
                var dataOffset = mSensorMin[mIndex].toFloat();
                var dataScale = mSensorRange[mIndex].toFloat();
                var gotValidData = false;
                dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_GREEN);

                while( null != sample ) {

                    if( null == firstSampleTime ) {
                        firstSampleTime = previous.when;
                    }

                    if( sample.data != null && previous.data != null ) {
                        lastSampleTime = sample.when;
                        var y1 = graphBottom - (previous.data - dataOffset) / dataScale * graphHeight;
                        var y2 = graphBottom - (sample.data - dataOffset) / dataScale * graphHeight;
                        dc.drawLine(x, y1, x+1, y2);
                        gotValidData = true;
                        }
                    ++x;
                    previous = sample;
                    sample = sensorIter.next();
                    }

                if( gotValidData ) {
                    // draw the min/max hr values
                    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
                    if( max == null ) {
                        max = "?";
                    } else {
                        max = max.format( "%d" );
                    }
                    if( min == null ) {
                        min = "?";
                    } else {
                        min = min.format( "%d" );
                    }
                    dc.drawText(dc.getWidth()/2, 0, Gfx.FONT_SMALL, mSensorLabel[mIndex] + "\nMax: " + max + " Min: " + min, Gfx.TEXT_JUSTIFY_CENTER);

                    // draw the start/end times
                    var startInfo = Gregorian.info(firstSampleTime, Time.FORMAT_SHORT);
                    var endInfo = Gregorian.info(lastSampleTime, Time.FORMAT_SHORT);
                    var startString = format("$1$:$2$:$3$", [startInfo.hour.format("%02d"), startInfo.min.format("%02d"), startInfo.sec.format("%02d")]);
                    var endString = format("$1$:$2$:$3$", [endInfo.hour.format("%02d"), endInfo.min.format("%02d"), endInfo.sec.format("%02d")]);
                    dc.drawText(dc.getWidth()/2, dc.getHeight() - 40, Gfx.FONT_SMALL, "Start: " + startString + "\nEnd: " + endString, Gfx.TEXT_JUSTIFY_CENTER);
                }
                else {
                    var message = "No data available.";
                    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
                    dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Gfx.FONT_MEDIUM, message, (Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
                }
            }
            else {
                var message = mSensorLabel[mIndex] + "\nsensor not available";
                dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
                dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Gfx.FONT_MEDIUM, message, (Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
            }

        } else {
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_BLACK);
            var message = "Sensor History\nNot Supported";
            dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Gfx.FONT_MEDIUM, message, (Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    function nextSensor() {
        mIndex += 1;
        mIndex %= 4;
    }

    function previousSensor() {
        mIndex += 3;
        mIndex %= 4;
    }
}
