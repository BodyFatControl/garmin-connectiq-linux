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

module NumberPickerConstants {
    enum {
        DISPLAY_FLOAT,
        DISPLAY_INT,
        DISPLAY_DURATION
    }
}

var testValf = 1000f;
var testVali = 1;
var modeLabel = "";
var fieldTypeToDisplay = null;
var count = 0;
var dur = null;

class NPDf extends Ui.NumberPickerDelegate {
    function onNumberPicked(value) {
        testValf = value;
    }
}

class NPDi extends Ui.NumberPickerDelegate {
    function onNumberPicked(value) {
        testVali = value;
    }
}

class NPDd extends Ui.NumberPickerDelegate {
    function onNumberPicked(value) {
        dur = value;
    }
}

class BaseInputDelegate extends Ui.BehaviorDelegate {
    var np;
    var npi;

    function onSelect() {
        onMenu();
    }

    function onMenu() {
        if(Ui has :NumberPicker) {
            var value;
            if(count == 0) {
                modeLabel = "Distance";
                fieldTypeToDisplay = NumberPickerConstants.DISPLAY_FLOAT;
                np = new Ui.NumberPicker(Ui.NUMBER_PICKER_DISTANCE, testValf);
                Ui.pushView(np, new NPDf(), Ui.SLIDE_IMMEDIATE);
                count = count + 1;
            }
            else if(count == 1) {
                modeLabel = "Duration HH:MM:SS";
                fieldTypeToDisplay = NumberPickerConstants.DISPLAY_DURATION;
                // intentionally larger than max
                value = Calendar.duration({:hours=>9, :minutes=>8, :seconds=>10});
                np = new Ui.NumberPicker(Ui.NUMBER_PICKER_TIME, value);
                Ui.pushView(np, new NPDd(), Ui.SLIDE_IMMEDIATE);
                count = count + 1;
            }
            else if(count == 2) {
                modeLabel = "Duration MM:SS";
                fieldTypeToDisplay = NumberPickerConstants.DISPLAY_DURATION;
                value = Calendar.duration({:hours=>1, :minutes=>8, :seconds=>10});
                np = new Ui.NumberPicker(Ui.NUMBER_PICKER_TIME_MIN_SEC, value);
                Ui.pushView(np, new NPDd(), Ui.SLIDE_IMMEDIATE);
                count = count + 1;
            }
            else if(count == 3) {
                modeLabel = "Time Of Day";
                fieldTypeToDisplay = NumberPickerConstants.DISPLAY_DURATION;
                value = Calendar.duration({:hours=>23, :minutes=>8, :seconds=>10});
                np = new Ui.NumberPicker(Ui.NUMBER_PICKER_TIME_OF_DAY, value);
                Ui.pushView(np, new NPDd(), Ui.SLIDE_IMMEDIATE);
                count = count + 1;
            }
            else if(count == 4) {
                modeLabel = "Weight";
                fieldTypeToDisplay = NumberPickerConstants.DISPLAY_FLOAT;
                value = 454;
                np = new Ui.NumberPicker(Ui.NUMBER_PICKER_WEIGHT, value);
                Ui.pushView(np, new NPDf(), Ui.SLIDE_IMMEDIATE);
                count = count + 1;
            }
            else if(count == 5) {
                modeLabel = "Height";
                fieldTypeToDisplay = NumberPickerConstants.DISPLAY_FLOAT;
                value = 2;
                np = new Ui.NumberPicker(Ui.NUMBER_PICKER_HEIGHT, value);
                Ui.pushView(np, new NPDf(), Ui.SLIDE_IMMEDIATE);
                count = count + 1;
            }
            else if(count == 6) {
                modeLabel = "Calories";
                fieldTypeToDisplay = NumberPickerConstants.DISPLAY_INT;
                value = 200;
                np = new Ui.NumberPicker(Ui.NUMBER_PICKER_CALORIES, value);
                Ui.pushView(np, new NPDi(), Ui.SLIDE_IMMEDIATE);
                count = count + 1;
            }
            else if(count == 7) {
                modeLabel = "Birth Year";
                fieldTypeToDisplay = NumberPickerConstants.DISPLAY_INT;
                value = 1980;
                np = new Ui.NumberPicker(Ui.NUMBER_PICKER_BIRTH_YEAR, value);
                Ui.pushView(np, new NPDi(), Ui.SLIDE_IMMEDIATE);
                count = 0;
            }
            return true;
        }

        return false;
    }

    function onNextPage() {
    }
}

class NumberPickerView extends Ui.View {

    function onLayout(dc) {
        onUpdate(dc);
    }

    //! Restore the state of the app and prepare the view to be shown
    function onShow() {
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        var modeLabelFontHeight = dc.getFontHeight(Gfx.FONT_SMALL);
        var centerX = dc.getWidth() / 2;
        var centerY = dc.getHeight() / 2;
        var labelLocY = centerY - 10;
        var valueLocY = labelLocY + modeLabelFontHeight + 5;

        if(Ui has :NumberPicker) {
            dc.drawText(centerX, (centerY - 50), Gfx.FONT_SMALL, "Press Menu Or Select", Gfx.TEXT_JUSTIFY_CENTER);
            if(fieldTypeToDisplay != null) {

                dc.drawText(centerX, labelLocY, Gfx.FONT_SMALL, modeLabel, Gfx.TEXT_JUSTIFY_CENTER);

                if(fieldTypeToDisplay == NumberPickerConstants.DISPLAY_FLOAT) {
                   dc.drawText(centerX, valueLocY, Gfx.FONT_SMALL, testValf.toString(), Gfx.TEXT_JUSTIFY_CENTER);
                }

                else if(fieldTypeToDisplay == NumberPickerConstants.DISPLAY_INT) {
                   dc.drawText(centerX, valueLocY, Gfx.FONT_SMALL, testVali.toString(), Gfx.TEXT_JUSTIFY_CENTER);
                }

                else if(fieldTypeToDisplay == NumberPickerConstants.DISPLAY_DURATION) {
                    if( dur != null ) {
                        dc.drawText(centerX, valueLocY, Gfx.FONT_SMALL, dur.value().toString(), Gfx.TEXT_JUSTIFY_CENTER);
                    }
                }
            }
        }
        else {
            dc.drawText(centerX, (centerY - 50), Gfx.FONT_SMALL, "NumberPicker not supported.", Gfx.TEXT_JUSTIFY_CENTER);
        }
    }
}

