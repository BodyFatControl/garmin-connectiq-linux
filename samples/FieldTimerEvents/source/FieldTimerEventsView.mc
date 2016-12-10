//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Activity as Act;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class FieldTimerEventsView extends Ui.DataField
{
    enum
    {
        STOPPED,
        PAUSED,
        RUNNING
    }

    hidden var mLapNumber = 0;
    hidden var mTimerState = STOPPED;
    hidden var mLapCertainty = "";

    //! constructor
    function initialize()
    {
        DataField.initialize();

        var info = Act.getActivityInfo();

        //! If the activity timer is greater than 0, then we don't know the lap or timer state.
        if( (info.timerTime != null) && (info.timerTime > 0) )
        {
            mLapCertainty = "?";
        }
    }

    //! This is called each time a lap is created, so increment the lap number.
    function onTimerLap()
    {
        mLapNumber++;
    }

    //! The timer was started, so set the state to running.
    function onTimerStart()
    {
        mTimerState = RUNNING;
    }

    //! The timer was stopped, so set the state to stopped.
    function onTimerStop()
    {
        mTimerState = STOPPED;
    }

    //! The timer was started, so set the state to running.
    function onTimerPause()
    {
        mTimerState = PAUSED;
    }

    //! The timer was stopped, so set the state to stopped.
    function onTimerResume()
    {
        mTimerState = RUNNING;
    }

    //! The timer was reeset, so reset all our tracking variables
    function onTimerReset()
    {
        mLapNumber = 0;
        mTimerState = STOPPED;
        mLapCertainty = "";
    }

    //! The given info object contains all the current workout
    //! information. Calculate a value and save it locally in this method.
    function compute(info)
    {
    }

    //! Display the value you computed here. This will be called
    //! once a second when the data field is visible.
    function onUpdate(dc)
    {
        // Timer events are supported so update the view with the
        // current timer/lap information.
        if (Ui.DataField has :onTimerLap) {
            var dataColor;
            var lapString;

            //! Select text color based on timer state.
            if( mTimerState == null )
            {
                dataColor = Gfx.COLOR_BLACK;
            }
            else if( mTimerState == RUNNING )
            {
                dataColor = Gfx.COLOR_GREEN;
            }
            else if( mTimerState == PAUSED )
            {
                dataColor = Gfx.COLOR_YELLOW;
            }
            else
            {
                dataColor = Gfx.COLOR_RED;
            }

            dc.setColor(dataColor, Gfx.COLOR_WHITE);
            dc.clear();

            //! Construct the lap string.
            lapString = mLapNumber.format("%d") + mLapCertainty;

            //! Draw the lap number
            dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Gfx.FONT_NUMBER_MEDIUM, lapString, (Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));

        // Timer events are not supported so show a message letting
        // the user know that.
        } else {
            dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
            dc.clear();

            var message = "Timer Events\nNot Supported";
            dc.drawText(dc.getWidth()/2, dc.getHeight()/2, Gfx.FONT_MEDIUM, message, (Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER));
        }
    }
}
