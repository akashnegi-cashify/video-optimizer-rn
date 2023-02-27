package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.inventory_manager.api.InventoryManagerApi
import `in`.cashify.androidtrc.module.inventory_manager.api.request.AssignedDeviceListRequest
import `in`.cashify.androidtrc.module.inventory_manager.api.request.EngineerListRequest
import `in`.cashify.androidtrc.module.inventory_manager.api.request.PendingDeliveryDevicePartRequest
import `in`.cashify.androidtrc.module.inventory_manager.api.request.RiderAssignRequest
import `in`.cashify.androidtrc.module.inventory_manager.api.response.*
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.annotation.Keep
import androidx.lifecycle.MutableLiveData
import kotlinx.coroutines.Deferred
import okhttp3.Response
import java.util.*
import javax.inject.Inject

@Keep
class InventoryManagerViewModel @Inject constructor() : BaseViewModel() {


    var pendindDeviceListResponse = MutableLiveData<PendingDeviceListResponse>()
    var pendingDeviceShowLoading = MutableLiveData<Boolean>()
    var assignedDeviceListResponse = MutableLiveData<AssignedDeviceListResponse>()
    var assignedDeviceShowLoading = MutableLiveData<Boolean>()
    var timer: Timer? = null
    val DELAY: Long = 500 // in ms
    var isShowNoDataDialog = MutableLiveData<Boolean>()
    var refreshAssignDevice = MutableLiveData<Boolean>()
    var groupListResponse = MutableLiveData<GroupListResponse>()
    var selectedGroups = ""
    var engineerListResponse = MutableLiveData<EngineerListResponse>()
    var pendingEngineerShowLoading = MutableLiveData<Boolean>()

    init {
        isShowNoDataDialog.value = false
        refreshAssignDevice.value = false
    }

    fun getPendingDeviceList(
        pno: Int,
        ln: Int,
        br: String?,
        isUrgent: Boolean,
        isScanner: Boolean = false,
        e_id: Int?
    ) {


        val request = PendingDeliveryDevicePartRequest().apply {
            this.pno = pno
            this.ln = ln
            this.br = br
            this.fp = PendingDeliveryDevicePartRequest.FacilityPart().apply {
                this.is_urgent = isUrgent
                this.eid = e_id
            }

        }

        pendingDeviceShowLoading.value = true
        val service =
            UserModuleService<InventoryManagerApi, PendingDeviceListResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, PendingDeviceListResponse>(activityListener) {
            override fun onSuccess(response: PendingDeviceListResponse, rawResponse: Response) {


                if (response.data!!.dataList == null || response.data?.dataList!!.size <= 0) {
                    isShowNoDataDialog.value = isScanner
                }



                pendindDeviceListResponse.value = response

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                pendingDeviceShowLoading.value = false
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<PendingDeviceListResponse>> {
                return api.getPendingDeviceList(request)
            }

        })


    }


    fun getAssignedDeviceList(
        pno: Int,
        ln: Int,
        br: String?,
        isUrgent: Boolean,
        isScanner: Boolean = false
    ) {
        val request = AssignedDeviceListRequest().apply {
            this.pno = pno
            this.ln = ln
            this.br = br
            this.fp = AssignedDeviceListRequest.FacilityPart().apply {
                this.is_urgent = isUrgent
            }
        }

        assignedDeviceShowLoading?.value = true
        val service =
            UserModuleService<InventoryManagerApi, AssignedDeviceListResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, AssignedDeviceListResponse>(activityListener) {
            override fun onSuccess(response: AssignedDeviceListResponse, rawResponse: Response) {
                if (response.data!!.dataList == null || response.data?.dataList!!.size <= 0) {
                    isShowNoDataDialog.value = isScanner
                }
                assignedDeviceListResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                assignedDeviceShowLoading.value = false
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<AssignedDeviceListResponse>> {
                return api.getassignedPendingDevices(request)
            }

        })


    }


    fun getListOfRiders(onResult: OnResult<RiderListResponse>, br: String) {


        assignedDeviceShowLoading?.value = true
        val service =
            UserModuleService<InventoryManagerApi, RiderListResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, RiderListResponse>(activityListener) {
            override fun onSuccess(response: RiderListResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                assignedDeviceShowLoading.value = false
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<RiderListResponse>> {
                return api.getListOfRiders(br)
            }

        })


    }


    fun assignRider(rid: Int?, list: ArrayList<Int>?, onResult: OnResult<RiderAssignResponse>) {
        val request = RiderAssignRequest().apply {
            this.riderId = rid
            this.dataList = list
        }

        activityListener?.showLoading(true)
        val service =
            UserModuleService<InventoryManagerApi, RiderAssignResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, RiderAssignResponse>(activityListener) {
            override fun onSuccess(response: RiderAssignResponse, rawResponse: Response) {
                onResult.onResultAvailable(response)
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<RiderAssignResponse>> {
                return api.assignRider(request)
            }

        })


    }


    fun groupList() {


        activityListener?.showLoading(true)

        val service =
            UserModuleService<InventoryManagerApi, GroupListResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, GroupListResponse>(activityListener) {
            override fun onSuccess(response: GroupListResponse, rawResponse: Response) {
                groupListResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {

                activityListener?.showLoading(false)

            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<GroupListResponse>> {
                return api.groupList()
            }

        })


    }

    fun engineerList(
        pno: Int,
        ln: Int,
    ) {
        val request = EngineerListRequest().apply {
            this.pno = pno
            this.ln = ln
            this.fp = EngineerListRequest.FacilityPart().apply {
                this.location_group = selectedGroups

            }
        }

        pendingEngineerShowLoading.value = true

        val service =
            UserModuleService<InventoryManagerApi, EngineerListResponse>(
                InventoryManagerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<InventoryManagerApi, EngineerListResponse>(activityListener) {
            override fun onSuccess(response: EngineerListResponse, rawResponse: Response) {
                engineerListResponse.value = response
            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
            }

            override fun onComplete() {

                pendingEngineerShowLoading.value = false

            }

            override fun getAPIAsync(api: InventoryManagerApi): Deferred<retrofit2.Response<EngineerListResponse>> {
                return api.engineerList(request)
            }

        })
    }

}