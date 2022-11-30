package `in`.cashify.androidtrc.module.rider.api

import `in`.cashify.androidtrc.module.rider.data.request.ListReceivePartsFromIMRequest
import `in`.cashify.androidtrc.module.rider.data.response.*
import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.*

interface RiderApi {



    @POST("/rider/delivery/pickup/pending")
    fun listReceivePartsFromIM(
        @Body req: ListReceivePartsFromIMRequest
    ): Deferred<Response<IMPartListResponse>>



    // deliver part to engineers by riders
    @GET("/rider/delivery/pending/received/engineer-list")
    fun deliverEngineersList(

        @Query("isUrgent")isUrgent:Boolean

    ): Deferred<Response<DeliverEngineerListResponse>>



    @GET("/rider/delivery/pending/received/parts")
    fun listEngineerParts(
@Query("eId") engId:Int?

    ): Deferred<Response<RiderDeliverPendingReceivePartResponse>>




    @PUT("/rider/delivery/receive-part")
    fun receiveParts(
        @Query("prid") partId:Int?

    ): Deferred<Response<IMPartsResponse>>









//engineer’s list will be shown for the parts that are marked as returned by engineer , rider has to pick them
    @GET("/rider/return/pending/engineer-list")
    fun listEngineersToPickUp(

    ): Deferred<Response<ReceiveEngineerListResponse>>




    @GET("/rider/return/pending/parts")
    fun listEngineerPartsPickByRider(
        @Query("eId") id:Int?

    ): Deferred<Response<RiderDeliverPendingReceivePartResponse>>



    @PUT("/rider/return/receive-part")
    fun recievePartFromEngineer(
        @Query("prid") prid:Int?,
        @Query("pbr") pbr:String?

    ): Deferred<Response<RecievePartFromEngineerResponse>>





// parts that are pickjed up by rider from engineers is shown in deliver section , this parts has to be deliver to inventory manager
    @POST("/rider/return/picked")
    fun listDeliverPartToIM(
    @Body req: ListReceivePartsFromIMRequest

    ): Deferred<Response<IMPartListResponse>>

}