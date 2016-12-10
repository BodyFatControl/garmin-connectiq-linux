//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class GraphView extends Ui.View {

    hidden var mIndex;
    hidden var mIndicator;
    hidden var mSensor;
    hidden var mFonts;
    hidden var mTotalGraph;
    hidden var mCurrentGraph;

    function initialize(sensor, index) {
        mIndex = index;

        mIndicator = new PageIndicator();
        var size = 4;
        var selected = Gfx.COLOR_DK_GRAY;
        var notSelected = Gfx.COLOR_LT_GRAY;
        var alignment = mIndicator.ALIGN_BOTTOM_RIGHT;
        mIndicator.setup(size, selected, notSelected, alignment, 0);

        mTotalGraph = new LineGraph(30, 10, Gfx.COLOR_RED);
        mCurrentGraph = new LineGraph(30, 1, Gfx.COLOR_BLUE);
        mFonts = [Gfx.FONT_SMALL, Gfx.FONT_MEDIUM, Gfx.FONT_LARGE];

        mSensor = sensor;
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();

        var width = dc.getWidth();
        var height = dc.getHeight();

        mTotalGraph.addItem(mSensor.data.totalHemoConcentration.toFloat());
        mCurrentGraph.addItem(mSensor.data.currentHemoPercent.toFloat());

        if (mSensor.data.totalHemoConcentration != null) {
            var totalString = mSensor.data.totalHemoConcentration.format("%0.2f");
            var font = pickFont( dc, totalString, width / 4 );
            var fWidth = dc.getTextWidthInPixels(totalString, font);

            //Draw HR value with drop shadow
            dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2 + 1, (height / 2) - 4 + 1, font, totalString, Gfx.TEXT_JUSTIFY_LEFT);
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2, (height / 2) - 4, font, totalString, Gfx.TEXT_JUSTIFY_LEFT);


            totalString = "Total";
            font = pickFont(dc, totalString, width/5);
            //Draw with drop shadow
            dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2 + 1, (height / 3) + 1, font, totalString, Gfx.TEXT_JUSTIFY_LEFT);
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2, (height / 3), font, totalString, Gfx.TEXT_JUSTIFY_LEFT);

            //use smallest font for "g / dl"
            font = mFonts[0];
            totalString = "g / dl";
            //Draw with drop shadow
            dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2 + fWidth + 3 + 1, (height / 2) - 4 + 1, font, totalString, Gfx.TEXT_JUSTIFY_LEFT);
            dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2 + fWidth + 3, (height / 2) - 4, font, totalString, Gfx.TEXT_JUSTIFY_LEFT);

            //We should have thick lines eventually... this is a hack for now.
            mTotalGraph.draw(dc, [(width / 4) + 2, 3], [width - 3, (height / 2) - 3]);
            mTotalGraph.draw(dc, [(width / 4) + 2 + 1, 3], [width - 3 + 1, (height / 2) - 3]);
            mTotalGraph.draw(dc, [(width / 4) + 2, 3 + 1], [width - 3, (height / 2) - 3 + 1]);
            mTotalGraph.draw(dc, [(width / 4) + 2 + 1, 3 + 1], [width - 3 + 1, (height / 2) - 3 + 1]);
        }

        if (mSensor.data.currentHemoPercent != null) {
            var currentString = mSensor.data.currentHemoPercent.format("%0.1f");
            var font = pickFont(dc, currentString, width / 4);
            var fWidth = dc.getTextWidthInPixels(currentString, font);

            //Draw mSensor.data.currentHemoPercent value with drop shadow
            dc.setColor(Gfx.COLOR_DK_GRAY, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2 + 1, height - 4 + 1, font, currentString, Gfx.TEXT_JUSTIFY_LEFT);
            dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2, height - 4, font, currentString, Gfx.TEXT_JUSTIFY_LEFT);

            currentString = "Current";
            font = pickFont(dc, currentString, width/5);
            //Draw with drop shadow
            dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2 + 1, height - (height / 5) + 1, font, currentString, Gfx.TEXT_JUSTIFY_LEFT);
            dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2, height - (height / 5), font, currentString, Gfx.TEXT_JUSTIFY_LEFT);

            //use smallest font for "percent"
            font = mFonts[0];
            currentString = "%";
            //Draw with drop shadow
            dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2 + fWidth + 3 + 1, height - 4 + 1, font, currentString, Gfx.TEXT_JUSTIFY_LEFT);
            dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
            dc.drawText(2 + fWidth + 3, height - 4, font, currentString, Gfx.TEXT_JUSTIFY_LEFT);

            //We should have thick lines eventually... this is a hack for now.
            mCurrentGraph.draw(dc, [(width / 4) + 2, height / 2], [width - 3, height - 3]);
            mCurrentGraph.draw(dc, [(width / 4) + 2 + 1, height / 2], [width - 3 + 1, height - 3]);
            mCurrentGraph.draw(dc, [(width / 4) + 2, height / 2 + 1], [width - 3, height - 3 + 1]);
            mCurrentGraph.draw(dc, [(width / 4) + 2 + 1, height / 2 + 1], [width - 3 + 1, height - 3 + 1]);
        }

        // Draw the page indicator
        mIndicator.draw(dc, mIndex);
    }

    function pickFont(dc, string, width) {
        var i = mFonts.size() - 1;

        while (i > 0) {
            if (dc.getTextWidthInPixels(string, mFonts[i]) <= width) {
                return mFonts[i];
            }
            i -= 1;
        }

        return mFonts[0];
    }
}
