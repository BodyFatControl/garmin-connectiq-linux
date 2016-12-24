using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class LayoutPicker extends Ui.Picker {

    function initialize() {
        var factory = new RectangleFactory(Gfx.COLOR_PURPLE);
        Picker.initialize({:title=>new Rectangle(Gfx.COLOR_RED),
                           :pattern=>[factory, factory, factory, factory, factory],
                           :nextArrow=>new Rectangle(Gfx.COLOR_GREEN),
                           :previousArrow=>new Rectangle(Gfx.COLOR_GREEN),
                           :confirm=>new Rectangle(Gfx.COLOR_WHITE)});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class LayoutPickerDelegate extends Ui.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

}
