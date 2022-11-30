package `in`.cashify.androidtrc.module.rider.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.inventory_manager.api.request.PendingDeliveryDevicePartRequest
import `in`.cashify.androidtrc.module.rider.api.RiderApi
import `in`.cashify.androidtrc.module.rider.data.request.ListReceivePartsFromIMRequest
import `in`.cashify.androidtrc.module.rider.data.response.*
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class RiderActivityViewModel @Inject constructor() : BaseViewModel() {


  var partsListDeliverToIMResponse = MutableLiveData<IMPartListResponse>()
    var partsListDeliverToIMLoading = MutableLiveData<Boolean>()





    var partsRecieveFromIMLoading = MutableLiveData<Boolean>()

    var deliveryEngineerListResponse = MutableLiveData<DeliverEngineerListResponse>()
    var deliverEngineerLoading = MutableLiveData<Boolean>()





    var listReceivePartsFromIMResponse  = MutableLiveData<IMPartListResponse>()

   // var deliveryReceivePartsListResponseLoading  = MutableLiveData<Boolean>()








    var receiveEngineerListLoading = MutableLiveData<Boolean>()


    var recievePartFromIMResponse = MutableLiveData<IMPartsResponse>()


    var pickupEngineerList = MutableLiveData<ReceiveEngineerListResponse>()


    fun listReceivePartsFromIm(pno: Int, ln: Int, br: String?, isUrgent:Boolean) {




         partsRecieveFromIMLoading.value = true
        val request = ListReceivePartsFromIMRequest().apply {
            this.pageNo = pno
            this.listNo = ln
            this.barcode = br?:""

            this.fp = ListReceivePartsFromIMRequest.FacilityPart().apply {
                this.is_urgent = isUrgent
            }
        }
        val service =
            UserModuleService<RiderApi, IMPartListResponse>(
                RiderApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RiderApi, IMPartListResponse>(
                activityListener
            ) {
            override fun onSuccess(response: IMPartListResponse, rawResponse: Response) {
                listReceivePartsFromIMResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
              partsRecieveFromIMLoading.value = false
            }

            override fun getAPIAsync(api: RiderApi): Deferred<retrofit2.Response<IMPartListResponse>> {
                return api.listReceivePartsFromIM(request)
            }

        })


    }





    fun deliverEngineersList(isUrgent:Boolean) {


         deliverEngineerLoading.value = true

        val service =
            UserModuleService<RiderApi, DeliverEngineerListResponse>(
                RiderApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RiderApi, DeliverEngineerListResponse>(
                activityListener
            ) {
            override fun onSuccess(response: DeliverEngineerListResponse, rawResponse: Response) {
                deliveryEngineerListResponse.value = response

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
//
         deliverEngineerLoading.value = false
            }

            override fun getAPIAsync(api: RiderApi): Deferred<retrofit2.Response<DeliverEngineerListResponse>> {
                return api.deliverEngineersList(isUrgent)
            }

        })


    }








    fun receivePartFromIM(partId:Int?) {

//        recievePartFromIMResponse.value =     Gson().fromJson<IMPartsResponse>("{\n" +
//                "    \"r_id\": \"6b602cbf-7d2e-45d0-93a4-f8fbfadec50c\",\n" +
//                "    \"s\": true\n" +
//                "}"  ,IMPartsResponse::class.java )


//activityListener?.showLoading(true)
        val service =
            UserModuleService<RiderApi, IMPartsResponse>(
                RiderApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RiderApi, IMPartsResponse>(
                activityListener
            ) {
            override fun onSuccess(response: IMPartsResponse, rawResponse: Response) {
                recievePartFromIMResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
//                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RiderApi): Deferred<retrofit2.Response<IMPartsResponse>> {
                return api.receiveParts(partId)
            }

        })


    }







    fun receiveEngineerList( ) {

//        receiveEngineerListLoading.value = true
//        pickupEngineerList.value =   Gson().fromJson<ReceiveEngineerListResponse>("{\n" +
//
//                "    \"r_id\": \"b6f08e64-889f-4a61-85ee-f86dc4cdf013\",\n" +
//                "    \"dt\": [\n" +
//                "        {\n" +
//                "            \"id\": 22,\n" +
//                "            \"n\": \"Nisha_E\",\n" +
//                "            \"lc\": \"A1\"\n" +
//                "        },\n" +
//                "        {\n" +
//                "            \"id\": 34,\n" +
//                "            \"n\": \"vikash\",\n" +
//                "            \"lc\": \"A2\"\n" +
//                "        },\n" +
//                "        {\n" +
//                "            \"id\": 37,\n" +
//                "            \"n\": \"AnanyaTest\",\n" +
//                "            \"lc\": \"A3\"\n" +
//                "        }\n" +
//                "    ],\n" +
//                "    \"s\": true\n" +
//                "}" ,ReceiveEngineerListResponse::class.java )




receiveEngineerListLoading.value = true
        val service =
            UserModuleService<RiderApi, ReceiveEngineerListResponse>(
                RiderApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RiderApi, ReceiveEngineerListResponse>(
                activityListener
            ) {
            override fun onSuccess(response: ReceiveEngineerListResponse, rawResponse: Response) {
                pickupEngineerList.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
             receiveEngineerListLoading.value = false
            }

            override fun getAPIAsync(api: RiderApi): Deferred<retrofit2.Response<ReceiveEngineerListResponse>> {
                return api.listEngineersToPickUp()
            }

        })


    }

















    fun partsDeliverToIM(pno: Int, ln: Int, br: String?) {


//        partsListDeliverToIMResponse.value =      Gson().fromJson<IMPartListResponse>("{\n" +
//                "    \"r_id\": \"ba6e4db3-f950-4205-850c-8c19c83e328a\",\n" +
//                "    \"dt\": {\n" +
//                "        \"pl\": [\n" +
//                "            {\n" +
//                "                \"sku\": \"SKU-ONE\",\n" +
//                "                \"pn\": \"ONE + 55\",\n" +
//                "                \"pbr\": \"vikas12feb\",\n" +
//                "                \"pc\": \"Green \",\n" +
//                "                \"dna\": \"OnePlus 6 (6 GB/64 GB)\",\n" +
//                "                \"dbr\": \"24jab\",\n" +
//                "                \"prid\": 553,\n" +
//                "                \"isBulk\": false\n" +
//                "            },\n" +
//                "            {\n" +
//                "                \"sku\": \"mm6 sku Charging Jack\",\n" +
//                "                \"pn\": \"MM6 CHARGING JACK\",\n" +
//                "                \"pbr\": \"vikasfeb\",\n" +
//                "                \"pc\": \"Green \",\n" +
//                "                \"dna\": \"Moto M 64 GB\",\n" +
//                "                \"dbr\": \"81plf\",\n" +
//                "                \"prid\": 629,\n" +
//                "                \"isBulk\": false\n" +
//                "            },\n" +
//                "            {\n" +
//                "                \"sku\": \"viiia\",\n" +
//                "                \"pn\": \"VIKASS2\",\n" +
//                "                \"pbr\": \"vikas12feb\",\n" +
//                "                \"pc\": \"hite\",\n" +
//                "                \"dna\": \"Moto M 64 GB\",\n" +
//                "                \"dbr\": \"QC1290\",\n" +
//                "                \"prid\": 801,\n" +
//                "                \"isBulk\": true\n" +
//                "            },\n" +
//                "            {\n" +
//                "                \"sku\": \"mm6 sku Charging Jack\",\n" +
//                "                \"pn\": \"MM6 CHARGING JACK\",\n" +
//                "                \"pbr\": \"vikas12feb\",\n" +
//                "                \"dna\": \"Moto M 64 GB\",\n" +
//                "                \"dbr\": \"QC1290\",\n" +
//                "                \"prid\": 835,\n" +
//                "                \"isBulk\": false\n" +
//                "            }\n" +
//                "        ],\n" +
//                "        \"tp\": 1\n" +
//                "    },\n" +
//                "    \"s\": true\n" +
//                "}", IMPartListResponse::class.java)
//




        partsListDeliverToIMLoading.value = true
        val request = ListReceivePartsFromIMRequest().apply {
            this.pageNo = pno
            this.listNo = ln
            this.barcode = br?:""
        }

        val service =
            UserModuleService<RiderApi, IMPartListResponse>(
                RiderApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RiderApi, IMPartListResponse>(
                activityListener
            ) {
            override fun onSuccess(response: IMPartListResponse, rawResponse: Response) {
                partsListDeliverToIMResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
partsListDeliverToIMLoading.value = false
            }

            override fun getAPIAsync(api: RiderApi): Deferred<retrofit2.Response<IMPartListResponse>> {
                return api.listDeliverPartToIM(request)
            }

        })
//

    }






}