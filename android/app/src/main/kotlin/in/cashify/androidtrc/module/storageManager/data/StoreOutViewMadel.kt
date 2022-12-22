package `in`.cashify.androidtrc.module.storageManager.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.elss.adapter.ElssPartAdapter
import `in`.cashify.androidtrc.module.elss.adapter.StorageManagerAdapter
import `in`.cashify.androidtrc.module.elss.api.ElssApi
import `in`.cashify.androidtrc.module.elss.api.StorageMangerAPi
import `in`.cashify.androidtrc.module.elss.api.response.ElssDeviceResponse
import `in`.cashify.androidtrc.module.elss.api.response.SubmitElssRequest
import `in`.cashify.androidtrc.module.elss.api.response.SubmitElssResponse
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.*
import `in`.cashify.androidtrc.module.storageManager.ui.activity.StoreOutActivity
import `in`.reglobe.api.kotlin.exception.APIException
 import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
class StoreOutViewMadel @Inject constructor() : BaseViewModel()
{
    var barcode: String? = null
    var storeOutActivityListener: StorageOutActivityListener? = null
    var deviceDetailsModel : DeviceStorageDetailResponse? = null

    var adapter: StorageManagerAdapter? = null



    var deviceDetailsList :DeviceDetailsList = DeviceDetailsList(ArrayList<DeviceDetails>())


    fun getDeviceStorage(
        barcode: String,
        onResult: OnResult<FetchStorageDetailsResponse>,
        apiStatus: OnResult<Boolean>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<StorageMangerAPi, FetchStorageDetailsResponse>(
                StorageMangerAPi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<StorageMangerAPi, FetchStorageDetailsResponse>(activityListener) {
            override fun onSuccess(response: FetchStorageDetailsResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                apiStatus.onResultAvailable(false)
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: StorageMangerAPi): Deferred<retrofit2.Response<FetchStorageDetailsResponse>> {
                return api.getDeviceStorage(barcode)
            }

        })
    }




    fun createAdapter() {
        adapter = StorageManagerAdapter()

     }



    fun getMarkL4(barcode: String, onResult: OnResult<MarkL4Response>)
    {
        activityListener?.showLoading(true)

        val service = UserModuleService<ElssApi, MarkL4Response>(ElssApi::class.java, mResourceProvider.mContext)

        service.execute(object :
            SessionBaseAPICallback<ElssApi, MarkL4Response>(activityListener) {
            override fun onSuccess(response: MarkL4Response, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                 activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: ElssApi): Deferred<retrofit2.Response<MarkL4Response>> {
                return api.getMarkL4(barcode)
            }

        })
    }

    fun saveStoreOutDevice(
        trayBarcode: String?,
        deviceBarcode: String?,
        onResult: OnResult<FetchStorageDetailsResponse>
    ){
        activityListener?.showLoading(true)
        val service =
            UserModuleService<StorageMangerAPi, FetchStorageDetailsResponse>(
                StorageMangerAPi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<StorageMangerAPi, FetchStorageDetailsResponse>(activityListener) {
            override fun onSuccess(response: FetchStorageDetailsResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                 activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: StorageMangerAPi): Deferred<retrofit2.Response<FetchStorageDetailsResponse>> {
                return api.saveStoreOutDevice(trayBarcode,deviceBarcode)
            }

        })
    }


    fun getDeviceStorageDetails(
        deviceBarcode: String?,
        onResult: OnResult<DeviceStorageDetailResponse>
    ){
        activityListener?.showLoading(true)
        val service =
            UserModuleService<StorageMangerAPi, DeviceStorageDetailResponse>(
                StorageMangerAPi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<StorageMangerAPi, DeviceStorageDetailResponse>(activityListener) {
            override fun onSuccess(response: DeviceStorageDetailResponse, rawResponse: Response) {
                deviceDetailsModel = response
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: StorageMangerAPi): Deferred<retrofit2.Response<DeviceStorageDetailResponse>> {
                return api.getDeviceDetails(deviceBarcode)
            }

        })
    }

}