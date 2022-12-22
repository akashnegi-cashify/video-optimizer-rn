package `in`.cashify.androidtrc.module.qc.data.request

import `in`.cashify.androidtrc.common.api.BaseRequest

class SubmitQCRequest : BaseRequest() {


    var prid: Int? = null
    var isFault: Boolean? = null
}