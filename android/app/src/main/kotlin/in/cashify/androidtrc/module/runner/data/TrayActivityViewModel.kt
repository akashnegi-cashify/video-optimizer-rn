package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.runner.adapter.TrayAdapter
import `in`.cashify.androidtrc.module.runner.adapter.TrayPagerAdapter
import `in`.cashify.androidtrc.module.runner.api.RunnerApi
import `in`.cashify.androidtrc.module.runner.api.response.device_list.DeviceInfoAllocatedToEng
import `in`.cashify.androidtrc.module.runner.api.response.engineer_tray.TrayListAllocatedToEng
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class TrayActivityViewModel @Inject constructor() : BaseViewModel() {
    var pagerAdapter: TrayPagerAdapter? = null
    var trayAdapter: TrayAdapter? = null
    val trayCount = MutableLiveData<String>()

    init {
        trayCount.value = "0"
    }

    fun createTrayAdapter() {
        trayAdapter = TrayAdapter()
    }

    fun getTrayList(isPending: Boolean, deviceInfo: DeviceInfoAllocatedToEng?) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<RunnerApi, TrayListAllocatedToEng>(
                RunnerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<RunnerApi, TrayListAllocatedToEng>(activityListener) {
            override fun onSuccess(response: TrayListAllocatedToEng, rawResponse: Response) {
                pagerAdapter?.changeDataSet(response.trayList)
                if (isPending) {
                    trayCount.value = response.trayList?.size.toString()
                }
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: RunnerApi): Deferred<retrofit2.Response<TrayListAllocatedToEng>> {
                return api.getTrayAllocatedToEngineer(deviceInfo?.engineerId, isPending)
            }

        })
    }

    fun makeRequest(position: Int, deviceInfo: DeviceInfoAllocatedToEng?) {
        if (position == 0) {
            getTrayList(false, deviceInfo)
        } else {
            getTrayList(true, deviceInfo)
        }
    }

    fun createTrayPagerAdapter(supportFragmentManager: FragmentManager, tabCount: Int) {
        pagerAdapter = TrayPagerAdapter(supportFragmentManager, tabCount)
    }

}