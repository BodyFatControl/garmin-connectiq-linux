//!
//! Copyright 2015 by Garmin Ltd. or its subsidiaries.
//! Subject to Garmin SDK License Agreement and Wearables
//! Application Developer Agreement.
//!

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class StringView extends Ui.View
{
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


    function onLayout(dc)
    {
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
    }

    function onUpdate(dc)
    {
        dc.setColor( Gfx.COLOR_BLACK, Gfx.COLOR_BLACK );
        dc.clear();
        dc.setColor( Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT );

        dc.drawText( 85, 0, Gfx.FONT_SMALL, commonLabel, Gfx.TEXT_JUSTIFY_RIGHT );
        dc.drawText( 85, 30, Gfx.FONT_SMALL, languageLabel, Gfx.TEXT_JUSTIFY_RIGHT );
        dc.drawText( 85, 60, Gfx.FONT_SMALL, greetingLabel, Gfx.TEXT_JUSTIFY_RIGHT );
        dc.drawText( 85, 90, Gfx.FONT_SMALL, foodLabel, Gfx.TEXT_JUSTIFY_RIGHT );
        dc.drawText( 85, 120, Gfx.FONT_SMALL, drinkLabel, Gfx.TEXT_JUSTIFY_RIGHT );

        dc.drawText( 100, 0, Gfx.FONT_SMALL, common, Gfx.TEXT_JUSTIFY_LEFT );
        dc.drawText( 100, 30, Gfx.FONT_SMALL, language, Gfx.TEXT_JUSTIFY_LEFT );
        dc.drawText( 100, 60, Gfx.FONT_SMALL, greeting, Gfx.TEXT_JUSTIFY_LEFT );
        dc.drawText( 100, 90, Gfx.FONT_SMALL, food, Gfx.TEXT_JUSTIFY_LEFT );
        dc.drawText( 100, 120, Gfx.FONT_SMALL, drink, Gfx.TEXT_JUSTIFY_LEFT );
    }
}

//! Watch Face Page class
class StringApp extends App.AppBase
{
    function getInitialView()
    {
        return [ new StringView() ];
    }
}
