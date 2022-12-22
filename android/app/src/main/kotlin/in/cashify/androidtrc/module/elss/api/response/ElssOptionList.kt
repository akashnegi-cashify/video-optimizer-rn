package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class ElssOptionList : BaseResponse() {

    @SerializedName("k")
    var key: Int? = null

    @SerializedName("v")
    var name: String? = null

    @SerializedName("isra")
    var isRubbingApplicable: Boolean = false

    @SerializedName("isPna")
    var isPnaApplicable: Boolean = false

    @SerializedName("isGc")
    var isGlassChangeApplicable: Boolean = false

    var isSelected: Boolean = false

    var isVisible: Boolean = true

    var isRAVisible: Boolean = false
    var isGCVisible: Boolean = false
    var isPNAVisible: Boolean = false


}