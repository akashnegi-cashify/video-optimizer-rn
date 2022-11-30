package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class RoleData : BaseResponse() {

    @SerializedName("rln")
    lateinit var roleName: String
    @SerializedName("rlid")
    lateinit var roleId: String

}
