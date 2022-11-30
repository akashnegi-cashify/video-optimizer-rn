package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.CancelPartResponse
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartList
import `in`.cashify.androidtrc.module.engineer.api.response.ReceivedPartResponse
import `in`.cashify.androidtrc.util.CommonConstant
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

class EngDevicePartAssignedListViewModel  @Inject constructor() : BaseViewModel() {
    val partList = MutableLiveData<List<EngineerPartInfo>>()
//    var engPartListListener: EngPartListActivityListener? = null

//    var engPartListListener: EngPartListActivityListener? = null
    var did:String?=null



    init {

    }


    fun getEngPartInfoList(did: String) {
        this.did = did
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, EngineerPartList>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, EngineerPartList>(activityListener) {
            override fun onSuccess(response: EngineerPartList, rawResponse: Response) {
                partList.value = response.partInfoList
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



    fun cancelPart(onResult: OnResult<CancelPartResponse>, prid: String ){

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

    fun getReceivePartByEngineer(
        onResult: OnResult<ReceivedPartResponse>, partId: String, pbr : String, prid:String
    ){
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
                return api.getReceivePartByEngineer(partId , pbr , prid)
            }

        })
    }






}