package `in`.cashify.androidtrc.module.engineer.api

import `in`.cashify.androidtrc.module.elss.api.response.S3ConfigResponse
import `in`.cashify.androidtrc.module.engineer.api.response.*
import `in`.cashify.androidtrc.module.engineer.view_report.api.EngineerDeviceReportReponse
import `in`.cashify.androidtrc.module.engineer.view_report.api.EngineerPartReportResponse
import `in`.cashify.androidtrc.module.engineer.view_report.api.LeadEngineerDeviceReportResponse
import `in`.cashify.androidtrc.module.engineer.view_report.api.LeadEngineerPartReportResponse
import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.*


/**
 * Created by Avaneesh Maurya on 26,July,2019
 */
interface EngineerApi {

    @GET("/engineer/list-all-devices")
    fun getEngineerDeviceList(
    ): Deferred<Response<EngineerDeviceList>>

    @GET("/engineer/list-wip-devices")
    fun getEngineerWipDeviceList(
    ): Deferred<Response<EngineerDeviceList>>

    @GET("/engineer/receive-device")
    fun receiveDevice(
        @Query("dbr") deviceBarcode: String?
    ): Deferred<Response<BaseUpdateDeviceInfo>>

    @GET("/engineer/receive-part")
    fun receivePartByEngineer(
        @Query("pbr") partBarcode: String?
    ): Deferred<Response<BaseReceivePartByEng>>


    @GET("/engineer/device/mark-inprogress")
    fun sendToInProgress(
        @Query("dbr") deviceBarcode: String?
    ): Deferred<Response<SendToInProgress>>

    @GET("/engineer/{TYPE}")
    fun getEngineerParts(
        @Path(value = "TYPE", encoded = true) type: String
    ): Deferred<Response<EngineerPartList>>

    @GET("/engineer/device/{STATUS}")
    fun changeDeviceStatus(
        @Path(value = "STATUS", encoded = true) type: String?,
        @Query("dbr") deviceBarcode: String?
    ): Deferred<Response<ChangeDeviceStatusResponse>>

    @GET("/part/list-device-parts")
    fun listDeviceParts(
        @Query("dbr") deviceBarcode: String?
    ): Deferred<Response<DevicePartList>>

//    @GET("/engineer/get-device-parts")
//    fun listEngDeviceParts(
//        @Query("dbr") deviceBarcode: String?
//    ): Deferred<Response<DevicePartList>>


    @POST("part/request-device-parts")
    fun orderDeviceParts(
        @Query("dbr") deviceBarcode: String?,
        @Body devicePartList: ArrayList<DevicePartInfo>?
    ): Deferred<Response<OrderDevicePartResponse>>


    @GET("/engineer/consume-part")
    fun consumePart(
            @Query("pbr") deviceBarcode: String?,
            @Query("pid") partId: String?,
            @Query("prid") prid: String?,
            @Query("imgUrl") imageUrl: String?
    ): Deferred<Response<ConsumePartResponse>>

    @GET("/engineer/list-return-reasons")
    fun listReasons(
    ): Deferred<Response<ReturnReasonList>>

    @POST("/engineer/return-part")
    fun returnPart(
        @Body returnPartData: ReturnPartData?
    ): Deferred<Response<ReturnPartResponse>>

    @GET("/engineer/device/mark-repair-done")
    fun markRepairDone(
        @Query("dbr") deviceBarcode: String?
    ): Deferred<Response<ChangeDeviceStatusResponse>>

    @GET("/engineer/receive-part")
    fun getReceivePartByEngineer(
            @Query("pid") partId: String?,
            @Query("pbr") partBarcode: String?,
            @Query("prid") prid: String?
    ): Deferred<Response<ReceivedPartResponse>>



    @POST("/engineer/cancel-part-request")
    fun cancelPart(
        @Query("prid") prid: String?
    ): Deferred<Response<CancelPartResponse>>



    @POST("/engineer/replace-part")
    fun replacePart(
        @Body request:ReplacePartRequest
    ): Deferred<Response<ReplacePartResponse>>



    @GET("/report/engineer/device")
    fun engineerDeviceReport(
        @Query("sd") startDate: String,
        @Query("ed") endDate: String
    ): Deferred<Response<EngineerDeviceReportReponse>>



    @GET("/report/lead/engineer/device")
    fun leadEngineerDeviceReport(

    ): Deferred<Response<LeadEngineerDeviceReportResponse>>

    @GET("/report/engineer/part")
    fun engineerPartReport(
        @Query("sd") startDate: String,
        @Query("ed") endDate: String
    ): Deferred<Response<EngineerPartReportResponse>>

    @GET("/report/lead/engineer/part")
    fun leadEngineerPartReport(

    ): Deferred<Response<LeadEngineerPartReportResponse>>




    @GET("/engineer/list-assigned-part-request")
    fun getEngineerDeviceParts(
        @Query("dId") deviceId: String
    ): Deferred<Response<EngineerPartList>>



    @GET("/engineer/device/list-return-reasons")
    fun listDeviceReturnReasons(

    ): Deferred<Response<SendToTLReasonResponse>>



    @GET("/engineer/device/mark-tl")
    fun markTL(
        @Query("dbr") deviceBarcode: String,
        @Query("rc") returnReasonCode: String
    ): Deferred<Response<SendToTLResponse>>



    @GET("/s3/details")
    fun getS3Config(): Deferred<Response<S3ConfigResponse>>

}