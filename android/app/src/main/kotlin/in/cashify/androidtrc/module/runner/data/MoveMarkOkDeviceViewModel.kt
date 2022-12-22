package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.runner.api.RunnerApi
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.MoveToMarkOkTray
import `in`.reglobe.api.kotlin.exception.APIException
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 25,July,2019
 */
class MoveMarkOkDeviceViewModel @Inject constructor() : BaseViewModel() {

    fun moveToMarkOK(trayBarcode: String?, deviceBarcode: String?, onResult: OnResult<MoveToMarkOkTray>?) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, MoveToMarkOkTray>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, MoveToMarkOkTray>(activityListener) {
            override fun onSuccess(response: MoveToMarkOkTray, rawResponse: Response) {
                onResult?.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<MoveToMarkOkTray>> {
                return api.moveToMarkOkDevice(trayBarcode, deviceBarcode)
            }

        })

    }


}