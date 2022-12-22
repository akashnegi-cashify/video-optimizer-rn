package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


class StorageDetails(
	@SerializedName("id")
	val id: String?,
	@SerializedName("barcode")
	val barcode: String?,
	@SerializedName("allowCapacity")
	val allowCapacity: Int?,
	@SerializedName("capacity")
	val capacity: Int?
) : BaseResponse(), Parcelable {
	constructor(source: Parcel) : this(
		source.readString(),
		source.readString(),
		source.readValue(Int::class.java.classLoader) as Int?,
		source.readValue(Int::class.java.classLoader) as Int?
	)


	override fun describeContents() = 0

	override fun writeToParcel(dest: Parcel, flags: Int) = with(dest) {
		writeString(id)
		writeString(barcode)
		writeValue(allowCapacity)
		writeValue(capacity)
	}

	companion object {
		@JvmField
		val CREATOR: Parcelable.Creator<StorageDetails> =
			object : Parcelable.Creator<StorageDetails> {
				override fun createFromParcel(source: Parcel): StorageDetails =
					StorageDetails(source)

				override fun newArray(size: Int): Array<StorageDetails?> = arrayOfNulls(size)
			}
	}
}