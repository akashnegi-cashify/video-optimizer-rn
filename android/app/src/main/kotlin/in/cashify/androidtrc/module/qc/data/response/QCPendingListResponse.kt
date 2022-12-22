package `in`.cashify.androidtrc.module.qc.data.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

class QCPendingListResponse() :BaseResponse(), Parcelable {

    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: ArrayList<Data>? = null

    @SerializedName("s")
    var success: Boolean?= null

    constructor(parcel: Parcel) : this() {
        rid = parcel.readString()
        success = parcel.readValue(Boolean::class.java.classLoader) as? Boolean
        data =  parcel.createTypedArrayList(Data.CREATOR)
    }


    class Data() : BaseResponse(), Parcelable {

        @SerializedName("prid")
        var prid:Int? = null

        @SerializedName("sku")
        var sku:String? = null

        @SerializedName("pn")
        var partName:String? =null



        @SerializedName("pc")
        var partColor:String? =null



        @SerializedName("st")
        var status:String? =  null





        @SerializedName("stc")
        var statusCode:Int? = null

        @SerializedName("rqty")
        var requestQuantity:Int? = null



        @SerializedName("pbr")
        var partBarcode:String? = null



        @SerializedName("isDamaged")
        var isDamaged:Boolean = false

        constructor(parcel: Parcel) : this() {
            prid = parcel.readValue(Int::class.java.classLoader) as? Int
            sku = parcel.readString()
            partName = parcel.readString()
            partColor = parcel.readString()
            status = parcel.readString()
            statusCode = parcel.readValue(Int::class.java.classLoader) as? Int
            requestQuantity = parcel.readValue(Int::class.java.classLoader) as? Int
            partBarcode = parcel.readString()
            isDamaged = parcel.readByte() != 0.toByte()
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
            parcel.writeByte(if (isDamaged) 1 else 0)
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

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(rid)
        parcel.writeValue(success)
        parcel.writeTypedList(data)

    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<QCPendingListResponse> {
        override fun createFromParcel(parcel: Parcel): QCPendingListResponse {
            return QCPendingListResponse(parcel)
        }

        override fun newArray(size: Int): Array<QCPendingListResponse?> {
            return arrayOfNulls(size)
        }
    }


}