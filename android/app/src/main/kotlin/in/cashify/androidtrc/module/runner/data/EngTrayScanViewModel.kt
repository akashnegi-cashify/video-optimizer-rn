package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.runner.api.RunnerApi
import `in`.cashify.androidtrc.module.runner.api.response.engineer_tray.ScanRunnerTray
import `in`.reglobe.api.kotlin.exception.APIException
import android.content.DialogInterface
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 25,July,2019
 */
class EngTrayScanViewModel @Inject constructor() : BaseViewModel() {

    fun updateTrayScan(trayBarcode: String?, onResult: OnResult<ScanRunnerTray>?) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, ScanRunnerTray>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, ScanRunnerTray>(activityListener) {
            override fun onSuccess(response: ScanRunnerTray, rawResponse: Response) {
                onResult?.onResultAvailable(response)

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<ScanRunnerTray>> {
                return api.scanTrayToRunner(trayBarcode)
            }

        })

    }

}