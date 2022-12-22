package in.cashify.androidtrc.analytics.helper;

import android.content.Context;
import android.os.Bundle;
import android.os.Parcelable;

import androidx.annotation.NonNull;

import com.google.firebase.analytics.FirebaseAnalytics;

import java.io.Serializable;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import in.cashify.androidtrc.analytics.event.BaseTrackingEvent;


/**
 * Created by cashify.
 * AnalyticsController
 */


public class AnalyticsController {
    public enum AnalyticTracker {
        FIRE_BASE
    }

    public enum AnalyticEventKey {
        EVENT_ONCREATE("on_create"),

        EVENT_OPEN("open"),
        EVENT_CALL("call"),
        EVENT_CANCEL("cancel"),
        EVENT_CLICKED("clicked"),
        EVENT_ERROR("error"),
        EVENT_FAIL("fail"),
        EVENT_NEXT("next"),
        EVENT_REQUOTE("requote"),
        EVENT_SUBMIT("submit"),
        EVENT_COMPLETE("complete"),
        EVENT_LOGIN("login"),
        EVENT_SESSION_EXPIRED("session_expired"),
        EVENT_PUSH_CLICK("push_click"),
        EVENT_AVAILABLE("available"),
        EVENT_ACCEPT_DEAL("accept_deal"),
        EVENT_REACH_DOORSTEP("reached-doorstep"),
        EVENT_PROCEED_TO_COMPLETE("proceed-to-complete"),
        EVENT_LOGOUT("logout");
        private String value;
        AnalyticEventKey(String value) {
            this.value = value;
        }
        public String getValue() {
            return value;
        }
    }

    public enum AnalyticScreen {
        SCREEN_ELSS_CAPTURE_IMAGE("ElssCaptureImage"),
        SCREEN_ELSS_PART_SELECTION("Elss-part-selection"),
        SCREEN_ELSS_BARCODE("Elss-csan-barcode"),
        SCREEN_ENG_DEVICE_PART_ASSIGN("Eng-device-part-assign"),
        SCREEN_ENG_DEVICE_PART_SELF_ASSIGN("Eng-device-self-part-assign"),
        SCREEN_ENG_PART_SCANNER("Eng-part-scanner"),
        SCREEN_ENG_PART_VIEW("Eng-part-view"),
        SCREEN_ENG_PART_SCANNER_ALLOWED("Eng-part-scanner-allowed"),
        SCREEN_ENG_DEVICE_PART_INFO("Eng-device-part-info"),
        SCREEN_ENG_WIPE_PART("Eng-wipe-part"),
        SCREEN_ENG_WIPE_OPTION("Eng-wipe-option"),
        SCREEN_ENG_DEVICE_PART_LIST("Eng-device-part-list"),
        SCREEN_ENG_RECEIVE_DEVICE("Eng-receive-device"),
        SCREEN_ENG_RECEIVE_PART("Eng-receive-device-parts"),
        SCREEN_DEVICES_TAB("Eng-devices-tab"),
        SCREEN_ORDER_PART("Eng-order-part"),
        SCREEN_VIEW_REPORT("view-report"),
        SCREEN_INVENTORY_MANAGER("inventory-manager"),
        SCREEN_INVENTORY_MANAGER_SCANNER("inventory-manager-scanner"),
        SCREEN_INVENTORY_MANAGER_RETURN("inventory-manager-return"),
        SCREEN_INVENTORY_MANAGER_SUMMERY("inventory-manager-summery"),
        SCREEN_INVENTORY_REQUEST("inventory-request"),
        SCREEN_CHANGE_PASSWORD("chnage-password"),
        SCREEN_LOGIN("app-login"),
        SCREEN_SCAN_LOCATION("scan-location"),
        SCREEN_QC("quality-check"),
        SCREEN_QC_PART_SCAN("quality-check-part-scan"),
        SCREEN_QC_PENDING_PART_DETAILS("quality-check-pending-part-detail"),
        SCREEN_QC_PART_PENDING_PART_SCAN("quality-check-pending-pending-part-scan"),
        SCREEN_PENDING_PART_DEL_TO_ENG("rider-pending-part-del-to-eng"),
        SCREEN_PICKUP_PART_FROM_ENG_SCAN("rider-pickup-part-from-to-eng-scan"),
        SCREEN_PICKUP_PART_LIST("rider-pickup-part-list"),
        SCREEN_RIDER("rider-screen"),
        SCREEN_RUBBING("rubbing"),
        SCREEN_RUNNER_TRAY_SCAN("runner-tray-scan"),
        SCREEN_RUNNER_GIVEN_DEVICE("runner-given-device"),
        SCREEN_RUNNER_MARK_L4("runner-mark-l4"),
        SCREEN_RUNNER_MARK_OK("runner-mark-ok"),
        SCREEN_RUNNER_MOVE_TO_MARK_OK("runner-move-to-mark-ok"),
        SCREEN_RUNNER_PICK_MARK_OK("runner-pick-mark-ok"),
        SCREEN_RUNNER_TRAY_LIST("runner-tray-list"),
        SCREEN_HOME("home"),
        SCREEN_STORE_IN("store-in"),
        SCREEN_STORE_OUT("store-out"),
        SCREEN_IM_DEVICE_ASSIGN("im-device-assign"),
        SCREEN_IM_PENDING_PART("im-pending-part"),
        SCREEN_IM_RECEIVE_SCAN("im-receive-scan"),
        SCREEN_IM_PART_RETURN("im-part-return"),
        SCREEN_SPLASH("splash");


