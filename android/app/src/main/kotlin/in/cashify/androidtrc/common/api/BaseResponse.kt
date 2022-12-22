package `in`.cashify.androidtrc.common.api

import `in`.reglobe.api.kotlin.response.APIResponse

open class BaseResponse : APIResponse() {
    companion object {
        val VIEW_TYPE_NORMAL = 1
        val VIEW_TYPE_LOADING = 2
        val VIEW_TYPE_SPECIAL_OFFER = 3
        val RESPONSE_OK = 1
        val RESPONSE_FAIL = 0

        val STATUS_HOLD = "Hold"
    }
}