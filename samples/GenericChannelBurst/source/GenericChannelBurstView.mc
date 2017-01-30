//
// Copyright 2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;

class GenericChannelBurstView extends Ui.View {

    hidden var mChannelManager;
    hidden var mRxFailCountLabel;
    hidden var mRxSuccessCountLabel;
    hidden var mTxFailCountLabel;
    hidden var mTxSuccessCountLabel;

    //! Constructor.
    //! @param [BurstChannelManager] aChannelManager The channel manager in use
    function initialize(aChannelManager) {
        View.initialize();
        mChannelManager = aChannelManager;
    }

    //! Loads resources
    function onLayout(dc) {
        setLayout(Rez.Layouts.MainLayout(dc));

        mRxFailCountLabel = Ui.View.findDrawableById("rxFail");
        mRxSuccessCountLabel = Ui.View.findDrawableById("rxSuccess");
        mTxFailCountLabel = Ui.View.findDrawableById("txFail");
        mTxSuccessCountLabel = Ui.View.findDrawableById("txSuccess");

        Ui.requestUpdate();
    }

    //! Updates the view
    //! @param [DisplayContext] dc The DisplayContext to use
    function onUpdate(dc) {

        // Print the burst statistics
        var burstStatistics = mChannelManager.getBurstStatistics();
        mRxFailCountLabel.setText(burstStatistics.rxFailCount.toString());
        mRxSuccessCountLabel.setText(burstStatistics.rxSuccessCount.toString());
        mTxFailCountLabel.setText(burstStatistics.txFailCount.toString());
        mTxSuccessCountLabel.setText(burstStatistics.txSuccessCount.toString());

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

}
