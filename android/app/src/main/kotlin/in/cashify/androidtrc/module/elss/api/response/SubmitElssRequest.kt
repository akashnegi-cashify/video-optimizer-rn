package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseRequest
import `in`.reglobe.api.kotlin.request.APIRequest
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
@Keep
class SubmitElssRequest: BaseRequest() {
    @SerializedName("dbr")
    var deviceBarcode: String? = null
    @SerializedName("rt")
    var repairType: String? = null //( Accept for Warranty, Accept for Bulk, Accept, Decline)
    @SerializedName("rprl")
    var repairPartList: ArrayList<ElssPart>? = null
    @SerializedName("rm")
    var remark: String? = null

    @SerializedName("isra")
    var isRubbingApplicable: Boolean = false

    @SerializedName("isPna")
    var isPnaApplicable: Boolean = false

    @SerializedName("isGc")
    var isGcApplicable: Boolean = false

    @SerializedName("ac")
    var action: Int=0

}