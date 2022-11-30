package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.runner.adapter.MarkOkPagerAdapter
import `in`.cashify.androidtrc.module.runner.adapter.MarkedOkPendingAdapter
import `in`.cashify.androidtrc.module.runner.adapter.MarkedOkPickedAdapter
import `in`.cashify.androidtrc.module.runner.api.RunnerApi
import `in`.cashify.androidtrc.module.runner.api.response.device_list.DeviceInfoAllocatedToEng
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.MarkedOkPendingDeviceResponse
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.MarkedOkPickedDeviceResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.fragment.app.FragmentManager
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 24,July,2019
 */
class MarkOkViewModel @Inject constructor() : BaseViewModel() {
    var pagerAdapter: MarkOkPagerAdapter? = null
    var pendingAdapter: MarkedOkPendingAdapter? = null
    var pickedAdapter: MarkedOkPickedAdapter? = null

    fun createPickedAdapter() {
        pickedAdapter = MarkedOkPickedAdapter()
    }

    fun createPendingAdapter() {
        pendingAdapter = MarkedOkPendingAdapter()
    }

    fun getPendingList() {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, MarkedOkPendingDeviceResponse>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, MarkedOkPendingDeviceResponse>(activityListener) {
            override fun onSuccess(response: MarkedOkPendingDeviceResponse, rawResponse: Response) {
                pagerAdapter?.changePendingDataSet(response.deviceList)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<MarkedOkPendingDeviceResponse>> {
                return api.getMarkedOkPendingDevices()
            }

        })
    }

    fun getPickedList() {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, MarkedOkPickedDeviceResponse>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, MarkedOkPickedDeviceResponse>(activityListener) {
            override fun onSuccess(response: MarkedOkPickedDeviceResponse, rawResponse: Response) {
                pagerAdapter?.changePickedDataSet(response.deviceList)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<MarkedOkPickedDeviceResponse>> {
                return api.getMarkedOkPickedUpDevices()
            }

        })
    }


    fun makeRequest(position: Int) {
        if (position == 0) {
            getPendingList()
        } else {
            getPickedList()
        }
    }

    fun createMarkOkPagerAdapter(supportFragmentManager: FragmentManager, tabCount: Int) {
        pagerAdapter = MarkOkPagerAdapter(supportFragmentManager, tabCount)
    }


}