package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.inventory_manager.api.InventoryManagerApi
import `in`.cashify.androidtrc.module.inventory_manager.api.request.PaginationRequest
import `in`.cashify.androidtrc.module.inventory_manager.api.response.ListReturnPartsResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class InventoryManagerReturnViewModel @Inject constructor() : BaseViewModel() {

    var returnedPartListResponse = MutableLiveData<ListReturnPartsResponse>()
    var returnedPartListResponseLoading = MutableLiveData<Boolean>()
    val DELAY: Long = 500 // in ms

    init {
        returnedPartListResponseLoading.value = false
    }

    fun returnedPartList(pno: Int, ln: Int, br: String?) {
        returnedPartListResponseLoading?.value = true
        val request = PaginationRequest().apply {
            this.pno = pno
            this.ln = ln
            this.br = br
        }


        val service =
            UserModuleService<InventoryManagerApi, ListReturnPartsResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, ListReturnPartsResponse>(activityListener) {
            override fun onSuccess(response: ListReturnPartsResponse, rawResponse: Response) {
                returnedPartListResponse?.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {

                returnedPartListResponseLoading?.value = false
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<ListReturnPartsResponse>> {
                return api.listReturnedParts(request)
            }

        })

//
    }

}