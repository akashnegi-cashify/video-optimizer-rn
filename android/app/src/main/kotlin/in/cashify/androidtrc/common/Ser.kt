package `in`.cashify.androidtrc.common

import com.google.gson.annotations.SerializedName

data class Ser(
    @SerializedName("key" ) var key : String? = null,
    @SerializedName("si"  ) var si  : String? = null,
    @SerializedName("is"  ) var isSecure  : Int?    = null
)
