using Toybox.WatchUi as Ui;

class MenuTestDelegate extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new MenuTestMenuDelegate(), Ui.SLIDE_UP);
        return true;
    }
}
