package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.inventory_manager.api.InventoryManagerApi
import `in`.cashify.androidtrc.module.inventory_manager.api.response.*
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class InventoryManagerAssignedPartViewModel @Inject constructor() : BaseViewModel() {
    var pendindDeviceDetailResponse = MutableLiveData<PendingDeviceDetailResponse>()
    var deviceId: String? = null
    var prid: Int? = null
    var pendingDevicePartResponse = MutableLiveData<PendingPartListResponse>()
    var pendingPartDetails = MutableLiveData<PendingPartDetailsResponse>()
    val availableQuantityResponse = MutableLiveData<AvailableQuantityResponse>()
    val pendingPartUnLinkResponse = MutableLiveData<PendingPartUnLinkResponse>()
    fun getDeviceDetail() {

//        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, PendingDeviceDetailResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, PendingDeviceDetailResponse>(
                activityListener
            ) {
            override fun onSuccess(response: PendingDeviceDetailResponse, rawResponse: Response) {
                pendindDeviceDetailResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
//                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<PendingDeviceDetailResponse>> {
                return api.getPendingDeviceDetails(deviceId)
            }

        })


    }

    fun getAvailableQuantity(prid: String) {


        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, AvailableQuantityResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, AvailableQuantityResponse>(activityListener) {
            override fun onSuccess(response: AvailableQuantityResponse, rawResponse: Response) {
                availableQuantityResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<AvailableQuantityResponse>> {
                return api.getAvailableQuantity(prid)
            }

        })


    }

    fun getDevicePartList(isShowLoading:Boolean) {
        pendingDevicePartResponse.value = PendingPartListResponse()

        if(isShowLoading) {
            activityListener?.showLoading(true)
        }
        val service =
            UserModuleService<InventoryManagerApi, PendingPartListResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, PendingPartListResponse>(activityListener) {
            override fun onSuccess(response: PendingPartListResponse, rawResponse: Response) {
                pendingDevicePartResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                if(isShowLoading) {
                    activityListener?.showLoading(false)
                }
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<PendingPartListResponse>> {
                return api.getAssignedPartList(deviceId)
            }

        })


    }



    fun getPendingDeviceDetail() {

//        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, PendingDeviceDetailResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, PendingDeviceDetailResponse>(
                activityListener
            ) {
            override fun onSuccess(response: PendingDeviceDetailResponse, rawResponse: Response) {
                pendindDeviceDetailResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
//                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<PendingDeviceDetailResponse>> {
                return api.getPendingDeviceDetails(deviceId)
            }

        })


    }



    fun getPendingPartDetails(prid: Int) {


        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, PendingPartDetailsResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, PendingPartDetailsResponse>(activityListener) {
            override fun onSuccess(response: PendingPartDetailsResponse, rawResponse: Response) {
                pendingPartDetails.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<PendingPartDetailsResponse>> {
                return api.getPendingPartDetails(prid.toString())
            }

        })


    }



    fun cancelPartRequest(
        prid: String,
        onResult: OnResult<CancelPartResponse>
    ) {


        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, CancelPartResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, CancelPartResponse>(activityListener) {
            override fun onSuccess(response: CancelPartResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<CancelPartResponse>> {
                return api.cancelPartRequest(prid)
            }

        })


    }




    fun unlinkPendingPartBarcode(prid: Int) {


        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, PendingPartUnLinkResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, PendingPartUnLinkResponse>(activityListener) {
            override fun onSuccess(response: PendingPartUnLinkResponse, rawResponse: Response) {
                pendingPartUnLinkResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<PendingPartUnLinkResponse>> {
                return api.unlinkPendingPartBarcode(prid.toString())
            }

        })


    }


}