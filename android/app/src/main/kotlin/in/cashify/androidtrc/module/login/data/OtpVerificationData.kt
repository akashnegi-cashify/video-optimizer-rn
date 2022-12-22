package `in`.cashify.androidtrc.module.login.data

import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


/**
 * Created by Avaneesh Maurya on 19,July,2019
 */
class OtpVerificationData(
) : Parcelable {

    @SerializedName("otp")
    var otp: Int? = null
    @SerializedName("mn")
    var mobileNumber: String? = null
    @SerializedName("rid")
    var requestId: String? = null

    constructor(parcel: Parcel) : this() {
        otp = parcel.readValue(Int::class.java.classLoader) as? Int
        mobileNumber = parcel.readString()
        requestId = parcel.readString()
    }

    constructor(mobileNumber: String, requestId: String) : this() {
        this.mobileNumber = mobileNumber
        this.requestId = requestId
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeValue(otp)
        parcel.writeString(mobileNumber)
        parcel.writeString(requestId)
    }

    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<OtpVerificationData> {
        override fun createFromParcel(parcel: Parcel): OtpVerificationData {
            return OtpVerificationData(parcel)
        }

        override fun newArray(size: Int): Array<OtpVerificationData?> {
            return arrayOfNulls(size)
        }
    }

}