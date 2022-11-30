package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName


class EngineerListResponse : BaseResponse() {


    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("s")
    var s: Boolean? = null


    @SerializedName("dt")
    var data: Data? = null


    class Data : BaseResponse() {
        @SerializedName("dl")
        var dataList: ArrayList<DataList>? = null


        @SerializedName("tp")
        var totalPage: Int? = null


        @SerializedName("tr")
        var totalRecord: Int? = null
    }


    class DataList : BaseResponse() {
        @SerializedName("id")
        var id: Int? = null

        @SerializedName("n")
        val name: String? = null

        @SerializedName("lc")
        var location:String? = null


        @SerializedName("isUrgent")
        var isUrgent: Boolean = false
    }
}