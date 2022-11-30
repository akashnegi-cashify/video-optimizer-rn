package `in`.cashify.androidtrc.module.elss.api.response

import `in`.reglobe.api.kotlin.request.APIRequest
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 25/11/20.
 */
class UploadImageRequest :APIRequest() {

@SerializedName("dbr")
var deviceBarcode:String? = null

    @SerializedName("imd")
    var imageDetailMap:HashMap<String, ArrayList<String>> = HashMap()



    override fun isValid(Scenario: String?): Boolean {
      return true
    }
}