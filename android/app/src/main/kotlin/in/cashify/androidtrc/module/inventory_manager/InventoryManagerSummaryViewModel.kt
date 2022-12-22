package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.inventory_manager.api.InventoryManagerApi
import `in`.cashify.androidtrc.module.inventory_manager.api.response.PartSummaryResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.ReturnReceiveCountResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class InventoryManagerSummaryViewModel @Inject constructor() : BaseViewModel() {
    var summaryProgress = MutableLiveData<Boolean>()

    var returnReceiveCountResponse = MutableLiveData<ReturnReceiveCountResponse>()
    var partSummaryResponse = MutableLiveData<PartSummaryResponse>()


    init {
        summaryProgress.value = false

    }

    fun returnReceiveCount(){

        summaryProgress?.value = true
//        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, ReturnReceiveCountResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, ReturnReceiveCountResponse>(activityListener) {
            override fun onSuccess(response: ReturnReceiveCountResponse, rawResponse: Response) {
                returnReceiveCountResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                summaryProgress?.value = false

            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<ReturnReceiveCountResponse>> {
                return api.returnReceiveCount()
            }

        })
    }

    fun partSummary(){


        summaryProgress?.value = true
        val service =
            UserModuleService<InventoryManagerApi, PartSummaryResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, PartSummaryResponse>(activityListener) {
            override fun onSuccess(response: PartSummaryResponse, rawResponse: Response) {
                partSummaryResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                summaryProgress?.value = false
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<PartSummaryResponse>> {
                return api.partSummary()
            }

        })
    }


}