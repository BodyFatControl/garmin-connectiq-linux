using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class DatePicker extends Ui.Picker {

    function initialize() {
        var months = [Rez.Strings.month01, Rez.Strings.month02, Rez.Strings.month03,
                      Rez.Strings.month04, Rez.Strings.month05, Rez.Strings.month06,
                      Rez.Strings.month07, Rez.Strings.month08, Rez.Strings.month09,
                      Rez.Strings.month10, Rez.Strings.month11, Rez.Strings.month12];
        var title = new Ui.Text({:text=>Rez.Strings.datePickerTitle, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        var separator = new Ui.Text({:text=>Rez.Strings.dateSeparator, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER, :color=>Gfx.COLOR_WHITE});
        Picker.initialize({:title=>title, :pattern=>[new WordFactory(months, {}), separator, new NumberFactory(1,31,1, {}), separator, new NumberFactory(15,18,1,{:font=>Gfx.FONT_NUMBER_MEDIUM})]});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class DatePickerDelegate extends Ui.PickerDelegate {

    function initialize() {
        PickerDelegate.initialize();
    }

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        var separator = Ui.loadResource(Rez.Strings.dateSeparator);
        var date = Ui.loadResource(values[0]) + separator + values[2] + separator + values[4];
        App.getApp().setProperty("date", date);
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

}
