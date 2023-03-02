package `in`.cashify.androidtrc.module.inventory_manager.api.request

import `in`.cashify.androidtrc.common.api.BaseRequest
import androidx.annotation.Keep

@Keep
class PendingDeliveryDevicePartRequest:BaseRequest() {


    var pno:Int?   = null

    var ln:Int?   = null


    var br:String?   = null
var fp :FacilityPart? =null



    @Keep
    class FacilityPart:BaseRequest(){
        var is_urgent = false
        var eid: Int? = null
    }

    override fun isValid(Scenario: String?): Boolean {
        return true
    }
}