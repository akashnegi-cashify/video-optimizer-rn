package `in`.cashify.androidtrc.module.engineer.api.response

import `in`.cashify.androidtrc.common.api.BaseResponse
import android.os.Parcel
import android.os.Parcelable
import com.google.gson.annotations.SerializedName


 class Dt() : BaseResponse(), Parcelable {

	@SerializedName("msg")
	val msg: String? = null

	@SerializedName("st")
 	val st: String? = null

	@SerializedName("pt")
 	val pt: String? = null

	@SerializedName("dbr")
 	val dbr: String? = null

	@SerializedName("did")
 	val did: Int? = null

	constructor(parcel: Parcel) : this() {
	}

	override fun writeToParcel(parcel: Parcel, flags: Int) {

	}

	override fun describeContents(): Int {
		return 0
	}

	companion object CREATOR : Parcelable.Creator<Dt> {
		override fun createFromParcel(parcel: Parcel): Dt {
			return Dt(parcel)
		}

		override fun newArray(size: Int): Array<Dt?> {
			return arrayOfNulls(size)
		}
	}


}