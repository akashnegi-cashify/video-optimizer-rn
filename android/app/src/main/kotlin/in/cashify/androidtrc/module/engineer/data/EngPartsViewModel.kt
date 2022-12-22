package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.engineer.adapter.PartInfoPagerAdapter
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.CancelPartResponse
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartList
import `in`.cashify.androidtrc.module.engineer.api.response.ReceivedPartResponse
import `in`.cashify.androidtrc.util.CommonConstant
import `in`.reglobe.api.kotlin.exception.APIException
import android.content.DialogInterface
import androidx.appcompat.app.AlertDialog
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class EngPartsViewModel @Inject constructor() : BaseViewModel() {

    var adapter: PartInfoPagerAdapter? = null

    val partList = MutableLiveData<List<EngineerPartInfo>>()
    var engPartListListener: EngPartListActivityListener? = null


    val viewModel = null


    init {
        partList.value = emptyList()
    }


    fun createPartPagerAdapter(fragmentManager: FragmentManager, numOfTabs: Int) {
        adapter = PartInfoPagerAdapter(fragmentManager, numOfTabs)
    }

    fun makeRequest(position: Int) {

        var status: String = ""

        when(position){
            0-> status = CommonConstant.ENGINEER_RECEIVED_PARTS
            1-> status = CommonConstant.ENGINEER_CONSUMED_PARTS
            2-> status = CommonConstant.ENGINEER_REQUESTED_PARTS
            3-> status = CommonConstant.ENGINEER_ALLOWED_PARTS
        }
        getEngPartInfoList(status)
    }

    fun getEngPartInfoList(status: String) {
        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, EngineerPartList>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, EngineerPartList>(activityListener) {
            override fun onSuccess(response: EngineerPartList, rawResponse: Response) {
                adapter?.changeDataSet(response.partInfoList)
            }

            override fun onFail(e: APIException) {
                adapter?.changeDataSet(null)
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<EngineerPartList>> {
                return api.getEngineerParts(status)
            }

        })

    }

    fun getReceivePartByEngineer(
            onResult: OnResult<ReceivedPartResponse>, partId: String ,pbr : String, prid:String
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



    fun cancelPart( onResult: OnResult<CancelPartResponse>, prid: String ){

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