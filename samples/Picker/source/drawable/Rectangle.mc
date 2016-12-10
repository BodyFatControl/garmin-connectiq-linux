using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class Rectangle extends Ui.Drawable {

    var mColor;

    function initialize(color) {
        Drawable.initialize({});
        mColor = color;
    }

    function draw(dc) {
        dc.setColor(mColor, mColor);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());
    }
}
