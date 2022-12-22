package `in`.cashify.androidtrc.module.rider.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.rider.api.RiderApi
import `in`.cashify.androidtrc.module.rider.data.response.RecievePartFromEngineerResponse
import `in`.cashify.androidtrc.module.rider.data.response.RiderDeliverPendingReceivePartResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class PickupPartListActivityViewmodel @Inject constructor():BaseViewModel() {
    var pickupEngineerPartsResponse = MutableLiveData<RiderDeliverPendingReceivePartResponse>()

    fun pickUpEngineerParts(eid:Int? ) {
//        pickupEngineerPartsResponse.value  =    Gson().fromJson<RiderDeliverPendingReceivePartResponse>( "{\n" +
//                "    \"r_id\": \"7046c283-2172-4ec1-b5b2-6841033855c3\",\n" +
//                "    \"dt\": [\n" +
//                "        {\n" +
//                "            \"sku\": \"crg\",\n" +
//                "            \"pn\": \"Charging Jack\",\n" +
//                "            \"pbr\": \"apple-1-2\",\n" +
//                "            \"pc\": \"Green \",\n" +
//                "            \"dna\": \"Samsung Galaxy A7 2017 (3 GB/32 GB)\",\n" +
//                "            \"dbr\": \"warr4\",\n" +
//                "            \"prid\": 4,\n" +
//                "            \"isBulk\": false\n" +
//                "        },\n" +
//                "        {\n" +
//                "            \"sku\": \"SM_A7/BT/\",\n" +
//                "            \"pn\": \"Battery\",\n" +
//                "            \"pbr\": \"apple-1-2\",\n" +
//                "            \"pc\": \"Green \",\n" +
//                "            \"dna\": \"Samsung Galaxy A7 2017 (3 GB/32 GB)\",\n" +
//                "            \"dbr\": \"warr5\",\n" +
//                "            \"prid\": 6,\n" +
//                "            \"isBulk\": false\n" +
//                "        },\n" +
//                "        {\n" +
//                "            \"sku\": \"crg\",\n" +
//                "            \"pn\": \"Charging Jack\",\n" +
//                "            \"pbr\": \"apple-1-2\",\n" +
//                "            \"pc\": \"Green \",\n" +
//                "            \"dna\": \"Samsung Galaxy A7 2017 (3 GB/32 GB)\",\n" +
//                "            \"dbr\": \"warr4\",\n" +
//                "            \"prid\": 8,\n" +
//                "            \"isBulk\": false\n" +
//                "        }\n" +
//                "    ],\n" +
//                "    \"s\": true\n" +
//                "}", RiderDeliverPendingReceivePartResponse::class.java)
//


        activityListener?.showLoading(true)
        val service =
            UserModuleService<RiderApi, RiderDeliverPendingReceivePartResponse>(
                RiderApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RiderApi, RiderDeliverPendingReceivePartResponse>(
                activityListener
            ) {
            override fun onSuccess(response: RiderDeliverPendingReceivePartResponse, rawResponse: Response) {
                pickupEngineerPartsResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RiderApi): Deferred<retrofit2.Response<RiderDeliverPendingReceivePartResponse>> {
                return api.listEngineerPartsPickByRider(eid)
            }

        })


    }
    var receiveEngineerPartsResponse = MutableLiveData<RecievePartFromEngineerResponse>()



    fun receiveEngineerParts(prid:Int? , pbr:String? ) {


//        receiveEngineerPartsResponse.value =   Gson().fromJson<RecievePartFromEngineerResponse>( "{\n" +
//                "    \"r_id\": \"58e99154-246c-4e8b-b44b-036cfb270194\",\n" +
//                "    \"s\": true\n" +
//                "}", RecievePartFromEngineerResponse::class.java)


        activityListener?.showLoading(true)
        val service =
            UserModuleService<RiderApi, RecievePartFromEngineerResponse>(
                RiderApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RiderApi, RecievePartFromEngineerResponse>(
                activityListener
            ) {
            override fun onSuccess(response: RecievePartFromEngineerResponse, rawResponse: Response) {
                receiveEngineerPartsResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RiderApi): Deferred<retrofit2.Response<RecievePartFromEngineerResponse>> {
                return api.recievePartFromEngineer(prid, pbr)
            }

        })


    }


}