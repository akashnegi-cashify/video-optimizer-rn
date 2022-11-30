package `in`.cashify.androidtrc.module.inventory_manager.api.request

import `in`.cashify.androidtrc.common.api.BaseRequest
import `in`.reglobe.api.kotlin.request.APIRequest

class AssignedDeviceListRequest : APIRequest() {

    var pno:Int?   = null

    var ln:Int?   = null


    var br:String?   = null

    var fp :FacilityPart? =null



    class FacilityPart: BaseRequest(){
        var is_urgent = false
    }

    override fun isValid(Scenario: String?): Boolean {
        return true
    }
}