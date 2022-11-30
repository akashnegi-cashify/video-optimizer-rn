package `in`.cashify.androidtrc.module.login.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import `in`.reglobe.api.kotlin.auth.AuthResponse
import com.google.gson.annotations.SerializedName

/**
 * Created by cashify on 1/24/18.
 * Copyright (c) 2018 Manak Waste Management Pvt. Ltd . All rights reserved.
 */
class OtpVerificationResponse : BaseResponse() {

    @SerializedName("access_token")
    var accessToken: String? = null

    @SerializedName("refresh_token")
    var refreshToken: String? = null

    @SerializedName("token_type")
    var tokenType: String? = null

    @SerializedName("ser")
    var serviceGroupList: Array<AuthResponse.ServiceGroup>? = null

    @SerializedName("expires_in")
    var expiryTime: Int = 0

    @SerializedName("isp")
    var isPublic: Int = 0

    override fun isValid(condition: String?, isStrict: Boolean): Boolean {
        return true
    }

}
