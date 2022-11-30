package `in`.cashify.androidtrc.module.inventory_manager.api.request

import `in`.cashify.androidtrc.common.api.BaseRequest

class EngineerListRequest: BaseRequest() {

    var pno:Int?   = null

    var ln:Int?   = null

    var fp : FacilityPart? =null

    class FacilityPart:BaseRequest(){
        var is_urgent = false
        var location_group = ""
    }

    override fun isValid(Scenario: String?): Boolean {
        return true
    }
}