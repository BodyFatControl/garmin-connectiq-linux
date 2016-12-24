using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class RectangleFactory extends Ui.PickerFactory {

    hidden var mColor;

    function initialize(color) {
        PickerFactory.initialize();
        mColor = color;
    }

    function getSize() {
        return 1;
    }

    function getValue(index) {
        return 0;
    }

    function getDrawable(index, selected) {
        return new Rectangle(mColor);
    }
}
