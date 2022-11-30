package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.runner.api.RunnerApi
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.EngineerMarkOkDevice
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.MoveToMarkOkTray
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.PickMarkOkDevice
import `in`.reglobe.api.kotlin.exception.APIException
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 25,July,2019
 */
class PickMarkOkDeviceViewModel @Inject constructor() : BaseViewModel() {

    fun pickMarkOkDevice(deviceBarcode: String?, onResult: OnResult<PickMarkOkDevice>?) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, PickMarkOkDevice>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, PickMarkOkDevice>(activityListener) {
            override fun onSuccess(response: PickMarkOkDevice, rawResponse: Response) {
                onResult?.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<PickMarkOkDevice>> {
                return api.pickMarkOkDevice(deviceBarcode)
            }

        })

    }

    fun getEngineerMarkOkDevice(engineerId: String?, onResult: OnResult<EngineerMarkOkDevice>?) {

        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, EngineerMarkOkDevice>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, EngineerMarkOkDevice>(activityListener) {
            override fun onSuccess(response: EngineerMarkOkDevice, rawResponse: Response) {
                onResult?.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<EngineerMarkOkDevice>> {
                return api.engineerMarkOkDevice(engineerId)
            }

        })


    }

}