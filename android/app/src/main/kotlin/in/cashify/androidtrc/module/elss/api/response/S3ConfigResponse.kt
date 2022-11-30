package `in`.cashify.androidtrc.module.elss.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 24/11/20.
 */
class S3ConfigResponse() : BaseResponse(), Parcelable {

    @SerializedName("r_id")
    var rid:String? = null


    @SerializedName("dt")
    var data:Data? = null


    @SerializedName("success")
    var success:Boolean = false

    constructor(parcel: Parcel) : this() {
        rid = parcel.readString()
        data =
            parcel.readParcelable(Data::class.java.classLoader)
        success = parcel.readByte() != 0.toByte()
    }


    class Data() :Parcelable,BaseResponse() {
    @SerializedName("url")
    var url:String? = null

    @SerializedName("ak")
    var accessKey:String? = null

    @SerializedName("sk")
    var secretKey:String? = null


    @SerializedName("bn")
    var bucketName:String? = null

    @SerializedName("fn")
    var folderName:String? = null

        constructor(parcel: Parcel) : this() {
            url = parcel.readString()
            accessKey = parcel.readString()
            secretKey = parcel.readString()
            bucketName = parcel.readString()
            folderName = parcel.readString()
        }

        override fun writeToParcel(parcel: Parcel, flags: Int) {
            parcel.writeString(url)
            parcel.writeString(accessKey)
            parcel.writeString(secretKey)
            parcel.writeString(bucketName)
            parcel.writeString(folderName)
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



    override fun describeContents(): Int {
        return 0
    }

    companion object CREATOR : Parcelable.Creator<S3ConfigResponse> {
        override fun createFromParcel(parcel: Parcel): S3ConfigResponse {
            return S3ConfigResponse(parcel)
        }

        override fun newArray(size: Int): Array<S3ConfigResponse?> {
            return arrayOfNulls(size)
        }
    }

    override fun writeToParcel(parcel: Parcel, flags: Int) {
        parcel.writeString(rid)
        parcel.writeParcelable(data, flags)
        parcel.writeByte(if (success) 1 else 0)
    }


}