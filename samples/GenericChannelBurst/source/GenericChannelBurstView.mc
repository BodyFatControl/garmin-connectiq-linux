//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;

class GenericChannelBurstView extends Ui.View {

    hidden var _channelManager;

    //! Constructor.
    //! @param [BurstChannelManager] aChannelManager The channel manager in use
    function initialize(aChannelManager) {
        View.initialize();
        _channelManager = aChannelManager;
    }

    //! Loads resources
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));
        Ui.requestUpdate();
    }

    //! Updates the view
    //! @param [DisplayContext] dc The DisplayContext to use
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);

        // Print the burst statistics
        var burstStatistics = _channelManager.getBurstStatistics();
        Ui.View.findDrawableById("rxFail").setText(burstStatistics.rxFailCount.toString());
        Ui.View.findDrawableById("rxSuccess").setText(burstStatistics.rxSuccessCount.toString());
        Ui.View.findDrawableById("txFail").setText(burstStatistics.txFailCount.toString());
        Ui.View.findDrawableById("txSuccess").setText(burstStatistics.txSuccessCount.toString());
    }

}
