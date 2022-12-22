package `in`.cashify.androidtrc.module.rider.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.rider.api.RiderApi
import `in`.cashify.androidtrc.module.rider.data.response.RiderDeliverPendingReceivePartResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class PendingPartDeliverToEngineerViewModel @Inject constructor() : BaseViewModel() {

var engineerPartsResponse = MutableLiveData<RiderDeliverPendingReceivePartResponse>()


    fun listEngineerParts( engId:Int?) {




//        engineerPartsResponse.value =     Gson().fromJson<RiderDeliverPendingReceivePartResponse>("{\n" +
//                "    \"r_id\": \"5334f7cf-6e73-4a9f-bf2a-d0aac3bec130\",\n" +
//                "    \"dt\": [\n" +
//                "        {\n" +
//                "            \"sku\": \"mm6 sku Charging Jack\",\n" +
//                "            \"pn\": \"MM6 CHARGING JACK\",\n" +
//                "            \"pbr\": \"vikasfeb\",\n" +
//                "            \"pc\": \"Green \",\n" +
//                "            \"dna\": \"Moto M 64 GB\",\n" +
//                "            \"dbr\": \"81plf\",\n" +
//                "            \"prid\": 629,\n" +
//                "            \"isBulk\": false\n" +
//                "        }\n" +
//                "    ],\n" +
//                "    \"s\": true\n" +
//                "}" , RiderDeliverPendingReceivePartResponse::class.java)



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
engineerPartsResponse.value = response


            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RiderApi): Deferred<retrofit2.Response<RiderDeliverPendingReceivePartResponse>> {
                return api.listEngineerParts(engId)
            }

        })


    }



}