package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class EngineerListResponse : BaseResponse() {


    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("s")
    var s: Boolean? = null


    @SerializedName("dt")
    var data: Data? = null


    @Keep
    class Data : BaseResponse() {
        @SerializedName("dl")
        var dataList: ArrayList<DataList>? = null


        @SerializedName("tp")
        var totalPage: Int? = null


        @SerializedName("tr")
        var totalRecord: Int? = null
    }

    override fun isValid(condition: String?, isStrict: Boolean): Boolean {
        return true
    }

    @Keep
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