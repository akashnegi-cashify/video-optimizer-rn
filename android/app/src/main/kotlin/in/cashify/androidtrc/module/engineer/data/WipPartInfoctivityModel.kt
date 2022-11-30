package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.elss.api.response.S3ConfigResponse
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.CancelPartResponse
import `in`.cashify.androidtrc.module.engineer.api.response.ConsumePartResponse
import `in`.cashify.androidtrc.module.engineer.api.response.ReceivedPartResponse
import `in`.cashify.androidtrc.module.engineer.api.response.ReturnReasonList
import `in`.cashify.common_uploader.constant.FileType
import `in`.cashify.common_uploader.utils.ImageQuality
import `in`.cashify.s3_file_uploader.listener.S3FileUploaderListener
import `in`.cashify.s3_file_uploader.uploader.S3FileUploader
import `in`.cashify.s3_file_uploader.uploader.S3FileUploaderConfig
import `in`.reglobe.api.kotlin.exception.APIException
import android.util.Log
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class WipPartInfoctivityModel @Inject constructor() : BaseViewModel(), S3FileUploaderListener {

    var mS3ConfigResponse = MutableLiveData<S3ConfigResponse>()
    var imageS3Link = MutableLiveData<String>()
    var imagePath = ""

    override fun onProgressChanged(p0: Int, p1: Long, p2: Long) {

    }

    override fun startUploading(p0: Int, p1: String?) {
        activityListener?.showLoading(true)
    }

    override fun uploadingSuccess(p0: String?, config: S3FileUploaderConfig?) {
        imageS3Link.value = p0.toString()
    }


    override fun failedUploading(p0: String?, p1: S3FileUploaderConfig?) {
        Log.d("fail", "fail")
        activityListener?.showLoading(false)
    }

    override fun completeUploading() {
        activityListener?.showLoading(false)
    }


    fun performUpload(imagePath: String) {
        this.imagePath = imagePath
        if (mS3ConfigResponse.value == null) {
            fetchS3Config(true)
        } else {
            uploadFileOnS3()
        }
    }


    fun fetchS3Config(isUpload: Boolean) {
        val service = UserModuleService<EngineerApi, S3ConfigResponse>(
            EngineerApi::class.java,
            mResourceProvider.mContext
        )
        activityListener?.showLoading(true)
        service.execute(object :
            SessionBaseAPICallback<EngineerApi, S3ConfigResponse>(activityListener) {


            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<S3ConfigResponse>> {
                return api.getS3Config()
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
                activityListener?.showLoading(false)
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun onSuccess(response: S3ConfigResponse, rawResponse: okhttp3.Response) {
                mS3ConfigResponse.value = response
                if (isUpload) {
                    uploadFileOnS3()
                }
            }

        })
    }


    private fun uploadFileOnS3() {
        try {

            if (imagePath.equals("")) {
                return
            }

            val fileType = FileType.IMAGE
            val accessKey: String = mS3ConfigResponse.value?.data?.accessKey.toString()
            val secretKey: String = mS3ConfigResponse.value?.data?.secretKey.toString()
            val bucketName: String = mS3ConfigResponse.value?.data?.bucketName.toString()
            val folderName: String = mS3ConfigResponse.value?.data?.folderName.toString()
            val s3BaseUrl: String = mS3ConfigResponse.value?.data?.url.toString()

            val mFileUploaderConfig = S3FileUploaderConfig.Builder()
                .setContext(mResourceProvider.mContext)
                .setKey("part_image")
                .setImgPath(imagePath)
                .setFileExtension(imagePath.substring(imagePath.lastIndexOf('.'),imagePath.length))
                .setListener(this)
                .setAccessKey(accessKey)
                .setSecretKey(secretKey)
                .setBucketName(bucketName)
                .setFolderName(folderName)
                .setS3BaseUrl(s3BaseUrl)
                .setLogTag("TRCEngineerPartImage")
                .setNeedS3CompleteUrl(true)
                .setFileType(fileType)
                .setTwoStepUpload(false)
                .setImageQuality(ImageQuality.HIGH)
                .setDeleteUploadedImage(false)
                .setPublicReadAccess(true)
                .build()
            val s3FileUploader = S3FileUploader.getInstance()
                .initialize(accessKey, secretKey)
            s3FileUploader.uploadFile(mFileUploaderConfig)
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }


    fun returnPartReason(onResult: OnResult<ReturnReasonList?>) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, ReturnReasonList>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<EngineerApi, ReturnReasonList>(activityListener) {
            override fun onSuccess(response: ReturnReasonList, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<ReturnReasonList>> {
                return api.listReasons()
            }

        })
    }


    fun consumePart(barcode: String?, pid: String?, prid: Int?, onResult: OnResult<Boolean>, imgS3Url: String) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, ConsumePartResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        Log.e("myDebug", barcode + "    "+pid +"     "+ prid + "   ${imgS3Url}")
        onResult.onResultAvailable(true)
         service.execute(object :
             SessionBaseAPICallback<EngineerApi, ConsumePartResponse>(activityListener) {
             override fun onSuccess(response: ConsumePartResponse, rawResponse: Response) {
                 if (response.isSucess) {
                     onResult.onResultAvailable(true)
                 } else {
                     activityListener?.showError(response.errorMsg)
                 }
             }

             override fun onFail(e: APIException) {
                 activityListener?.showError(getErrorMsg(e))
             }

             override fun onComplete() {
                 activityListener?.showLoading(false)
             }

             override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<ConsumePartResponse>> {
                 return api.consumePart(barcode,pid, prid.toString(),imgS3Url)
             }

         })
    }


    fun getReceivePartByEngineer(
        onResult: OnResult<ReceivedPartResponse>, partId: String, pbr: String, prid: String
    ) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, ReceivedPartResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<EngineerApi, ReceivedPartResponse>(activityListener) {
            override fun onSuccess(response: ReceivedPartResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<ReceivedPartResponse>> {
                return api.getReceivePartByEngineer(partId, pbr, prid)
            }

        })
    }


    fun cancelPart(onResult: OnResult<CancelPartResponse>, prid: String) {

        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, CancelPartResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<EngineerApi, CancelPartResponse>(activityListener) {
            override fun onSuccess(response: CancelPartResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<CancelPartResponse>> {
                return api.cancelPart(prid)
            }

        })


    }
}