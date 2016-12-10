//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class PrimatesDelegate extends Ui.BehaviorDelegate {
    var index = 0;

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onNextPage() {
        index = (index + 1) % 3;
        var view = new PrimatesView();
        view.setIndex(index);
        var delegate = new PrimatesDelegate();
        delegate.setIndex(index);
        Ui.switchToView(view, delegate, Ui.SLIDE_LEFT);

        return true;
    }

    function onPreviousPage() {
        index = index - 1;
        if (index < 0) {
            index = 2;
        }
        index = index % 3;
        var view = new PrimatesView();
        view.setIndex(index);
        var delegate = new PrimatesDelegate();
        delegate.setIndex(index);
        Ui.switchToView(view, delegate, Ui.SLIDE_RIGHT);

        return true;
    }

    function setIndex(newIndex) {
        index = newIndex;
    }

    function onSelect() {
        if (index == 0) {
            Ui.pushView(new ApesView(), new DetailsDelegate(), Ui.SLIDE_UP);
        } else if (index == 1) {
            Ui.pushView(new MonkeysView(), new DetailsDelegate(), Ui.SLIDE_UP);
        } else if (index == 2) {
            Ui.pushView(new ProsimiansView(), new DetailsDelegate(), Ui.SLIDE_UP);
        }

        return true;
    }
}
