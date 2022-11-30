package in.cashify.androidtrc.analytics.event;

public enum TrackingEventKey {

    INSTALLED_DEVICE_BRAND("installed_device_brand"),
    INSTALLED_DEVICE_MODEL("installed_device_model"),
    EVENT_DATE_TIME("event_date_time"),
    APP_VERSION("app_version"),
    OS_VERSION("os_version"),
    SCREEN_NAME("screen_name"), LABEL("label"), ROLE("role"), POPUP_NAME("popup_name"), DEVICE_ID("device_id");
    private String value;

    TrackingEventKey(String value) {
        this.value = value;
    }

    public String getValue() {
        return value;
    }
}
