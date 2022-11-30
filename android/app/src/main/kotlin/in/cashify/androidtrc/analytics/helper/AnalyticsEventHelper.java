package in.cashify.androidtrc.analytics.helper;

import android.content.Context;
import android.os.Build;

import androidx.annotation.NonNull;


import java.util.HashMap;
import java.util.Map;

import in.cashify.androidtrc.analytics.event.BaseTrackingEvent;
import in.cashify.androidtrc.analytics.event.ScreenStatusEvent;


/**
 * Created by Cashify
 * AnalyticsEventHelper
 */
public class AnalyticsEventHelper {

    public static void fireScreenEvent(@NonNull Context context, AnalyticsController.AnalyticEventKey eventKey, AnalyticsController.AnalyticScreen screenName, AnalyticsController.AnalyticPopup popupName, String label) {
        fireScreenEvent(context, eventKey, screenName, popupName, label, null);
    }

    public static void fireScreenEvent(@NonNull Context context, AnalyticsController.AnalyticEventKey eventKey, AnalyticsController.AnalyticScreen screenName, AnalyticsController.AnalyticPopup popupName, String label, Map<String, String> extra) {
        BaseTrackingEvent trackingEvent = new ScreenStatusEvent(context, eventKey, screenName, popupName, label, extra);
        AnalyticsController.logEvent(context, trackingEvent);
    }



    public static void fireScreenEvent(@NonNull Context context, AnalyticsController.AnalyticEventKey eventKey, AnalyticsController.AnalyticScreen screenName, AnalyticsController.AnalyticPopup popupName, String label,boolean extraData) {
        Map<String, String> extra = new HashMap<>();
        extra.put("Android", "manufacturer :" + Build.MANUFACTURER + " model : " + Build.MODEL + " version : " + Build.VERSION.SDK_INT + " versionRelease : " + Build.VERSION.RELEASE);
        BaseTrackingEvent trackingEvent = new ScreenStatusEvent(context, eventKey, screenName, popupName, label, extra);
        AnalyticsController.logEvent(context, trackingEvent);
    }



}

