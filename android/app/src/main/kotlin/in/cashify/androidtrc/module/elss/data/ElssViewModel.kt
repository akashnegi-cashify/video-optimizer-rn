package `in`.cashify.androidtrc.module.elss.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.elss.adapter.ElssPartAdapter
import `in`.cashify.androidtrc.module.elss.api.ElssApi
import `in`.cashify.androidtrc.module.elss.api.response.*
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartList
import `in`.cashify.androidtrc.module.engineer.api.response.MarkL4Response
import `in`.cashify.common_uploader.constant.FileType
import `in`.cashify.common_uploader.utils.ImageQuality
import `in`.cashify.s3_file_uploader.listener.S3FileUploaderListener
import `in`.cashify.s3_file_uploader.uploader.S3FileUploader
import `in`.cashify.s3_file_uploader.uploader.S3FileUploaderConfig
import `in`.reglobe.api.kotlin.exception.APIException
import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import kotlinx.coroutines.Deferred
import okhttp3.Response
import java.util.*
import javax.inject.Inject

class ElssViewModel @Inject constructor() : BaseViewModel() {
    var selectedRadioButton = "Select Button"
    var adapter: ElssPartAdapter? = null
    var elssDeviceDetail = MutableLiveData<ElssDeviceResponse?>()

    // var elssDeviceOptionsResponse:ElssOptionResponse?=null

    val mFilePathList: Queue<String> = LinkedList()
    val s3PathList = emptyList<String>()
    var mS3ConfigResponse = MutableLiveData<S3ConfigResponse>()
    var uploadImagerequest = UploadImageRequest()

    var imageDetailMap:HashMap<String, ArrayList<String>> = HashMap()


    fun createAdapter() {
        adapter = ElssPartAdapter()
    }

    fun getElssDevice(
        barcode: String,
        onResult: OnResult<ElssDeviceResponse>,
        apiStatus: OnResult<Boolean>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<ElssApi, ElssDeviceResponse>(
                ElssApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<ElssApi, ElssDeviceResponse>(activityListener) {
            override fun onSuccess(response: ElssDeviceResponse, rawResponse: Response) {
                updateResponse(response)
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                apiStatus.onResultAvailable(false)
                activityListener?.showError(getErrorMsg(e))
                activityListener?.showLoading(false)
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: ElssApi): Deferred<retrofit2.Response<ElssDeviceResponse>> {
                return api.getElssDevice(barcode)
            }

        })
    }

    fun getElssDeviceActionOptions(
        barcode: String,
        onResult: OnResult<ElssOptionResponse>,
        apiStatus: OnResult<Boolean>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<ElssApi, ElssOptionResponse>(
                ElssApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<ElssApi, ElssOptionResponse>(activityListener) {
            override fun onSuccess(response: ElssOptionResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                apiStatus.onResultAvailable(false)
                activityListener?.showError(getErrorMsg(e))
                activityListener?.showLoading(false)
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: ElssApi): Deferred<retrofit2.Response<ElssOptionResponse>> {
                return api.getElssDeviceActionOptions(barcode)
            }

        })
    }


    fun getBrands(
        onResult: OnResult<BrandListResponse>,
        apiStatus: OnResult<Boolean>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<ElssApi, BrandListResponse>(
                ElssApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<ElssApi, BrandListResponse>(activityListener) {
            override fun onSuccess(response: BrandListResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                apiStatus.onResultAvailable(false)
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: ElssApi): Deferred<retrofit2.Response<BrandListResponse>> {
                return api.getBrandList()
            }

        })
    }


    fun getModels(
        brandId: Int?,
        onResult: OnResult<ModelListResponse>,
        apiStatus: OnResult<Boolean>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<ElssApi, ModelListResponse>(
                ElssApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<ElssApi, ModelListResponse>(activityListener) {
            override fun onSuccess(response: ModelListResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                apiStatus.onResultAvailable(false)
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: ElssApi): Deferred<retrofit2.Response<ModelListResponse>> {
                return api.getModels(brandId)
            }

        })
    }


