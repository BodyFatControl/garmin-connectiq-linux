using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class PickerChooser extends Ui.Picker {

    function initialize() {
        var title = new Ui.Text({:text=>Rez.Strings.pickerChooserTitle, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});
        var factory = new WordFactory([Rez.Strings.pickerChooserColor, Rez.Strings.pickerChooserDate, Rez.Strings.pickerChooserString, Rez.Strings.pickerChooserTime, Rez.Strings.pickerChooserLayout], {:font=>Gfx.FONT_MEDIUM});
        Picker.initialize({:title=>title, :pattern=>[factory]});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }
}

class PickerChooserDelegate extends Ui.PickerDelegate {

    function onCancel() {
        Ui.popView(Ui.SLIDE_IMMEDIATE);
    }

    function onAccept(values) {
        if(values[0] == Rez.Strings.pickerChooserColor) {
            Ui.pushView(new ColorPicker(), new ColorPickerDelegate(), Ui.SLIDE_IMMEDIATE);
        }
        else if(values[0] == Rez.Strings.pickerChooserDate) {
            Ui.pushView(new DatePicker(), new DatePickerDelegate(), Ui.SLIDE_IMMEDIATE);
        }
        else if(values[0] == Rez.Strings.pickerChooserString) {
            var picker = new StringPicker();
            Ui.pushView(picker, new StringPickerDelegate(picker), Ui.SLIDE_IMMEDIATE);
        }
        else if(values[0] == Rez.Strings.pickerChooserTime) {
            Ui.pushView(new TimePicker(), new TimePickerDelegate(), Ui.SLIDE_IMMEDIATE);
        }
        else if(values[0] == Rez.Strings.pickerChooserLayout) {
            Ui.pushView(new LayoutPicker(), new LayoutPickerDelegate(), Ui.SLIDE_IMMEDIATE);
        }
    }
}
