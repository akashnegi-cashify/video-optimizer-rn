package `in`.cashify.androidtrc.module.elss.api

import `in`.cashify.androidtrc.module.elss.api.response.ElssDeviceResponse
import `in`.cashify.androidtrc.module.elss.api.response.SubmitElssRequest
import `in`.cashify.androidtrc.module.elss.api.response.SubmitElssResponse
import `in`.cashify.androidtrc.module.engineer.api.response.DeviceStorageDetailResponse
import `in`.cashify.androidtrc.module.engineer.api.response.FetchStorageDetailsResponse
import `in`.cashify.androidtrc.module.engineer.api.response.MarkL4Response
import `in`.cashify.androidtrc.module.storageManager.api.response.VirtualStoreResponse
import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST
import retrofit2.http.Query


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
interface StorageMangerAPi
{

    @GET("/storage/details")
    fun getDeviceStorage(
        @Query("tbr") barcode: String?
    ): Deferred<Response<FetchStorageDetailsResponse>>



    @GET("/storage/store-in")
    fun saveStoreinDevice(
        @Query("tbr") barcode: String?,
        @Query("dbr") dbr: String?
    ): Deferred<Response<FetchStorageDetailsResponse>>

    //GET /api/elss/device/?dbr=BAR3

     @GET("/device/details")
    fun getDeviceDetails(
         @Query("dbr") dbr: String?
    ): Deferred<Response<DeviceStorageDetailResponse>>


    @GET("/storage/store-out")
    fun saveStoreOutDevice(
        @Query("tbr") barcode: String?,
        @Query("dbr") dbr: String?
    ): Deferred<Response<FetchStorageDetailsResponse>>


    @GET("/storage/virtual-store-in")
    fun getVirtualStoreIn(
        @Query("dbr") dbr: String?
    ): Deferred<Response<VirtualStoreResponse>>


    @GET("/storage/virtual-store-out")
    fun getVirtualStoreOut(
         @Query("dbr") dbr: String?
    ): Deferred<Response<VirtualStoreResponse>>



}