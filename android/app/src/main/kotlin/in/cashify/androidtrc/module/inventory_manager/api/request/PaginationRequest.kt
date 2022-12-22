package `in`.cashify.androidtrc.module.inventory_manager.api.request

import `in`.reglobe.api.kotlin.request.APIRequest

class PaginationRequest:APIRequest() {

    var pno:Int?   = null

    var ln:Int?   = null


    var br:String?   = null



    override fun isValid(Scenario: String?): Boolean {
     return true
    }
}