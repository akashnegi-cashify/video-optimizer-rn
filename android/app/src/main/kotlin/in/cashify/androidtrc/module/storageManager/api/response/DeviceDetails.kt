package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class DeviceDetails
	(
	@SerializedName("msg")
	val msg: String?,

	@SerializedName("tbr")
	val tbr: String?,

	@SerializedName("pt")
	val pt: String?,

	@SerializedName("dbr")
	val dbr: String?


) : BaseResponse(), Parcelable {
	constructor(source: Parcel) : this(
		source.readString(),
		source.readString(),
		source.readString(),
		source.readString()
	)

	override fun describeContents() = 0

	override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
		writeString(msg)
		writeString(tbr)
		writeString(pt)
		writeString(dbr)
	}

	companion object {
		@JvmField
		val CREATOR: Parcelable.Creator<DeviceDetails> =
			object : Parcelable.Creator<DeviceDetails> {
				override fun createFromParcel(source: Parcel): DeviceDetails =
					DeviceDetails(source)

				override fun newArray(size: Int): Array<DeviceDetails?> = arrayOfNulls(size)
			}
	}
}