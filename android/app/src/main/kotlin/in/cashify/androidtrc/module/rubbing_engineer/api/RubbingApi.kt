package `in`.cashify.androidtrc.module.rubbing_engineer.api

import `in`.cashify.androidtrc.module.elss.api.response.*
import `in`.cashify.androidtrc.module.engineer.api.response.MarkL4Response
import `in`.cashify.androidtrc.module.rubbing_engineer.api.request.RubbingDeviceListRequest
import `in`.cashify.androidtrc.module.rubbing_engineer.api.response.RubbingDeviceListResponse
import `in`.cashify.androidtrc.module.rubbing_engineer.api.response.RubbingDeviceReceiveResponse
import `in`.cashify.androidtrc.module.rubbing_engineer.api.response.RubbingDoneResponse
import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query


interface RubbingApi {

    @POST("/rubbing/device/done")
    fun doRubingActionTaken(@Query("dbr") barcode: String?,@Query("isrd") isRubbingDone: Boolean=true): Deferred<Response<RubbingDoneResponse>>


    @POST("/rubbing/device/scan")
    fun doReceiveRubingDevice(@Query("dbr") barcode: String?): Deferred<Response<RubbingDeviceReceiveResponse>>


    @POST("/rubbing/device/list")
    fun getRubbingDevices(@Body request: RubbingDeviceListRequest?): Deferred<Response<RubbingDeviceListResponse>>

}