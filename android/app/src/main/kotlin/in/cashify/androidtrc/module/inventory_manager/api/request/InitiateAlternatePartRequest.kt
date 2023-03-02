package `in`.cashify.androidtrc.module.inventory_manager.api.request

import `in`.reglobe.api.kotlin.request.APIRequest
import androidx.annotation.Keep

@Keep
class InitiateAlternatePartRequest: APIRequest() {

    var sku = ""
    var pn = ""
    var partId:Int? = null



    override fun isValid(Scenario: String?): Boolean {
      return true
    }
}