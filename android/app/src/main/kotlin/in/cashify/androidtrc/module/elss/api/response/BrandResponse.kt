package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class BrandResponse() : BaseResponse(), Parcelable {
    @SerializedName("bid")
    var id: Int? = null

    @SerializedName("bn")
    var name: String? = null

    constructor(parcel: Parcel) : this() {
        id = parcel.readValue(Int::class.java.classLoader) as? Int
        name = parcel.readString()
    }


    override fun toString(): String {
        return name.toString()
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeValue(id)
        parcel.writeString(name)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<BrandResponse> {
        override fun createFromParcel(parcel: Parcel): BrandResponse {
            return BrandResponse(parcel)
        }

        override fun newArray(size: Int): Array<BrandResponse?> {
            return arrayOfNulls(size)
        }
    }


}