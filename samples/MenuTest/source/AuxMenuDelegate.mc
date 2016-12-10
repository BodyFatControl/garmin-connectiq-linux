using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class AuxMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :AuxItem1) {
            Sys.println("Aux Item 1");
        } else if (item == :AuxItem2) {
            Sys.println("Aux Item 2");
            Ui.popView(Ui.SLIDE_DOWN);
        }
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_DOWN);
    }
}
