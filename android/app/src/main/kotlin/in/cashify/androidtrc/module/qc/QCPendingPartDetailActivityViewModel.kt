package `in`.cashify.androidtrc.module.qc

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.qc.data.request.SubmitQCRequest
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import `in`.cashify.androidtrc.module.qc.data.response.SubmitQCResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class QCPendingPartDetailActivityViewModel @Inject constructor() : BaseViewModel() {


     val qcSubmitResponse = MutableLiveData<SubmitQCResponse>()

    fun submitPartData(partId:Int, isFaulty:Boolean) {



      activityListener?.showLoading(true)
        val service =
            UserModuleService<QCApi, SubmitQCResponse>(
                QCApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<QCApi, SubmitQCResponse>(activityListener) {
            override fun onSuccess(response: SubmitQCResponse, rawResponse: Response) {
                qcSubmitResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
              activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: QCApi): Deferred<retrofit2.Response<SubmitQCResponse>> {
                return api.submitQc(SubmitQCRequest().apply {
                    prid = partId
                    isFault = isFaulty

                })
            }

        })


    }





}