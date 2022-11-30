package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 31,Agosto,2019
 */
class ConsumePartResponse : BaseResponse() {

    @SerializedName("s")
    var isSucess: Boolean = true
    @SerializedName("em")
    var errorMsg: String? = null

}