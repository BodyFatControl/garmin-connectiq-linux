using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class ColorPicker extends Ui.Picker {
    var factory;
    var title;

    function initialize() {
        title = new Ui.Text({:text=>Rez.Strings.colorPickerTitle, :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        factory = new ColorFactory([Gfx.COLOR_RED, Gfx.COLOR_GREEN, Gfx.COLOR_BLUE, Gfx.COLOR_ORANGE, Gfx.COLOR_YELLOW, Gfx.COLOR_PURPLE]);
        var defaults = null;
        var value = App.getApp().getProperty("color");
        if(value != null) {
            defaults = [ factory.getIndex(value) ];
        }

        var nextArrow = new Ui.Bitmap({:rezId=>Rez.Drawables.nextArrow, :locX => Ui.LAYOUT_HALIGN_CENTER, :locY => Ui.LAYOUT_VALIGN_CENTER});
        var previousArrow = new Ui.Bitmap({:rezId=>Rez.Drawables.previousArrow, :locX => Ui.LAYOUT_HALIGN_CENTER, :locY => Ui.LAYOUT_VALIGN_CENTER});
        var brush = new Ui.Bitmap({:rezId=>Rez.Drawables.brush, :locX => Ui.LAYOUT_HALIGN_CENTER, :locY => Ui.LAYOUT_VALIGN_CENTER});
        Picker.initialize({:title=>title, :pattern=>[factory], :defaults=>defaults, :nextArrow=>nextArrow, :previousArrow=>previousArrow, :confirm=>brush});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class ColorPickerDelegate extends Ui.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        App.getApp().setProperty("color", values[0]);
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

}
