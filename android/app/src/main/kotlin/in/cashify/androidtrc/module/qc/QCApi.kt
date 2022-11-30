package `in`.cashify.androidtrc.module.qc

import `in`.cashify.androidtrc.module.qc.data.request.SubmitQCRequest
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import `in`.cashify.androidtrc.module.qc.data.response.SubmitQCResponse
import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query

interface QCApi {


    @GET("/qc/parts/list")
    fun pendingList(
@Query("pbr")barcode:String
    ): Deferred<Response<QCPendingListResponse>>



    @POST("/qc/parts/submit-qc")
    fun submitQc(
@Body request: SubmitQCRequest


    ): Deferred<Response<SubmitQCResponse>>

}