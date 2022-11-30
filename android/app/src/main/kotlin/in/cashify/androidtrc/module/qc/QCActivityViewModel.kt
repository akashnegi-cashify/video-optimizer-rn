package `in`.cashify.androidtrc.module.qc

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.inventory_manager.api.InventoryManagerApi
import `in`.cashify.androidtrc.module.inventory_manager.api.response.PendingPartListResponse
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import `in`.cashify.androidtrc.module.runner.adapter.MarkedOkPickedAdapter
import `in`.reglobe.api.kotlin.exception.APIException
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.lifecycle.MutableLiveData
import androidx.recyclerview.widget.RecyclerView
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class QCActivityViewModel @Inject constructor() : BaseViewModel() {


    var pendingPartLoading = MutableLiveData<Boolean>()

    fun getPendingPartList(barcode:String, onResult: OnResult<QCPendingListResponse>) {


        pendingPartLoading.value = true
        val service =
            UserModuleService<QCApi, QCPendingListResponse>(
                QCApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<QCApi, QCPendingListResponse>(activityListener) {
            override fun onSuccess(response: QCPendingListResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                pendingPartLoading.value = false
            }

            override fun getAPIAsync(api: QCApi): Deferred<retrofit2.Response<QCPendingListResponse>> {
                return api.pendingList(barcode)
            }

        })


    }








}