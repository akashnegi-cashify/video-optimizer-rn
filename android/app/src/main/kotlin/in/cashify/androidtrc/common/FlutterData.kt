package `in`.cashify.androidtrc.common

import com.google.gson.annotations.SerializedName

data class FlutterData(
    @SerializedName("token"    ) var token    : String?   = null,
    @SerializedName("authData" ) var authData : AuthData? = AuthData()
)
