//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class StringView extends Ui.View {

    var common;
    var language;
    var greeting;
    var food;
    var drink;
    var commonLabel;
    var languageLabel;
    var greetingLabel;
    var foodLabel;
    var drinkLabel;

    var font = Gfx.FONT_SMALL;
    var lineSpacing = Gfx.getFontHeight(font);
    var centerY = 60; // Default taken from previous hard coded values

    function initialize() {
        View.initialize();
    }

    function onLayout(dc) {
        common = Ui.loadResource( Rez.Strings.common );
        language = Ui.loadResource( Rez.Strings.language );
        greeting = Ui.loadResource( Rez.Strings.greeting );
        food = Ui.loadResource( Rez.Strings.food );
        drink = Ui.loadResource( Rez.Strings.drink);
        commonLabel = Ui.loadResource( Rez.Strings.common_label );
        languageLabel = Ui.loadResource( Rez.Strings.language_label );
        greetingLabel = Ui.loadResource( Rez.Strings.greeting_label );
        foodLabel = Ui.loadResource( Rez.Strings.food_label );
        drinkLabel = Ui.loadResource( Rez.Strings.drink_label );

        centerY = (dc.getHeight() / 2) - (lineSpacing / 2);
    }

    function onUpdate(dc) {
        dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );

        dc.drawText( 85, centerY - (2 * lineSpacing), font, commonLabel,   Gfx.TEXT_JUSTIFY_RIGHT );
        dc.drawText( 85, centerY - (1 * lineSpacing), font, languageLabel, Gfx.TEXT_JUSTIFY_RIGHT );
        dc.drawText( 85, centerY,                     font, greetingLabel, Gfx.TEXT_JUSTIFY_RIGHT );
        dc.drawText( 85, centerY + (1 * lineSpacing), font, foodLabel,     Gfx.TEXT_JUSTIFY_RIGHT );
        dc.drawText( 85, centerY + (2 * lineSpacing), font, drinkLabel,    Gfx.TEXT_JUSTIFY_RIGHT );

        dc.drawText( 95, centerY - (2 * lineSpacing), font, common,   Gfx.TEXT_JUSTIFY_LEFT );
        dc.drawText( 95, centerY - (1 * lineSpacing), font, language, Gfx.TEXT_JUSTIFY_LEFT );
        dc.drawText( 95, centerY,                     font, greeting, Gfx.TEXT_JUSTIFY_LEFT );
        dc.drawText( 95, centerY + (1 * lineSpacing), font, food,     Gfx.TEXT_JUSTIFY_LEFT );
        dc.drawText( 95, centerY + (2 * lineSpacing), font, drink,    Gfx.TEXT_JUSTIFY_LEFT );
    }

}

//! Watch Face Page class
class StringApp extends App.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new StringView() ];
    }
}
