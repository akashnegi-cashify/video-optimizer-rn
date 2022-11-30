package `in`.cashify.androidtrc.module.inventory_manager.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

class ListReturnPartsResponse() : BaseResponse(), Parcelable {

    @SerializedName("r_id")
    var rid: String? = null


    @SerializedName("dt")
    var data: Data? = null

    @SerializedName("s")
    var success: Boolean? = null

    constructor(parcel: Parcel) : this() {
        rid = parcel.readString()
        success = parcel.readValue(Boolean::class.java.classLoader) as? Boolean

    }


    class PartListResponse() : BaseResponse(), Parcelable {


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


        @SerializedName("isDamaged")
        var isDamaged: Boolean = false


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
            isDamaged = parcel.readByte() != 0.toByte()
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
            parcel.writeByte(if (isDamaged) 1 else 0)
            parcel.writeByte(if (isBulk) 1 else 0)
        }


        override fun describeContents(): Int {
            return 0
        }

        companion object CREATOR : Parcelable.Creator<PartListResponse> {
            override fun createFromParcel(parcel: Parcel): PartListResponse {
                return PartListResponse(parcel)
            }

            override fun newArray(size: Int): Array<PartListResponse?> {
                return arrayOfNulls(size)
            }
        }


    }

    class Data() : BaseResponse(), Parcelable {
        @SerializedName("tr")
        var totalRecord: Int? = null


        @SerializedName("pl")
        var partList: ArrayList<PartListResponse>? = null



        @SerializedName("tp")
        var totalPage: Int? = 0

        constructor(parcel: Parcel) : this() {
            partList = parcel.createTypedArrayList(PartListResponse.CREATOR)

        }


        override fun describeContents(): Int {
            return 0
        }

        override fun writeToParcel(dest: Parcel?, flags: Int) {
            dest?.writeTypedList(partList)
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