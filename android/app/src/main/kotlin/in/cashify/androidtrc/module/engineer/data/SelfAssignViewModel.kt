package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.SessionBaseAPICallback
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.ReplacePartRequest
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartList
import `in`.cashify.androidtrc.module.engineer.api.response.ReplacePartResponse
import `in`.cashify.androidtrc.util.UIHelper
import `in`.reglobe.api.kotlin.exception.APIException
import androidx.lifecycle.MutableLiveData
import com.google.android.material.snackbar.Snackbar
import de.keyboardsurfer.android.widget.crouton.Style
import kotlinx.coroutines.Deferred
import okhttp3.Response
import javax.inject.Inject

/**
 * Created by Rishika on 20/10/20.
 */
class SelfAssignViewModel @Inject constructor() : BaseViewModel() {

    var openPartBarcodeScanFragment = MutableLiveData<Boolean>()
    var openDeviceBarcodeScanFragment = MutableLiveData<Boolean>()

    var partBarcode = MutableLiveData<String>()
    var deviceBarcode = MutableLiveData<String>()

    var newDeviceBarcode: String? = ""

    var replcaePartResponse = MutableLiveData<ReplacePartResponse>()

    fun replaceParts(partBarCode: String, previousDeviceBarcode: String) {

        val request = ReplacePartRequest()
        request.partBarcode = partBarCode
        request.previousDeviceBarCode = previousDeviceBarcode
        request.newDeviceBarCode = newDeviceBarcode

        activityListener?.showLoading(true)
        val service =
            UserModuleService<EngineerApi, ReplacePartResponse>(
                EngineerApi::class.java,
                mResourceProvider.mContext
            )
        service.execute(object :
            SessionBaseAPICallback<EngineerApi, ReplacePartResponse>(activityListener) {
            override fun onSuccess(response: ReplacePartResponse, rawResponse: Response) {

                replcaePartResponse.value = response

            }

            override fun onFail(e: APIException) {
                activityListener?.showError(getErrorMsg(e))
                replcaePartResponse.value = null
            }

            override fun onComplete() {
                activityListener?.showLoading(false)
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<ReplacePartResponse>> {
                return api.replacePart(request)
            }

        })

    }
}