package `in`.cashify.androidtrc.module.engineer.view_report.data

import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.JWTParser
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.engineer.adapter.PartInfoPagerAdapter
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartList
import `in`.cashify.androidtrc.module.engineer.api.response.OrderDevicePartResponse
import `in`.cashify.androidtrc.module.engineer.view_report.adapter.ViewReportPagerAdapter
import `in`.cashify.androidtrc.module.engineer.view_report.api.EngineerDeviceReportReponse
import `in`.cashify.androidtrc.module.engineer.view_report.api.EngineerPartReportResponse
import `in`.cashify.androidtrc.module.engineer.view_report.api.LeadEngineerDeviceReportResponse
import `in`.cashify.androidtrc.module.engineer.view_report.api.LeadEngineerPartReportResponse
import `in`.cashify.androidtrc.module.login.api.LoginModuleApi
import `in`.cashify.androidtrc.module.login.api.PasswordLoginRequest
import `in`.cashify.androidtrc.module.login.api.PasswordLoginResponse
import `in`.cashify.androidtrc.module.login.api.UserDetailResponse
import `in`.reglobe.api.kotlin.exception.APIException
import `in`.reglobe.cashify.util.DeviceInfoManager
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.MutableLiveData
import com.google.gson.Gson
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

/**
 * Created by Rishika on 04/12/20.
 */
class ViewReportViewModel @Inject constructor() : BaseViewModel() {
    var adapter: ViewReportPagerAdapter? = null


    var hideDeviceReportLoading = MutableLiveData<Boolean>()
    var hidePartReportLoading = MutableLiveData<Boolean>()


    fun createPartPagerAdapter(fragmentManager: FragmentManager, numOfTabs: Int) {
        adapter = ViewReportPagerAdapter(fragmentManager, numOfTabs)
    }


    fun deviceReport(
        startDate: String,
        endDate: String,
        onResult: OnResult<EngineerDeviceReportReponse>
    ) {
//        activityListener?.showLoading(true)

        hideDeviceReportLoading.value = false
        val service =
            UserModuleService<EngineerApi, EngineerDeviceReportReponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, EngineerDeviceReportReponse>(activityListener) {
            override fun onSuccess(response: EngineerDeviceReportReponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                hideDeviceReportLoading.value = true
//                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<EngineerDeviceReportReponse>> {
                return api.engineerDeviceReport(startDate, endDate)
            }

        })
    }


    fun leadEngineerDeviceReport(

        onResult: OnResult<LeadEngineerDeviceReportResponse>
    ) {
//        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, LeadEngineerDeviceReportResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, LeadEngineerDeviceReportResponse>(activityListener) {
            override fun onSuccess(response: LeadEngineerDeviceReportResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
//                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<LeadEngineerDeviceReportResponse>> {
                return api.leadEngineerDeviceReport()
            }

        })
    }




    fun partReport(
        startDate: String,
        endDate: String,
        onResult: OnResult<EngineerPartReportResponse>
    ) {
//        activityListener?.showLoading(true)

        hidePartReportLoading.value = false
        val service =
            UserModuleService<EngineerApi, EngineerPartReportResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, EngineerPartReportResponse>(activityListener) {
            override fun onSuccess(response: EngineerPartReportResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                hidePartReportLoading.value = true
//               activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<EngineerPartReportResponse>> {
                return api.engineerPartReport(startDate, endDate)
            }

        })
    }



    fun leadEngineerPartReport(

        onResult: OnResult<LeadEngineerPartReportResponse>
    ) {
       activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, LeadEngineerPartReportResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object : SessionBaseAPICallback<EngineerApi, LeadEngineerPartReportResponse>(activityListener) {
            override fun onSuccess(response: LeadEngineerPartReportResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<LeadEngineerPartReportResponse>> {
                return api.leadEngineerPartReport()
            }

        })
    }






}