package `in`.cashify.androidtrc.module.elss.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.elss.api.ElssApi
import `in`.cashify.androidtrc.module.elss.api.response.S3ConfigResponse
import `in`.cashify.common_uploader.constant.FileType
import `in`.cashify.common_uploader.utils.ImageQuality
import `in`.cashify.s3_file_uploader.listener.S3FileUploaderListener
import `in`.cashify.s3_file_uploader.uploader.S3FileUploader
import `in`.cashify.s3_file_uploader.uploader.S3FileUploaderConfig
import `in`.reglobe.api.kotlin.exception.APIException
import android.text.TextUtils
import android.util.Log
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import retrofit2.Response
import java.util.*
import javax.inject.Inject
import kotlin.collections.ArrayList

/**
 * Created by Rishika on 24/11/20.
 */
class ElssCaptureImageViewModel @Inject constructor() : BaseViewModel(), S3FileUploaderListener {


    val mFilePathList: Queue<String> = LinkedList()
    val s3PathList = ArrayList<String>()
    var mS3ConfigResponse = MutableLiveData<S3ConfigResponse>()


    var s3UploadSuccessful = MutableLiveData<Boolean>()
    override fun onProgressChanged(p0: Int, p1: Long, p2: Long) {

    }

    override fun startUploading(p0: Int, p1: String?) {
        activityListener?.showLoading(true)
    }

    override fun uploadingSuccess(p0: String?, config: S3FileUploaderConfig?) {

        addS3Path(p0.toString())


    }


    private fun addS3Path(path: String) {
        s3PathList.add(path)

        mFilePathList.poll()
        uploadFileOnS3()
    }

    override fun failedUploading(p0: String?, p1: S3FileUploaderConfig?) {
        Log.d("fail", "fail")
        activityListener?.showLoading(false)
    }

    override fun completeUploading() {
        activityListener?.showLoading(false)
    }


    fun performUpload() {

        if (mS3ConfigResponse.value == null) {
            fetchS3Config(true)
        } else {
            uploadFileOnS3()
        }
    }


    fun fetchS3Config(isUpload: Boolean) {
        val service = UserModuleService<ElssApi, S3ConfigResponse>(
            ElssApi::class.java,
            mResourceProvider.mContext
        )
        activityListener?.showLoading(true)
        service.execute(object :
            SessionBaseAPICallback<ElssApi, S3ConfigResponse>(activityListener) {


            override fun getAPIAsync(api: ElssApi): Deferred<Response<S3ConfigResponse>> {
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

            if (mFilePathList.size <= 0) {
                s3UploadSuccessful.value = true
                return
            }


            // if there is s3 path then do not upload it
            if (mFilePathList.peek().contains("https")) {
                addS3Path(mFilePathList.peek())
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
                .setKey("barcode") // TODO need to change
                .setImgPath(mFilePathList.peek())
                .setFileExtension(
                    mFilePathList.peek().substring(
                        mFilePathList.peek().lastIndexOf('.'),
                        mFilePathList.peek().length
                    )
                )
                .setListener(this)
                .setAccessKey(accessKey)
                .setSecretKey(secretKey)
                .setBucketName(bucketName)
                .setFolderName(folderName)
                .setS3BaseUrl(s3BaseUrl)
                .setLogTag("QcOnsiteExternalAuditor")
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


}