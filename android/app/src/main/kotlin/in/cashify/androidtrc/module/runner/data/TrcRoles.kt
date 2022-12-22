package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class TrcRoles : BaseResponse() {
    @SerializedName("role")
    lateinit var rollList: ArrayList<RoleData>
}