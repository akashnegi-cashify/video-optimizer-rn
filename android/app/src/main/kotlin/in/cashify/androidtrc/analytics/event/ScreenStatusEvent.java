package in.cashify.androidtrc.analytics.event;

import android.content.Context;
import android.text.TextUtils;

import androidx.annotation.NonNull;

import java.util.Map;

import in.cashify.androidtrc.analytics.helper.AnalyticsController;


public class ScreenStatusEvent extends BaseTrackingEvent {
    private AnalyticsController.AnalyticEventKey key;
    private String label;
    private Map<String, String> extras;

    public ScreenStatusEvent(@NonNull Context context, @NonNull AnalyticsController.AnalyticEventKey key, @NonNull AnalyticsController.AnalyticScreen screenName, AnalyticsController.AnalyticPopup popupName, String label, Map<String, String> extras) {
        super(context, screenName, popupName);
        this.key = key;
        this.label = label;
        this.extras = extras;
    }

    @NonNull
    @Override
    public AnalyticsController.AnalyticEventKey getKey() {
        return key;
    }

    @Override
    protected void putEvents(Map<String, Object> events) {
        super.putEvents(events);
        if (extras != null && !extras.isEmpty()) {
            events.putAll(extras);
        }
        events.put(TrackingEventKey.LABEL.getValue(), TextUtils.isEmpty(label) ? "" : label);
    }
}
