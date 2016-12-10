using Toybox.WatchUi as Ui;

class ${delegateClassName} extends Ui.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        Ui.pushView(new Rez.Menus.MainMenu(), new ${menuDelegateClassName}(), Ui.SLIDE_UP);
        return true;
    }

}