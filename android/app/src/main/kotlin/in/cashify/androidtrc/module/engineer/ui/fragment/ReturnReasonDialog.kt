package `in`.cashify.androidtrc.module.engineer.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.api.UserModuleService
import `in`.cashify.androidtrc.common.api.callback.BaseAPICallback
import `in`.cashify.androidtrc.module.engineer.api.EngineerApi
import `in`.cashify.androidtrc.module.engineer.api.response.*
import `in`.cashify.androidtrc.module.engineer.ui.activity.OnPartReturn
import `in`.reglobe.api.kotlin.exception.APIException
import android.app.Dialog
import android.content.Context
import android.os.Bundle
import android.view.*
import android.widget.*
import androidx.fragment.app.DialogFragment
import kotlinx.coroutines.Deferred
import okhttp3.Response


/**
 * Created by Avaneesh Maurya on 31,Agosto,2019
 */
class ReturnReasonDialog : DialogFragment(), View.OnClickListener,
    AdapterView.OnItemSelectedListener {

    override fun onNothingSelected(parent: AdapterView<*>?) {


    }

    override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
        if (position == 0) {
            return
        }
        val item = parent?.getItemAtPosition(position)
        if (item is String) {
            returnReasonResponse = item
        }
    }

    override fun onClick(v: View?) {
        when (v?.id) {
            R.id.btn_cancel -> {
                dismissAllowingStateLoss()
            }
            R.id.btn_okay -> {
                val returnData = ReturnPartData()
                returnData.partBarcode = mPartInfo?.partBarcode
                returnData.remark = mEtRemark?.text.toString().trim()
                returnData.returnReason = returnReasonResponse
                returnData.partId = mPartInfo?.partId.toString()
                returnData.prid = mPartInfo?.prid
                returnPart(returnData)
            }
        }
    }

    private var mProgressBar: ProgressBar? = null
    var mPartInfo: EngineerPartInfo? = null
    var returnReasonList: ReturnReasonList? = null
    var mEtRemark: EditText? = null
    var returnReasonResponse: String? = null
    var mOnPartReturn: OnPartReturn? = null

    override fun onCreateDialog(savedInstanceState: Bundle?): Dialog {
        val dialog = super.onCreateDialog(savedInstanceState)
        dialog.window?.apply {
            requestFeature(Window.FEATURE_NO_TITLE)
        }
        return dialog
    }

    override fun onAttach(context: Context) {
        super.onAttach(context)
        if (context is OnPartReturn) {
            mOnPartReturn = context
        }
    }

    fun returnPart(returnData: ReturnPartData?) {
        if (context == null) {
            return
        }
        mProgressBar?.visibility = View.VISIBLE
        val service =
            UserModuleService<EngineerApi, ReturnPartResponse>(
                EngineerApi::class.java,
                context!!
            )
        service.execute(object :
            BaseAPICallback<EngineerApi, ReturnPartResponse>() {
            override fun onFailure(e: APIException) {

            }

            override fun onSuccess(response: ReturnPartResponse, rawResponse: Response) {
                mOnPartReturn?.onPartReturned(response)
                dismissAllowingStateLoss()
            }

            override fun onComplete() {
                mProgressBar?.visibility = View.GONE
            }

            override fun getAPIAsync(api: EngineerApi): Deferred<retrofit2.Response<ReturnPartResponse>> {
                return api.returnPart(returnData)
            }

        })
    }


    override fun onStart() {
        super.onStart()
        dialog?.window?.apply {
            setGravity(Gravity.BOTTOM)
            attributes?.windowAnimations = R.style.DialogUpDownAnimation
            setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mPartInfo = arguments?.getParcelable(KEY_PART_INFO)
        returnReasonList = arguments?.getParcelable(KEY_RETURN_REASON)
    }


    override fun onActivityCreated(savedInstanceState: Bundle?) {
        super.onActivityCreated(savedInstanceState)
        dialog?.window?.apply {
            setGravity(Gravity.BOTTOM)
            isCancelable = false
            attributes?.windowAnimations = R.style.DialogUpDownAnimation
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.return_reason_dialog, container, false)
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val spinner = view.findViewById<Spinner>(R.id.spinner)
        val reasonList = returnReasonList?.reasonList
        reasonList?.add(0, getString(R.string.choose_your_response))
        if (context == null || reasonList == null) {
            return
        }
        val adapter = ArrayAdapter<String>(
            context!!,
            R.layout.simple_spinner_item, reasonList

        )
        adapter.setDropDownViewResource(R.layout.spinner_dropdown_item)
        spinner.setAdapter(adapter)
        spinner.onItemSelectedListener = this
        mEtRemark = view.findViewById(R.id.et_remark)
        view.findViewById<Button>(R.id.btn_cancel).setOnClickListener(this)
        view.findViewById<Button>(R.id.btn_okay).setOnClickListener(this)
        val tvLine1 = view.findViewById<TextView>(R.id.tv_line_1)
        val tvLine2 = view.findViewById<TextView>(R.id.tv_line_2)
        val tvLine3 = view.findViewById<TextView>(R.id.tv_line_3)
        mProgressBar = view.findViewById(R.id.pb_progress)

        tvLine1.text = resources.getString(R.string.device_barcode) + mPartInfo?.deviceBarcode
        tvLine2.text = resources.getString(R.string.device_name) + mPartInfo?.deviceName
        tvLine3.text = resources.getString(R.string.part_name) + mPartInfo?.partName

    }

    companion object {
        const val KEY_PART_INFO = "key_part_info"
        const val KEY_RETURN_REASON = "jey_return_reason"
        fun newInstance(
            partInfo: EngineerPartInfo?,
            returnReasonList: ReturnReasonList?
        ): ReturnReasonDialog {
            val args = Bundle()
            args.putParcelable(KEY_PART_INFO, partInfo)
            args.putParcelable(KEY_RETURN_REASON, returnReasonList)
            val returnReasonDialog = ReturnReasonDialog()
            returnReasonDialog.arguments = args
            return returnReasonDialog
        }
    }
}