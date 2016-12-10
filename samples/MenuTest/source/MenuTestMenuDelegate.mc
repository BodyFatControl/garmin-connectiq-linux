using Toybox.WatchUi as Ui;
using Toybox.System as Sys;

class MenuTestMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :Item1) {
            Sys.println("Item 1");
            Ui.pushView(new Rez.Menus.AuxMenu(), new AuxMenuDelegate(), Ui.SLIDE_UP);
        } else if (item == :Item2) {
            Sys.println("Item 2");
        }
    }

    function onBack() {
        Ui.popView(Ui.SLIDE_DOWN);
    }
}
