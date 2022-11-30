package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.inventory_manager.api.InventoryManagerApi
import `in`.cashify.androidtrc.module.inventory_manager.api.request.RiderAssignRequest
import `in`.cashify.androidtrc.module.inventory_manager.api.response.*
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class IMReceiveScanActivityViewModel @Inject constructor():BaseViewModel() {

var partBarcode:String? = null

    var partID:Int? = null




    var receivePArtListResponse:ListReceivePendingPartResponse? = null
    var receivePartResponse:UpdateReceivePartResponse? = null


    fun receivePartList( result: OnResult<ListReceivePendingPartResponse?>){



        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, ListReceivePendingPartResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, ListReceivePendingPartResponse>(activityListener) {
            override fun onSuccess(response: ListReceivePendingPartResponse, rawResponse: Response) {
                receivePArtListResponse = response
                result.onResultAvailable(receivePArtListResponse)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<ListReceivePendingPartResponse>> {
                return api.receivedPendingParts(partBarcode?:"")
            }

        })
    }




    fun receivePart(result: OnResult<UpdateReceivePartResponse?>){


        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, UpdateReceivePartResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, UpdateReceivePartResponse>(activityListener) {
            override fun onSuccess(response: UpdateReceivePartResponse, rawResponse: Response) {
        receivePartResponse = response
                  result.onResultAvailable(receivePartResponse)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<UpdateReceivePartResponse>> {
                return api.receivePart(partID.toString())
            }

        })
    }







}