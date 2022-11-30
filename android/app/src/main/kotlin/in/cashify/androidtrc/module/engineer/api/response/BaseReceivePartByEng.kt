package `in`.cashify.androidtrc.module.engineer.api.response

import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 27,August,2019
 */
class BaseReceivePartByEng : EngBaseResponse() {
    @SerializedName("dt")
    var data: ReceivePartByEngineer? = null
}