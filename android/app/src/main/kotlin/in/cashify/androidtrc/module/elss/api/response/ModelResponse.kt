package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class ModelResponse() : BaseResponse(), Parcelable {
    @SerializedName("pid")
    var productId: Int?=null
    @SerializedName("pn")
    var productName: String? = null

    constructor(parcel: Parcel) : this() {
        productId = parcel.readValue(Int::class.java.classLoader) as? Int
        productName = parcel.readString()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeValue(productId)
        parcel.writeString(productName)
    }


    override fun toString(): String {
        return productName.toString()
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<ModelResponse> {
        override fun createFromParcel(parcel: Parcel): ModelResponse {
            return ModelResponse(parcel)
        }

        override fun newArray(size: Int): Array<ModelResponse?> {
            return arrayOfNulls(size)
        }
    }


}