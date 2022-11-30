package `in`.cashify.androidtrc.module.login.api

import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 21,January,2020
 */
@Keep
class ChangePasswordRequest {

    @SerializedName("op")
    var oldPassword: String? = null
    @SerializedName("np")
    var newPassword: String? = null
    @SerializedName("cp")
    var confirmPassword: String? = null

}
