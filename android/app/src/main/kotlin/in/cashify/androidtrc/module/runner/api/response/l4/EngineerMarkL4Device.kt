package `in`.cashify.androidtrc.module.runner.api.response.l4

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class EngineerMarkL4Device : BaseResponse() {

    @SerializedName("dt")
    var deviceMap: HashMap<String, Boolean>? = null
}