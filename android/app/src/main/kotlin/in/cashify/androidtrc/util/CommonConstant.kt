package `in`.cashify.androidtrc.util

open interface CommonConstant {

    companion object {

        val YES = 1
        val NO = 0
        val KEY_USER_NAME = "user_name_key"
        val KEY_USER_LOGGED_IN_TIME = "user_logged_in_time_key"
        val KEY_EMAIL_ID = "email_id_key"
        val KEY_SIGN_IN_TYPE = "sign_in_type_key"
        val KEY_IMAGE_URL = "image_url_key"
        val KEY_USER_MOBILE = "mobile"
        val USER_DETAIL_RESPONSE = "user_detail_response"
        val ENGINEER_STATUS_ALLOTED = "Alloted"
        val ENGINEER_STATUS_DELIVERY_PICKED = "Rider Delivery Picked"
        
        val ENGINEER_CONSUMED_PARTS = "consumed-parts"
        val ENGINEER_REQUESTED_PARTS = "requested-parts" //2
        val ENGINEER_ALLOWED_PARTS = "alloted-parts" //3
        val ENGINEER_RECEIVED_PARTS = "received-parts"

          val KEY_PART_INFO = "part_info"

        val Inventory_MANAGER_ENUM = "inventory-manager-enum"

        val AVAILABLE_STATUS_CODE = 12
        val NOT_AVAILABLE_STATUS_CODE = 13

        val REQUESTED_STATUS_CODE = 11

        val ALLOTED_STATUS_CODE = 22

        val CANCEL_STATUS_CODE = 66

        val RIDER_DELIVERY_PICKED_STATUS_CODE = 25


        val RIDER_ASSIGNED_STATUS_CODE = 24


        val RECEIVE_STATUS_CODE = 33


        enum class SELECT_IMAGE {
            TAKE_PHOTO,
            CHOOSE_FROM_GALLERY,
            NA
        }
    }
}