package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.engineer.adapter.ViewPartAdapter
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.*
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class ViewPartActivityViewModel @Inject constructor() : BaseViewModel() {

//    var viewPartAdapter: ViewPartAdapter? = null
//    val deviceList = MutableLiveData<List<DevicePartInfo>>()

    val wipPartList = MutableLiveData<List<EngineerPartInfo>>()


    init {
        wipPartList.value = emptyList()
    }

//    fun createViewPartAdapter(itemClick: ViewPartAdapter.OnItemClick?) {
//
//    }

//    fun makeRequest(barcode: String?) {
//        getEngPartInfoList(barcode)
//    }






    fun getEngPartInfoList(did: String) {
//        this.did = did
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, EngineerPartList>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, EngineerPartList>(activityListener) {
            override fun onSuccess(response: EngineerPartList, rawResponse: Response) {
                wipPartList.value = response.partInfoList
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<EngineerPartList>> {
                return api.getEngineerDeviceParts(did)
            }

        })

    }




//    private fun getDevicePartList(barcode: String?) {
//        activityListener?.showLoading(true)
//        val service =
//            UserModuleService<EngineerApi, DevicePartList>(
//                EngineerApi::class.java,
//                mResourceProvider.mContext
//            )
//        service.execute(object :
//            SessionBaseAPICallback<EngineerApi, DevicePartList>(activityListener) {
//            override fun onSuccess(response: DevicePartList, rawResponse: Response) {
//                viewPartAdapter?.changeDataSet(response.partInfoList)
//            }
//
//            override fun onFail(e: APIException) {
//                activityListener?.showError(getErrorMsg(e))
//            }
//
//            override fun onComplete() {
//                activityListener?.showLoading(false)
//            }
//
//            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<DevicePartList>> {
//                return api.listEngDeviceParts(barcode)
//            }
//
//        })
//    }




}