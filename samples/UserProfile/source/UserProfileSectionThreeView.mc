//
// Copyright 2015-2016 by Garmin Ltd. or its subsidiaries.
// Subject to Garmin SDK License Agreement and Wearables
// Application Developer Agreement.
//

using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.UserProfile as UserProfile;

class UserProfileSectionThreeView extends Ui.View {

    var mLowActivityStr = null;
    var mMedActivityStr = null;
    var mHighActivityStr = null;
    var mBirthYearPrefixStr = null;

    function initialize() {
        View.initialize();

        mLowActivityStr = Ui.loadResource(Rez.Strings.LowActivityLevel);
        mMedActivityStr = Ui.loadResource(Rez.Strings.MediumActivityLevel);
        mHighActivityStr = Ui.loadResource(Rez.Strings.HighActivityLevel);
        mBirthYearPrefixStr = Ui.loadResource(Rez.Strings.BirthYearPrefix);
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.SectionThreeLayout(dc));
    }

    function onUpdate(dc) {
        var profile = UserProfile.getProfile();

        if (profile != null) {
           var string = null;
           if (profile.activityClass <= 20) {
                string = mLowActivityStr + " (" + profile.activityClass.toString() + ")";
            }
            else if (profile.activityClass <= 50) {
                string = mMedActivityStr + " (" + profile.activityClass.toString() + ")";
            }
            else {
                string = mHighActivityStr + " (" + profile.activityClass.toString() + ")";
            }
            findDrawableById("ActivityLevelLabel").setText(string);

            string = mBirthYearPrefixStr + profile.birthYear.toString();
            findDrawableById("BirthYearLabel").setText(string);
        }

        View.onUpdate(dc);
    }
}