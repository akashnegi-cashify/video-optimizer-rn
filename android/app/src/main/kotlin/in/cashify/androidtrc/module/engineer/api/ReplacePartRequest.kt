package `in`.cashify.androidtrc.module.engineer.api

import androidx.annotation.Keep
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 20/10/20.
 */

@Keep
class ReplacePartRequest {
    @SerializedName("pbr")
    var partBarcode:String? = null

    @SerializedName("pdbr")
    var previousDeviceBarCode:String? = null  // device on which to remove

    @SerializedName("ndbr")
    var newDeviceBarCode:String? = null // device on which to apply
}