        private String value;

        AnalyticScreen(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }

    public enum AnalyticPopup {
        SHARE_DEAL("share_deal"),
        NONE(null),
        RESCHEDULE_POPUP("reshedule_popup"),
        CALL_FEEDBACK("call_feedback"),
        CREDIT_DETAIL("credit_detail"), DEAl_FAIL("deal_fail_reason"), DEAl_FAIL_MAX_PRICE("max_price_popup"), PAYMENT_CONFIRMATION("payment_confirmation"), CHANGE_TO_CASH_CONFIRMATION("change_to_cash_confirmation"), ADD_IMAGE_CONFIRMATION_POPUP("add_image_confirmation_popup");

        private String value;

        AnalyticPopup(String value) {
            this.value = value;
        }

        public String getValue() {
            return value;
        }
    }


    public static void init(Context context, AnalyticTracker[] trackers) {
        if (context == null) {
            return;
        }
        if (trackers == null || trackers.length < 1) {
            return;
        }
        for (AnalyticTracker tracker : trackers) {
            switch (tracker) {
                case FIRE_BASE:
                    FirebaseAnalytics.getInstance(context);
                    break;
            }
        }
    }


    static void logEvent(@NonNull Context context, @NonNull BaseTrackingEvent trackingEvent) {
        AnalyticTracker[] trackers = trackingEvent.getTrackers();
        Map<String, Object> arguments = trackingEvent.getArguments();
        for (AnalyticTracker tracker : trackers) {
            switch (tracker) {
                case FIRE_BASE: {
                    String event = trackingEvent.getKey().getValue();
                    if (event == null || event.isEmpty()) {
                        return;
                    }
                    event = getAnalyticKey(event);

                    if (arguments == null || arguments.isEmpty()) {
                        FirebaseAnalytics.getInstance(context).logEvent(event, null);
                    } else {
                        Map<String, Object> fbArguments = new HashMap<>(arguments);
                        Map<String, Object> params = updateArgumentKeys(fbArguments);
                        Bundle bundle = getBundleFromObjectsMap(params);
                        FirebaseAnalytics.getInstance(context).logEvent(event, bundle);
                    }
                }
                break;

            }
        }
    }


    private static Map<String, Object> updateArgumentKeys(Map<String, Object> arguments) {
        Map<String, Object> params = new HashMap<>();
        Set<String> paramKeys = arguments.keySet();
        for (String oldKey : paramKeys) {
            Object value = arguments.get(oldKey);
            String newKey = getAnalyticKey(oldKey);
            params.put(newKey, value);
        }
        return params;
    }

    private static String getAnalyticKey(String key) {
        return key.trim().replace(" ", "_");
    }

    private static Bundle getBundleFromObjectsMap(Map<String, Object> objectMap) {
        Bundle bundle = new Bundle();
        Set<String> strings = objectMap.keySet();
        for (String key : strings) {
            Object value = objectMap.get(key);
            if (value instanceof Integer) {
                bundle.putInt(key, (Integer) value);
                continue;
            } else if (value instanceof Float) {
                bundle.putFloat(key, (Float) value);
                continue;
            } else if (value instanceof Double) {
                bundle.putDouble(key, (Double) value);
                continue;
            } else if (value instanceof String) {
                bundle.putString(key, (String) value);
            }
            if (value instanceof Date) {
                bundle.putSerializable(key, (Serializable) value);
            } else if (value instanceof Parcelable) {
                bundle.putParcelable(key, (Parcelable) value);
            }
        }
        return bundle;
    }

    public static Bundle getBundle(Map<String, String> stringMap) {
        Bundle bundle = new Bundle();
        Set<String> strings = stringMap.keySet();
        for (String key : strings) {
            bundle.putString(key, stringMap.get(key));
        }
        System.out.print("Bundle " + bundle + "");
        return bundle;
    }

}

