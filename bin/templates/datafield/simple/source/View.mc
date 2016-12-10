using Toybox.WatchUi as Ui;

class ${viewClassName} extends Ui.SimpleDataField {

    // Set the label of the data field here.
    function initialize() {
        SimpleDataField.initialize();
        label = "My Label";
    }

    // The given info object contains all the current workout
    // information. Calculate a value and return it in this method.
    function compute(info) {
        // See Activity.Info in the documentation for available information.
        return 0.0;
    }

}