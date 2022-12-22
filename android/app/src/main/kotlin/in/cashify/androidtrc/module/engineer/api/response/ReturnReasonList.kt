package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 31,Agosto,2019
 */
class ReturnReasonList() : BaseResponse(), Parcelable {
    @SerializedName("dt")
    var reasonList: ArrayList<String> = ArrayList()

    constructor(parcel: Parcel) : this() {

    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {

    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<ReturnReasonList> {
        override fun createFromParcel(parcel: Parcel): ReturnReasonList {
            return ReturnReasonList(parcel)
        }

        override fun newArray(size: Int): Array<ReturnReasonList?> {
            return arrayOfNulls(size)
        }
    }

}