package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerDeviceList
import `in`.cashify.androidtrc.module.engineer.api.response.SendToInProgress
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class EngineerMyDevicesTabViewModel @Inject constructor() : BaseViewModel() {



    var engineerDeviceListResponse = MutableLiveData<EngineerDeviceList>()
    var engDeviceListScreenLoading = MutableLiveData<Boolean>()

    var engWipDeviceListResponse = MutableLiveData<EngineerDeviceList>()

    var engWIPDeviceListScreenLoading = MutableLiveData<Boolean>()


    init {

        engDeviceListScreenLoading.value = false
        engWIPDeviceListScreenLoading.value = false
    }

    fun engineerDeviceList() {
        engDeviceListScreenLoading.value = true
        val service =
            UserModuleService<EngineerApi, EngineerDeviceList>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<EngineerApi, EngineerDeviceList>(activityListener) {
            override fun onSuccess(response: EngineerDeviceList, rawResponse: Response) {
                engineerDeviceListResponse.value = response

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                engDeviceListScreenLoading.value = false
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<EngineerDeviceList>> {
                return api.getEngineerDeviceList()
            }

        })

    }

    fun sendToInProgress(barcode: String?) {
        engDeviceListScreenLoading.value = true
        val service =
            UserModuleService<EngineerApi, SendToInProgress>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<EngineerApi, SendToInProgress>(activityListener) {
            override fun onSuccess(response: SendToInProgress, rawResponse: Response) {
                if (response.isSuccess) {
                    engineerDeviceList()
                }else{
                    activityListener?.showError(response.errorMsg)
                }

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                engDeviceListScreenLoading.value = false
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<SendToInProgress>> {
                return api.sendToInProgress(barcode)
            }

        })
    }






//    fun makeRequest(position: Int) {
//        if (position == 0) {
//            engineerDeviceList()
//        } else {
//            engineerDeviceList()
//        }
//    }

    fun engineerWIPDeviceList() {
        engWIPDeviceListScreenLoading.value = true
        val service =
            UserModuleService<EngineerApi, EngineerDeviceList>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<EngineerApi, EngineerDeviceList>(activityListener) {
            override fun onSuccess(response: EngineerDeviceList, rawResponse: Response) {

                engWipDeviceListResponse.value = response

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                engWIPDeviceListScreenLoading.value = false
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<EngineerDeviceList>> {
                return api.getEngineerWipDeviceList()
            }

        })

    }
}