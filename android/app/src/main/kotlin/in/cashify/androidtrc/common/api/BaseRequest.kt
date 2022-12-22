package `in`.cashify.androidtrc.common.api

import `in`.reglobe.api.kotlin.request.APIRequest

open class BaseRequest : APIRequest() {
    override fun isValid(Scenario: String?): Boolean {

        return true
    }
}