    fun getColorList(
        productId: Int?,
        onResult: OnResult<ColorListResponse>,
        apiStatus: OnResult<Boolean>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<ElssApi, ColorListResponse>(
                ElssApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<ElssApi, ColorListResponse>(activityListener) {
            override fun onSuccess(response: ColorListResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                apiStatus.onResultAvailable(false)
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: ElssApi): Deferred<retrofit2.Response<ColorListResponse>> {
                return api.getColorList(productId)
            }

        })
    }


    fun submitDeviceDetail(
        request: DeviceSubmitRequest,
        onResult: OnResult<DeviceDetailSubmitResponse>,
        apiStatus: OnResult<Boolean>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<ElssApi, DeviceDetailSubmitResponse>(
                ElssApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<ElssApi, DeviceDetailSubmitResponse>(activityListener) {
            override fun onSuccess(response: DeviceDetailSubmitResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                apiStatus.onResultAvailable(false)
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: ElssApi): Deferred<retrofit2.Response<DeviceDetailSubmitResponse>> {
                return api.deviceSubmit(request)
            }

        })
    }


    private fun updateResponse(response: ElssDeviceResponse) {
        var count = 0
        if (response.elssDeviceDetail != null)
            for (obj in response.elssDeviceDetail?.partList!!) {
                if (obj.action != null && obj.action.equals("Repairable")) {
                    response.elssDeviceDetail?.partList!![count].action =
                        ElssAction.REPAIRABLE.actionString
                }
                count++

            }
    }


    fun submitElssDevice(
        elssRequest: SubmitElssRequest?,
        onResult: OnResult<SubmitElssResponse>
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<ElssApi, SubmitElssResponse>(
                ElssApi::class.java,
                mResourceProvider.mContext
            )

        service.execute(object :
            SessionBaseAPICallback<ElssApi, SubmitElssResponse>(activityListener) {
            override fun onSuccess(response: SubmitElssResponse, rawResponse: Response) {
                Log.d(
                    "CASHIFY_API", Gson().toJson(response)
                )
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)

            }

            override fun getAPIAsync(api: ElssApi): Deferred<retrofit2.Response<SubmitElssResponse>> {
                Log.d("CASHIFY_API", Gson().toJson(elssRequest))

                return api.submitElssPart(elssRequest)
            }

        })
    }

    fun getDevicePartList(barcode: String?, onResult: OnResult<DevicePartList>?) {
        //show loader on UI
        activityListener?.showLoading(true)


        val service = UserModuleService<EngineerApi, DevicePartList>(
            EngineerApi::class.java,
            mResourceProvider.mContext
        )

        service.execute(object :
            SessionBaseAPICallback<EngineerApi, DevicePartList>(activityListener) {
            override fun onSuccess(response: DevicePartList, rawResponse: Response) {
                onResult?.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<DevicePartList>> {
                return api.listDeviceParts(barcode)
            }

        })
    }


    fun getMarkL4(barcode: String, onResult: OnResult<MarkL4Response>) {
        activityListener?.showLoading(true)

        val service = UserModuleService<ElssApi, MarkL4Response>(
            ElssApi::class.java,
            mResourceProvider.mContext
        )

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

    fun updateElssRequest(elssRequest: SubmitElssRequest?) {
        var count = 0
        for (obj in elssRequest!!.repairPartList!!) {
            if (obj.action != null && obj.action.equals(ElssAction.REPAIRABLE.actionString)) {
                elssRequest.repairPartList!![count].action = ElssAction.REPAIRABLE.actionString
            }
            count++

        }
    }



    fun uploadImages(
        onResult: OnResult<UploadImageResponse>
    ) {
        activityListener?.showLoading(true)

        val service =
            UserModuleService<ElssApi, UploadImageResponse>(
                ElssApi::class.java,
                mResourceProvider.mContext
            )

        service.execute(object :
            SessionBaseAPICallback<ElssApi, UploadImageResponse>(activityListener) {
            override fun onSuccess(response: UploadImageResponse, rawResponse: Response) {
                Log.d(
                    "CASHIFY_API", Gson().toJson(response)
                )
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)

            }

            override fun getAPIAsync(api: ElssApi): Deferred<retrofit2.Response<UploadImageResponse>> {
                Log.d("CASHIFY_API", Gson().toJson(uploadImagerequest))

                return api.uploadImages(uploadImagerequest)
            }

        })
    }




}