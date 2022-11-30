package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.ChangeDeviceStatusResponse
import `in`.cashify.androidtrc.module.engineer.api.response.SendToTLReasonResponse
import `in`.cashify.androidtrc.module.engineer.api.response.SendToTLResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 20,August,2019
 */
class WipOptionActivityModel @Inject constructor() : BaseViewModel() {


    var sendToTLResponse = MutableLiveData<SendToTLResponse>()

    fun changeDeviceStatus(status: String?, barcode: String?, onResult: OnResult<ChangeDeviceStatusResponse>) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, ChangeDeviceStatusResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, ChangeDeviceStatusResponse>(activityListener)
        {
            override fun onSuccess(response: ChangeDeviceStatusResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<ChangeDeviceStatusResponse>> {
                return api.changeDeviceStatus(status, barcode)
            }

        })

    }




    fun getReasons(onResult: OnResult<SendToTLReasonResponse>){

//        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, SendToTLReasonResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, SendToTLReasonResponse>(activityListener)
        {
            override fun onSuccess(response: SendToTLReasonResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
//                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<SendToTLReasonResponse>> {
                return api.listDeviceReturnReasons()
            }

        })





    }




    fun sendToTL(dbr:String, reasonCode:String){

        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, SendToTLResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, SendToTLResponse>(activityListener)
        {
            override fun onSuccess(response: SendToTLResponse, rawResponse: Response) {
               sendToTLResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
               activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<SendToTLResponse>> {
                return api.markTL(dbr,reasonCode)
            }

        })


    }

}