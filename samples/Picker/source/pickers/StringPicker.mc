using Toybox.Application as App;
using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class StringPicker extends Ui.Picker {
    const mCharacterSet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    hidden var mTitle;
    hidden var mTitleText;
    hidden var mFactory;

    function initialize() {
        mFactory = new CharacterFactory(mCharacterSet, {:addOk=>true});
        mTitleText = "";

        var string = App.getApp().getProperty("string");
        var defaults = null;
        var titleText = Rez.Strings.stringPickerTitle;

        if(string != null) {
            mTitleText = string;
            titleText = string;
            defaults = [mFactory.getIndex(string.substring(string.length()-1, string.length()))];
        }

        mTitle = new Ui.Text({:text=>titleText, :locX =>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_BOTTOM, :color=>Gfx.COLOR_WHITE});

        Picker.initialize({:title=>mTitle, :pattern=>[mFactory], :defaults=>defaults});
    }

    function onUpdate(dc) {
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_BLACK);
        dc.clear();
        Picker.onUpdate(dc);
    }

    function addCharacter(character) {
        mTitleText += character;
        mTitle.setText(mTitleText);
    }

    function removeCharacter() {
        mTitleText = mTitleText.substring(0, mTitleText.length() - 1);

        if(0 == mTitleText.length()) {
            mTitle.setText(Ui.loadResource(Rez.Strings.stringPickerTitle));
        }
        else {
            mTitle.setText(mTitleText);
        }
    }

    function getTitle() {
        return mTitleText.toString();
    }

    function getTitleLength() {
        return mTitleText.length();
    }

    function isDone(value) {
        return mFactory.isDone(value);
    }
}

class StringPickerDelegate extends Ui.PickerDelegate {
    hidden var mPicker;

    function initialize(picker) {
        mPicker = picker;
    }

    function onCancel() {
        if(0 == mPicker.getTitleLength()) {
            Ui.popView(Ui.SLIDE_IMMEDIATE);
        }
        else {
            mPicker.removeCharacter();
        }
    }

    function onAccept(values) {
        if(!mPicker.isDone(values[0])) {
            mPicker.addCharacter(values[0]);
        }
        else {
            if(mPicker.getTitle().length() == 0) {
                App.getApp().deleteProperty("string");
            }
            else {
                App.getApp().setProperty("string", mPicker.getTitle());
            }
            Ui.popView(Ui.SLIDE_IMMEDIATE);
        }
    }
}
