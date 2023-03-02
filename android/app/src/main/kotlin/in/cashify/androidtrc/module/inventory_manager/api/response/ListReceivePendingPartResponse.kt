package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

@Keep
class ListReceivePendingPartResponse:BaseResponse() {
    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: ArrayList<Data>? = null

    @SerializedName("s")
    var success: Boolean? = null



    @Keep
    class Data() : BaseResponse(), Parcelable {

        @SerializedName("prid")
        var prid: Int? = null

        @SerializedName("sku")
        var sku: String? = null

        @SerializedName("pn")
        var partName: String? = null


        @SerializedName("pc")
        var partColor: String? = null


        @SerializedName("st")
        var status: String? = null


        @SerializedName("stc")
        var statusCode: Int? = null

        @SerializedName("rqty")
        var requestQuantity: Int? = null


        @SerializedName("pbr")
        var partBarcode: String? = null



        @SerializedName("isBulk")
        var isBulk: Boolean = false

        constructor(parcel: Parcel) : this() {
            prid = parcel.readValue(Int::class.java.classLoader) as? Int
            sku = parcel.readString()
            partName = parcel.readString()
            partColor = parcel.readString()
            status = parcel.readString()
            statusCode = parcel.readValue(Int::class.java.classLoader) as? Int
            requestQuantity = parcel.readValue(Int::class.java.classLoader) as? Int
            partBarcode = parcel.readString()
            isBulk = parcel.readByte() != 0.toByte()
        }

        override fun writeToParcel(parcel: Parcel, flags: Int) {
            parcel.writeValue(prid)
            parcel.writeString(sku)
            parcel.writeString(partName)
            parcel.writeString(partColor)
            parcel.writeString(status)
            parcel.writeValue(statusCode)
            parcel.writeValue(requestQuantity)
            parcel.writeString(partBarcode)
            parcel.writeByte(if (isBulk) 1 else 0)
        }

        override fun describeContents(): Int {
            return 0
        }

        companion object CREATOR : Parcelable.Creator<Data> {
            override fun createFromParcel(parcel: Parcel): Data {
                return Data(parcel)
            }

            override fun newArray(size: Int): Array<Data?> {
                return arrayOfNulls(size)
            }
        }
    }
}