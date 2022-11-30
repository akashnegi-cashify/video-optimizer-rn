package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class EngineerPartList : BaseResponse() {
    @SerializedName("s")
    var isSuccess: Boolean? = null
    @SerializedName("dt")
    var partInfoList: ArrayList<EngineerPartInfo>? = null
}