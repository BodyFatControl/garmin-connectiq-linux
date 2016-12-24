using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class ColorFactory extends Ui.PickerFactory
{
    var mColorWheel;

    function initialize(colors) {
        PickerFactory.initialize();
        mColorWheel = new ColorWheel({:colors => colors});
    }

    function getIndex(value) {
        return mColorWheel.getColorIndex(value);
    }

    function getSize() {
        return mColorWheel.getNumberOfColors();
    }

    function getValue(index) {
        return mColorWheel.getColor(index);
    }

    function getDrawable(index, selected) {
        mColorWheel.setColor(index);
        return mColorWheel;
    }
}
