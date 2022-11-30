package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback

import `in`.cashify.androidtrc.module.inventory_manager.api.InventoryManagerApi
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import `in`.cashify.androidtrc.module.inventory_manager.api.request.InitiateAlternatePartRequest
import `in`.cashify.androidtrc.module.inventory_manager.api.response.*
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class InventoryManagerPendingPartViewModel @Inject constructor() : BaseViewModel() {

    val pendingPartLinkResponse = MutableLiveData<PendingPartLinkResponse>()
    val pendingPartUnLinkResponse = MutableLiveData<PendingPartUnLinkResponse>()
    val linkDeadPartResponse = MutableLiveData<LinkDeadPartResponse>()
    val listAlternatePartResponse = MutableLiveData<ListAlternatePartResponse>()
    val initiatePartResponse = MutableLiveData<InitiateAlternatePartResponse>()

    val availableQuantityResponse = MutableLiveData<AvailableQuantityResponse>()

    var pendindDeviceDetailResponse = MutableLiveData<PendingDeviceDetailResponse>()

    var recommendedPartId = MutableLiveData<String>()

    var pendingDevicePartResponse = MutableLiveData<PendingPartListResponse>()


    var pendingPartDetails = MutableLiveData<PendingPartDetailsResponse>()


    var deviceId: String? = null


    var barcode: String? = ""



    var pendimgPartLoadingFail = MutableLiveData<APIException>()


    var btnGoBackVisibility = MutableLiveData<Boolean>()

    var btnQuantityVisibility = MutableLiveData<Boolean>()



    var alternatePrid: Int? = null
    var prid: Int? = null
    var partStatus:PartStatus = PartStatus.AVAILABBLE
    var isDeadPart:Boolean = false





    init {

        btnGoBackVisibility.value = false

        btnQuantityVisibility.value = true

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


    fun getPendingDevicePartList(isShowLoading:Boolean) {


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

                pendimgPartLoadingFail.value = e

            }

            override fun onComplete() {
                if(isShowLoading) {
                    activityListener?.showLoading(false)
                }
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<PendingPartListResponse>> {
                return api.getPendingPartList(deviceId)
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


    fun cancelPartRequest(
        prid: String,
        onResult: OnResult<`in`.cashify.androidtrc.module.inventory_manager.api.response.CancelPartResponse>
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
                // refresh part list
//                getPendingDevicePartList(false)


                btnGoBackVisibility.value = true

                btnQuantityVisibility.value = false
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


    fun initiateAlternatePartRequest(did: String, prid: Int, sku: String, pn: String) {


        var request = InitiateAlternatePartRequest().apply {
            this.sku = sku
            this.pn = pn
            this.partId = prid
        }

        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, InitiateAlternatePartResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, InitiateAlternatePartResponse>(
                activityListener
            ) {
            override fun onSuccess(response: InitiateAlternatePartResponse, rawResponse: Response) {
                initiatePartResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<InitiateAlternatePartResponse>> {
                return api.initiateAlternatePartRequest(did, request)
            }

        })


    }


    fun listAlternateParts(prid: Int) {

        listAlternatePartResponse.value = ListAlternatePartResponse()
        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, ListAlternatePartResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, ListAlternatePartResponse>(activityListener) {
            override fun onSuccess(response: ListAlternatePartResponse, rawResponse: Response) {
                listAlternatePartResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }


            override fun onFailure(e: APIException) {
                super.onFailure(e)
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<ListAlternatePartResponse>> {
                return api.listAlternateParts(prid.toString())
            }

        })


    }


    fun linkDeadParts(prid: String) {


        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, LinkDeadPartResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, LinkDeadPartResponse>(activityListener) {
            override fun onSuccess(response: LinkDeadPartResponse, rawResponse: Response) {
                // refresh the list
//                getPendingDevicePartList(false)
                linkDeadPartResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<LinkDeadPartResponse>> {
                return api.linkDeadPart(prid)
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


    fun linkPendingPartBarcode(prid: String, pbr: String) {


        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, PendingPartLinkResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, PendingPartLinkResponse>(activityListener) {
            override fun onSuccess(response: PendingPartLinkResponse, rawResponse: Response) {
                barcode = pbr
                pendingPartLinkResponse.value = response
            }


            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<PendingPartLinkResponse>> {
                return api.linkPendingPartBarcode(prid, pbr)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

        })


    }


    fun syncPendingPartRequest(prid: String) {


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
                return api.syncPendingPartRequest(prid)
            }

        })


    }


    fun callRecommendedPartApi(prId:Int) {

       // activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, RecommendedPartResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, RecommendedPartResponse>(
                activityListener
            ) {
            override fun onSuccess(response: RecommendedPartResponse, rawResponse: Response) {
                if(response.success){
                    recommendedPartId.value = response.data?.pbr
                }

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
               // activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<RecommendedPartResponse>> {
                return api.doRecommendedPartAPiCall(prId)
            }

        })


    }



}