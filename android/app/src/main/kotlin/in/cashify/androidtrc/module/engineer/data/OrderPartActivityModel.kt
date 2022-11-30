package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.engineer.adapter.OrderDevicePartAdapter
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartList
import `in`.cashify.androidtrc.module.engineer.api.response.OrderDevicePartResponse
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 21,August,2019
 */
class OrderPartActivityModel @Inject constructor() : BaseViewModel() {

    var orderDevicePartAdapter: OrderDevicePartAdapter? = null
    val deviceList = MutableLiveData<ArrayList<DevicePartInfo>>()
    val searchList = MutableLiveData<ArrayList<DevicePartInfo>>()

    init {
        deviceList.value = ArrayList()
        searchList.value = ArrayList()
    }

    fun createAdapter() {
        orderDevicePartAdapter = OrderDevicePartAdapter()
    }

    fun orderDevicePart(
        barcode: String?,
        devicePartList: DevicePartList?,
        onResult: OnResult<OrderDevicePartResponse>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, OrderDevicePartResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, OrderDevicePartResponse>(activityListener) {
            override fun onSuccess(response: OrderDevicePartResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<OrderDevicePartResponse>> {
                return api.orderDeviceParts(barcode, devicePartList?.partInfoList)
            }

        })
    }

    fun getDevicePartList(barcode: String?) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, DevicePartList>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, DevicePartList>(activityListener) {
            override fun onSuccess(response: DevicePartList, rawResponse: Response) {
                deviceList.value = response.partInfoList
//                orderDevicePartAdapter?.changeDataSet(response.partInfoList)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
                deviceList.value = ArrayList()
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<DevicePartList>> {
                return api.listDeviceParts(barcode)
            }

        })
    }


}