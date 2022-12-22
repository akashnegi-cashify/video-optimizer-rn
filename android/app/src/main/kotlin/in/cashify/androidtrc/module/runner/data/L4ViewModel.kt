package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.runner.adapter.L4PagerAdapter
import `in`.cashify.androidtrc.module.runner.adapter.L4PendingAdapter
import `in`.cashify.androidtrc.module.runner.adapter.L4PickedAdapter
import `in`.cashify.androidtrc.module.runner.api.RunnerApi
import `in`.cashify.androidtrc.module.runner.api.response.l4.MarkedL4PendingDeviceResponse
import `in`.cashify.androidtrc.module.runner.api.response.l4.MarkedL4PickedDeviceResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.fragment.app.FragmentManager
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 24,July,2019
 */
class L4ViewModel @Inject constructor() : BaseViewModel() {
    var pagerAdapter: L4PagerAdapter? = null
    var pendingAdapter: L4PendingAdapter? = null
    var pickedAdapter: L4PickedAdapter? = null

    fun createPickedAdapter() {
        pickedAdapter = L4PickedAdapter()
    }

    fun createPendingAdapter() {
        pendingAdapter = L4PendingAdapter()
    }

    fun getPendingList() {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, MarkedL4PendingDeviceResponse>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, MarkedL4PendingDeviceResponse>(activityListener) {
            override fun onSuccess(response: MarkedL4PendingDeviceResponse, rawResponse: Response) {
                pagerAdapter?.changePendingDataSet(response.deviceList)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<MarkedL4PendingDeviceResponse>> {
                return api.getMarkedL4PendingDevices()
            }

        })
    }

    fun getPickedList() {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, MarkedL4PickedDeviceResponse>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, MarkedL4PickedDeviceResponse>(activityListener) {
            override fun onSuccess(response: MarkedL4PickedDeviceResponse, rawResponse: Response) {
                pagerAdapter?.changePickedDataSet(response.deviceList)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<MarkedL4PickedDeviceResponse>> {
                return api.getMarkedL4PickedUpDevices()
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
        pagerAdapter = L4PagerAdapter(supportFragmentManager, tabCount)
    }


}