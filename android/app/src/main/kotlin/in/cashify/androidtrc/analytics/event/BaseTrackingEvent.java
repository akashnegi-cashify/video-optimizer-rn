package in.cashify.androidtrc.analytics.event;


import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.text.TextUtils;

import androidx.annotation.CallSuper;
import androidx.annotation.NonNull;
import androidx.annotation.Size;


import java.util.HashMap;
import java.util.Map;

import in.cashify.androidtrc.analytics.helper.AnalyticsController;
import in.reglobe.cashify.util.DeviceInfoManager;


public abstract class BaseTrackingEvent {


    private Context mContext;
    private AnalyticsController.AnalyticScreen screenName;
    private AnalyticsController.AnalyticPopup popupName;

    public BaseTrackingEvent(@NonNull Context context, @NonNull AnalyticsController.AnalyticScreen screenName, AnalyticsController.AnalyticPopup popupName) {
        this.mContext = context;
        this.screenName = screenName;
        this.popupName = popupName;
    }


    @NonNull
    @Size(min = 1L, max = 32L)
    public abstract AnalyticsController.AnalyticEventKey getKey();

    @NonNull
    @Size(min = 1L)
    public AnalyticsController.AnalyticTracker[] getTrackers() {
        return new AnalyticsController.AnalyticTracker[]{
                AnalyticsController.AnalyticTracker.FIRE_BASE};
    }

    public String getBrand() {
        return Build.BRAND;
    }

    public String getModel() {
        return Build.MODEL;
    }

    public long getEventCurrentTime() {
        return System.currentTimeMillis();
    }


    public String getAppVersion() {
        try {
            PackageInfo pInfo = mContext.getPackageManager().getPackageInfo(mContext.getPackageName(), 0);
            return pInfo.versionName;
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }
        return "";
    }

    public String getOsVersion() {
        return String.valueOf("Android " + Build.VERSION.RELEASE);
    }


    public final Map<String, Object> getArguments() {
        Map<String, Object> events = new HashMap<>();
        events.put(TrackingEventKey.INSTALLED_DEVICE_BRAND.getValue(), getBrand());
        events.put(TrackingEventKey.INSTALLED_DEVICE_MODEL.getValue(), getBrand());
        events.put(TrackingEventKey.EVENT_DATE_TIME.getValue(), getEventCurrentTime());
        events.put(TrackingEventKey.APP_VERSION.getValue(), getAppVersion());
        events.put(TrackingEventKey.OS_VERSION.getValue(), getOsVersion());

        events.put(TrackingEventKey.DEVICE_ID.getValue(), DeviceInfoManager.getUniqueDeviceId(mContext));
        if (!TextUtils.isEmpty(getScreenName())) {
            events.put(TrackingEventKey.SCREEN_NAME.getValue(), getScreenName());
        }
        if (!TextUtils.isEmpty(getPopupName())) {
            events.put(TrackingEventKey.POPUP_NAME.getValue(), getScreenName());
        }

        putEvents(events);
        return events;
    }

    @CallSuper
    protected void putEvents(Map<String, Object> events) {

    }

    public String getScreenName() {
        return screenName == null ? "" : screenName.getValue();
    }

    public String getPopupName() {
        return popupName == null ? "" : popupName.getValue();
    }
}
