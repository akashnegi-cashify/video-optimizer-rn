package `in`.cashify.androidtrc.module.inventory_manager.api

import `in`.cashify.androidtrc.module.inventory_manager.api.request.*
import `in`.cashify.androidtrc.module.inventory_manager.api.response.*
import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.*

interface InventoryManagerApi {



    @POST("/inventory/list-pending-delivery-device-parts")
    fun getPendingDeviceList(

        @Body req: PendingDeliveryDevicePartRequest

    ): Deferred<Response<PendingDeviceListResponse>>




    @GET("/device/detail")
    fun getPendingDeviceDetails(

        @Query("did") did:String?

    ): Deferred<Response<PendingDeviceDetailResponse>>




    @GET("/device/list-pending-part-request")
    fun getPendingPartList(

        @Query("did") did:String?

    ): Deferred<Response<PendingPartListResponse>>





    @GET("/part/details")
    fun getPendingPartDetails(

        @Query("prid") prid:String?

    ): Deferred<Response<PendingPartDetailsResponse>>





    @GET("/part/sync-part-request")
    fun syncPendingPartRequest(

        @Query("prid") prid:String?

    ): Deferred<Response<PendingPartDetailsResponse>>





    @GET("/part/link-part-barcode")
    fun linkPendingPartBarcode(

        @Query("prid") prid:String?,
        @Query("pbr") pbr:String?

    ): Deferred<Response<PendingPartLinkResponse>>



    @GET("/part/unlink-part-barcode")
    fun unlinkPendingPartBarcode(

        @Query("prid") prid:String?,


    ): Deferred<Response<PendingPartUnLinkResponse>>




    @GET("/part/link-dead-part")
    fun linkDeadPart(

        @Query("prid") prid:String?,


        ): Deferred<Response<LinkDeadPartResponse>>





    @GET("/part/list-alternate-parts")
    fun listAlternateParts(

        @Query("prid") prid:String?,


        ): Deferred<Response<ListAlternatePartResponse>>



    @POST("/part/init-alternate-part-request")
    fun initiateAlternatePartRequest(

        @Query("did") did:String?,
        @Body request: InitiateAlternatePartRequest


        ): Deferred<Response<InitiateAlternatePartResponse>>




    @GET("/part/cancel-part-request")
    fun cancelPartRequest(

        @Query("prid") prid:String?,


        ): Deferred<Response<`in`.cashify.androidtrc.module.inventory_manager.api.response.CancelPartResponse>>





    @GET("/part/part-available-quantity")
    fun getAvailableQuantity(

        @Query("prid") prid:String?,


        ): Deferred<Response<AvailableQuantityResponse>>




    @POST("/inventory/list-assignment-pending-devices")
    fun getassignedPendingDevices(

        @Body req: AssignedDeviceListRequest

    ): Deferred<Response<AssignedDeviceListResponse>>



    @GET("/rider/list")
    fun getListOfRiders(

@Query ("br") br:String

    ): Deferred<Response<RiderListResponse>>



    @POST("/rider/assign")
    fun assignRider(

@Body request: RiderAssignRequest

    ): Deferred<Response<RiderAssignResponse>>


    @GET("/device/list-alloted-part-request")
    fun getAssignedPartList(

        @Query("did") did:String?

    ): Deferred<Response<PendingPartListResponse>>




    @POST("/inventory/list-returned-parts")
    fun listReturnedParts(

        @Body req: PaginationRequest

    ): Deferred<Response<ListReturnPartsResponse>>




    @GET("/inventory/receive-pending-parts")
    fun receivedPendingParts(

        @Query("pbr") partBarcode: String

    ): Deferred<Response<ListReceivePendingPartResponse>>





    @PUT("/inventory/update-return-part")
    fun returnPart(

        @Query("prid") prid: String,
        @Query("isFault") isFault: Boolean

    ): Deferred<Response<UpdateReturnPartResponse>>


    @PUT("/inventory/receive-part")
    fun receivePart(

        @Query("prid") prid: String,

    ): Deferred<Response<UpdateReceivePartResponse>>




    @GET("/part/part-summary")
    fun partSummary(



        ): Deferred<Response<PartSummaryResponse>>




    @GET("/inventory/return-receive-count")
    fun returnReceiveCount(



        ): Deferred<Response<ReturnReceiveCountResponse>>




    @GET("/location/group-list")
    fun groupList(



    ): Deferred<Response<GroupListResponse>>



    @POST("/inventory/assignment-pending/engineer/list")
    fun engineerList(@Body request: EngineerListRequest): Deferred<Response<EngineerListResponse>>


    @GET("/part/recommended")
    fun doRecommendedPartAPiCall(@Query("prid") prid:Int?): Deferred<Response<RecommendedPartResponse>>

}