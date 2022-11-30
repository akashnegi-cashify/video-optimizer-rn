package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.runner.adapter.AllocatedDeviceAdapter
import `in`.cashify.androidtrc.module.runner.adapter.GivenDevicePagerAdapter
import `in`.cashify.androidtrc.module.runner.api.RunnerApi
import `in`.cashify.androidtrc.module.runner.api.response.device_list.DeviceInfoAllocatedToEng
import `in`.cashify.androidtrc.module.runner.api.response.device_list.DeviceListAllocatedToEng
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class DeviceAllocatedViewModel @Inject constructor() : BaseViewModel() {

    var adapter: GivenDevicePagerAdapter? = null
    var allocatedDeviceAdapter: AllocatedDeviceAdapter? = null
    val deviceList = MutableLiveData<List<DeviceInfoAllocatedToEng>>()


    init {
        deviceList.value = emptyList()
    }

    fun createAllocatedDeviceAdapter() {
        allocatedDeviceAdapter = AllocatedDeviceAdapter()
    }

    fun createGivenPagerAdapter(fragmentManager: FragmentManager, numOfTabs: Int) {
        adapter = GivenDevicePagerAdapter(fragmentManager, numOfTabs)
    }

    fun makeRequest(position: Int) {
        if (position == 0) {
            getDeviceAllocatedToEngineer(false)
        } else {
            getDeviceAllocatedToEngineer(true)
        }
    }

    fun getDeviceAllocatedToEngineer(isPending: Boolean) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, DeviceListAllocatedToEng>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, DeviceListAllocatedToEng>(activityListener) {
            override fun onSuccess(response: DeviceListAllocatedToEng, rawResponse: Response) {
                adapter?.changeDataSet(response.deviceList)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<DeviceListAllocatedToEng>> {
                return api.getDeviceAllocatedToEngineer(isPending)
            }

        })

    }


}