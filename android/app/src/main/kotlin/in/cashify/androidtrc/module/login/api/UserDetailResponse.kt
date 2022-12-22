package `in`.cashify.androidtrc.module.login.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

/**
 * Created by avaneesh on 07/02/18.
 * UserDetailResponse
 */

class UserDetailResponse() : BaseResponse() {

    @SerializedName("uid")
    var userId: String? = null
    @SerializedName("fname")
    var firstName: String? = null
    @SerializedName("ln")
    var lastName: String? = null
    @SerializedName("uname")
    var userName: String? = null
    @SerializedName("mn")
    var mobileNumber: String? = null
    @SerializedName("roles")
    var roles: List<String>? = null
    @SerializedName("clid")
    var clientId: String? = null
    @SerializedName("em")
    var emailId: String? = null


    override fun isValid(condition: String?, isStrict: Boolean): Boolean {
        return true
    }
}
