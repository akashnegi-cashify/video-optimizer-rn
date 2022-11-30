package `in`.cashify.androidtrc.module.elss.api

import `in`.cashify.androidtrc.module.elss.api.response.*
import `in`.cashify.androidtrc.module.engineer.api.response.MarkL4Response
import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
interface ElssApi {


    @GET("/elss/device-details")
    fun getElssDevice(
        @Query("dbr") barcode: String?
    ): Deferred<Response<ElssDeviceResponse>>

    @GET("/brand/list-all-brands")
    fun getBrandList(): Deferred<Response<BrandListResponse>>

    @GET("/product/list-all-products")
    fun getModels(@Query("bid") brandId: Int?): Deferred<Response<ModelListResponse>>


    @GET("/product/list-colors")
    fun getColorList(@Query("pid") productId: Int?): Deferred<Response<ColorListResponse>>


    @POST("/elss/submit-repair-part")
    fun submitElssPart(
        @Body elssRequest: SubmitElssRequest?
    ): Deferred<Response<SubmitElssResponse>>


    @GET("/elss/device/mark-l4")
    fun getMarkL4(
        @Query("dbr") barcode: String?
    ): Deferred<Response<MarkL4Response>>


    @POST("/device/submit-details")
    fun deviceSubmit(@Body request: DeviceSubmitRequest?): Deferred<Response<DeviceDetailSubmitResponse>>



    @GET("/s3/details")
    fun getS3Config(): Deferred<Response<S3ConfigResponse>>



    @POST("/part/upload-fault-images")
    fun uploadImages(@Body request:UploadImageRequest): Deferred<Response<UploadImageResponse>>

    @GET("/elss/actions")
    fun getElssDeviceActionOptions(
        @Query("dbr") barcode: String?
    ): Deferred<Response<ElssOptionResponse>>

}