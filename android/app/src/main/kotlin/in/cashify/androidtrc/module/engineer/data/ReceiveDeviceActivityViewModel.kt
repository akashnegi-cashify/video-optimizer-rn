package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.*
import `in`.reglobe.api.kotlin.exception.APIException
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 26,July,2019
 */
class ReceiveDeviceActivityViewModel @Inject constructor() : BaseViewModel() {

    fun receiveDevice(barcode: String, onResult: OnResult<BaseUpdateDeviceInfo?>) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, BaseUpdateDeviceInfo>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )

        service.execute(object :
            SessionBaseAPICallback<EngineerApi, BaseUpdateDeviceInfo>(activityListener) {
            override fun onSuccess(response: BaseUpdateDeviceInfo, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<BaseUpdateDeviceInfo>> {
                return api.receiveDevice(barcode)
            }

        })

    }

    fun receivePart(barcode: String?, onResult: OnResult<BaseReceivePartByEng>) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, BaseReceivePartByEng>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<EngineerApi, BaseReceivePartByEng>(activityListener) {
            override fun onSuccess(response: BaseReceivePartByEng, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<BaseReceivePartByEng>> {
                return api.receivePartByEngineer(barcode)
            }

        })

    }
    
}