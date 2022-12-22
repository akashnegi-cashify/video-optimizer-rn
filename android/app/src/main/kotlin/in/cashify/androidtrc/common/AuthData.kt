package `in`.cashify.androidtrc.common

import com.google.gson.annotations.SerializedName

data class AuthData(

    @SerializedName("access_token" ) var accessToken : String?        = null,
    @SerializedName("token_type"   ) var tokenType   : String?        = null,
    @SerializedName("ser"          ) var ser         : ArrayList<Ser> = arrayListOf(),
    @SerializedName("isp"          ) var isp         : Int?           = null,
    @SerializedName("expires_in"   ) var expiresIn   : Int?           = null

)
