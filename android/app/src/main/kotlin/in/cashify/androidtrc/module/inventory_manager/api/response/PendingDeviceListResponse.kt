package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class PendingDeviceListResponse : BaseResponse() {

    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: Data? = null


    @SerializedName("s")
    var success: Boolean? = null

    @Keep
    class Data : BaseResponse() {
        @SerializedName("dl")
        var dataList: List<DataList>? = null


        @SerializedName("tp")
        var totalPage: Int? = null


        @SerializedName("tr")
        var totalRecord: Int? = null


    }

    @Keep
    class DataList : BaseResponse() {

        @SerializedName("did")
        var did: Int? = null

        @SerializedName("pt")
        var pt: String? = null

        @SerializedName("dbr")
        var deviceBarcode: String? = null


        @SerializedName("tbr")
        var tbr: String? = null

        @SerializedName("pc")
        var partCount: Int? = null

        @SerializedName("tpc")
        var totalPartCount: Int? = null


        @SerializedName("en")
        var engineerName: String? = null


        @SerializedName("lc")
        var lc: String? = null


        @SerializedName("asAt")
        var assignedAt: Long = 0


        @SerializedName("isUrgent")
        var isUrgent: Boolean = false



        @SerializedName("rt")
        var repairType: String? = ""



        @SerializedName("gr")
        var grade: String? = ""


    }


}