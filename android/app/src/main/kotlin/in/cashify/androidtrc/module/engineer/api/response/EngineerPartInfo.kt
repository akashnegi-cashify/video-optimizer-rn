package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import `in`.cashify.androidtrc.util.CommonConstant
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class EngineerPartInfo() : BaseResponse(), Parcelable {
    @SerializedName("dbr")
    var deviceBarcode: String? = null
    @SerializedName("dna")
    var deviceName: String? = null
    @SerializedName("pn")
    var partName: String? = null
    @SerializedName("pbr")
    var partBarcode: String? = null
    @SerializedName("sku")
    var partSku: String? = null
    @SerializedName("st")
    var status: String? = null
    @SerializedName("pid")
    var partId: String? = null
    @SerializedName("isBulk")
    var isBulk: Boolean? = null
    @SerializedName("prid")
    var prid: Int? = null


    @SerializedName("stc")
    var statusCode: Int? = null

    constructor(parcel: Parcel) : this() {
        deviceBarcode = parcel.readString()
        deviceName = parcel.readString()
        partName = parcel.readString()
        partBarcode = parcel.readString()
        partSku = parcel.readString()
        status = parcel.readString()
        partId = parcel.readString()

     prid = parcel.readValue(Int::class.java.classLoader) as? Int


        isBulk = parcel.readValue(Boolean::class.java.classLoader) as Boolean?
        statusCode = parcel.readValue(Int::class.java.classLoader) as? Int
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(deviceBarcode)
        parcel.writeString(deviceName)
        parcel.writeString(partName)
        parcel.writeString(partBarcode)
        parcel.writeString(partSku)
        parcel.writeString(status)
        parcel.writeString(partId)
        parcel.writeValue(prid)
        parcel.writeValue(isBulk)
        parcel.writeValue(statusCode)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<EngineerPartInfo> {
        override fun createFromParcel(parcel: Parcel): EngineerPartInfo {
            return EngineerPartInfo(parcel)
        }

        override fun newArray(size: Int): Array<EngineerPartInfo?> {
            return arrayOfNulls(size)
        }
    }



    fun getPartStatus(): PartStatus {
        if(statusCode == CommonConstant.AVAILABLE_STATUS_CODE){
            return PartStatus.AVAILABBLE
        }
        else   if(statusCode == CommonConstant.NOT_AVAILABLE_STATUS_CODE){
            return PartStatus.NOT_AVAILABLE
        }


        else{
            return PartStatus.OTHER
        }

    }



}