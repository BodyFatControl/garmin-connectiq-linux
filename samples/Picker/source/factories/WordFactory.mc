using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class WordFactory extends Ui.PickerFactory {
    var mWords;
    var mFont;

    function initialize(words, options) {
        PickerFactory.initialize();

        mWords = words;

        if(options != null) {
            mFont = options.get(:font);
        }

        if(mFont == null) {
            mFont = Gfx.FONT_LARGE;
        }
    }

    function getIndex(value) {
        if(value instanceof String) {
            for(var i = 0; i < mWords.size(); ++i) {
                if(value.equals(Ui.loadResource(mWords[i]))) {
                    return i;
                }
            }
        }
        else {
            for(var i = 0; i < mWords.size(); ++i) {
                if(mWords[i].equals(value)) {
                    return i;
                }
            }
        }

        return 0;
    }

    function getSize() {
        return mWords.size();
    }

    function getValue(index) {
        return mWords[index];
    }

    function getDrawable(index, selected) {
        return new Ui.Text({:text=>mWords[index], :color=>Gfx.COLOR_WHITE, :font=>mFont, :locX=>Ui.LAYOUT_HALIGN_CENTER, :locY=>Ui.LAYOUT_VALIGN_CENTER});
    }
}
