package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import `in`.cashify.androidtrc.module.elss.data.ElssAction
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
class ElssPart() : BaseResponse(), Parcelable {
    @SerializedName("sku")
    var partSku: String? = null
    @SerializedName("pn")
    var partName: String? = null
    @SerializedName("ac")
    var action: String? = null
    set(value) {
        if(value == ElssAction.REPAIRABLE.actionString)  {
            field = ElssAction.REPAIRABLE_SERVER.actionString
        }
        else {
            field = value
        }
    }//  {Repairable,Not Repairable,Not Required}
    @SerializedName("isManualAdded")
    var isManualAdded = false
    @SerializedName("pc")
    var partCount: Int? = null
    @SerializedName("pcl")
    var partColor: String? = null

    @SerializedName("isPnaSelected")
    var isPnaSelected: Boolean = false


    var selectedPos:Int = -1

    var isVisibleForPna:Boolean = false


    constructor(parcel: Parcel) : this() {
        partSku = parcel.readString()
        partName = parcel.readString()
        action = parcel.readString()
        isManualAdded = parcel.readByte() != 0.toByte()
        partCount = parcel.readValue(Int::class.java.classLoader) as? Int
        partColor = parcel.readString()
        selectedPos = parcel.readInt()

    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(partSku)
        parcel.writeString(partName)
        parcel.writeString(action)
        parcel.writeByte(if (isManualAdded) 1 else 0)
        parcel.writeValue(partCount)
        parcel.writeString(partColor)
        parcel.writeInt(selectedPos)

    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<ElssPart> {
        override fun createFromParcel(parcel: Parcel): ElssPart {
            return ElssPart(parcel)
        }

        override fun newArray(size: Int): Array<ElssPart?> {
            return arrayOfNulls(size)
        }
    }

}