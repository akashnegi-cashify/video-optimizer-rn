package `in`.cashify.androidtrc.module.rubbing_engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.elss.adapter.ElssPartAdapter
import `in`.cashify.androidtrc.module.elss.api.response.*
import `in`.cashify.androidtrc.module.rubbing_engineer.api.RubbingApi
import `in`.cashify.androidtrc.module.rubbing_engineer.api.request.RubbingDeviceListRequest
import `in`.cashify.androidtrc.module.rubbing_engineer.api.request.SearchQuery
import `in`.cashify.androidtrc.module.rubbing_engineer.api.response.RubbingDeviceListResponse
import `in`.cashify.androidtrc.module.rubbing_engineer.api.response.RubbingDeviceReceiveResponse
import `in`.cashify.androidtrc.module.rubbing_engineer.api.response.RubbingDoneResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class RubbingViewModel @Inject constructor() : BaseViewModel() {

    var adapter: ElssPartAdapter? = null
    val dataLoading=MutableLiveData(false)


    var rubbingDeviceReceiveResponse = MutableLiveData<RubbingDeviceListResponse>()


    fun receiveDeviceToRub(
        barcode: String,
        onResult: OnResult<RubbingDeviceReceiveResponse>,
        apiStatus: OnResult<Boolean>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RubbingApi, RubbingDeviceReceiveResponse>(
                RubbingApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RubbingApi, RubbingDeviceReceiveResponse>(activityListener) {
            override fun onSuccess(response: RubbingDeviceReceiveResponse, rawResponse: Response) {

                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                apiStatus.onResultAvailable(false)
                activityListener?.showError(getErrorMsg(e))
                activityListener?.showLoading(false)
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RubbingApi): Deferred<retrofit2.Response<RubbingDeviceReceiveResponse>> {
                return api.doReceiveRubingDevice(barcode)
            }

        })
    }


    fun doRubbingAction(
        barcode: String,
        flagRubbingDone:Boolean,
        onResult: OnResult<RubbingDoneResponse>,
        apiStatus: OnResult<Boolean>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RubbingApi, RubbingDoneResponse>(
                RubbingApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RubbingApi, RubbingDoneResponse>(activityListener) {
            override fun onSuccess(response: RubbingDoneResponse, rawResponse: Response) {

                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                apiStatus.onResultAvailable(false)
                activityListener?.showError(getErrorMsg(e))
                activityListener?.showLoading(false)
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RubbingApi): Deferred<retrofit2.Response<RubbingDoneResponse>> {
                return api.doRubingActionTaken(barcode,flagRubbingDone)
            }

        })
    }


    fun getRubbingDevicesList(pageno:Int,pageSize:Int,searchquery:String="") {

        val searchObject=SearchQuery()
        val request=RubbingDeviceListRequest().apply {
            this.pageNo=pageno
            this.pageSize=pageSize
            this.searcQuery= if(!searchquery.equals("")){ searchObject.apply { this.br=searchquery } }else{ searchObject }
        }
        activityListener?.showLoading(true)

        val service =
            UserModuleService<RubbingApi, RubbingDeviceListResponse>(
                RubbingApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<RubbingApi, RubbingDeviceListResponse>(
                activityListener
            ) {
            override fun onSuccess(response: RubbingDeviceListResponse, rawResponse: Response) {
                rubbingDeviceReceiveResponse.value = response

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
                activityListener?.showLoading(false)
            }

            override fun onComplete() {
//
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RubbingApi): Deferred<retrofit2.Response<RubbingDeviceListResponse>> {
                return api.getRubbingDevices(request)
            }

        })


    }

}