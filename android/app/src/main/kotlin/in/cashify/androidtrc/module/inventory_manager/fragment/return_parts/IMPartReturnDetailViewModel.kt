package `in`.cashify.androidtrc.module.inventory_manager.fragment.return_parts

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.inventory_manager.api.InventoryManagerApi
import `in`.cashify.androidtrc.module.inventory_manager.api.request.PaginationRequest
import `in`.cashify.androidtrc.module.inventory_manager.api.response.PendingDeviceListResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.UpdateReturnPartResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class IMPartReturnDetailViewModel @Inject constructor():BaseViewModel() {
var updateReturnPartResponse = MutableLiveData<UpdateReturnPartResponse>()

    fun returnPart(prid: String, isFault: Boolean) {
       activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, UpdateReturnPartResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, UpdateReturnPartResponse>(activityListener) {
            override fun onSuccess(response: UpdateReturnPartResponse, rawResponse: Response) {
                updateReturnPartResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<UpdateReturnPartResponse>> {
                return api.returnPart(prid, isFault)
            }

        })


    }
}