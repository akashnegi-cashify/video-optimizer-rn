package `in`.cashify.androidtrc.module.elss.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.ActivityElssPartSelectionBinding
import `in`.cashify.androidtrc.module.elss.adapter.ElssActionOptionsAdapter
import `in`.cashify.androidtrc.module.elss.adapter.ElssDeviceIssueAdapter
import `in`.cashify.androidtrc.module.elss.adapter.SkuPartPnaAdapter
import `in`.cashify.androidtrc.module.elss.api.response.*
import `in`.cashify.androidtrc.module.elss.data.*
import `in`.cashify.androidtrc.module.elss.ui.PnaPartSelectionDialog
import `in`.cashify.androidtrc.module.elss.ui.ProceedClickDialogImpl
import `in`.cashify.androidtrc.module.elss.ui.fragment.ElssAddPartDialog
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartList
import `in`.cashify.androidtrc.util.UIHelper
import android.annotation.SuppressLint
import android.app.Activity
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.os.Parcelable
import android.text.*
import android.util.Log
import android.view.View
import android.widget.EditText
import android.widget.LinearLayout
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.bottomsheet.BottomSheetBehavior
import de.keyboardsurfer.android.widget.crouton.Style
import java.util.*


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
class ElssPartSelectionActivity : BaseActivity(), View.OnClickListener, OnElssActionHappen,
    OnPartAdded, ElssActionOptionsAdapter.OnItemClickListener, SkuPartPnaAdapter.OnCheckBoxClickListener, ProceedClickDialogImpl {

    var elssOptionList = ArrayList<ElssOptionList>()
    override fun getLayoutResId(): Int {
        return R.layout.activity_elss_part_selection
    }


    private var actionSelected = 0
    private var partList: java.util.ArrayList<ElssPart>? = null
    private var isRubbingApplicableFlag = false
    private var isPnaApplicableFlag = false
     var isPNAPartSelectionEnable = false
     var isPNAPartSelectionApplied:Boolean? = null
    private var isGcApplicableFlag = false
    private var mSearchPartList: ArrayList<ElssPart>? = null
    private lateinit var bottomSheetBehavior: BottomSheetBehavior<LinearLayout>
    private lateinit var binding: ActivityElssPartSelectionBinding
     lateinit var viewModel: ElssViewModel
    private var elssResponse: ElssDeviceResponse? = null

    private var deviceIssueAdapter = ElssDeviceIssueAdapter()

    private var elssOptionAdapter: ElssActionOptionsAdapter? = null


    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProvider(this, factory).get(ElssViewModel::class.java)
        binding.lifecycleOwner = this
        binding.viewModel = viewModel
        viewModel.activityListener = this
        bottomSheetBehavior = BottomSheetBehavior.from(binding.bottomView.bottomSheetLayout)
        bottomSheetBehavior.isHideable = false


        //set listeners..
        binding.ivClear.setOnClickListener(this)
        binding.addPartContainer.setOnClickListener(this)
        binding.bottomView.selectedButton.setOnClickListener(this)

        binding.etSearchView.addTextChangedListener(textWatcher)
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ELSS_PART_SELECTION, null, null, true)


        //get data from intent...
        elssResponse = intent.getParcelableExtra(KEY_DETAIL)
        viewModel.elssDeviceDetail.value = elssResponse

        getElssDeviceOptions(intent.getStringExtra(DEVICE_BARCODE) ?: "")


        if (TextUtils.isEmpty(elssResponse?.elssDeviceDetail?.requestReason)) {
            binding.lblRmsRemarks.visibility = View.GONE
            binding.tvRmsRemarks.visibility = View.GONE
        } else {
            binding.lblRmsRemarks.visibility = View.VISIBLE
            binding.tvRmsRemarks.visibility = View.VISIBLE
            binding.tvRmsRemarks.setText(elssResponse?.elssDeviceDetail?.requestReason)
        }


        if (elssResponse?.elssDeviceDetail?.repairReasonList == null || elssResponse?.elssDeviceDetail?.repairReasonList?.size!! == 0) {
            binding.tvDeviceIssues.visibility = View.GONE
            binding.reclDeviceIssue.visibility = View.GONE
        } else {
            binding.tvDeviceIssues.visibility = View.VISIBLE
            binding.reclDeviceIssue.visibility = View.VISIBLE
            binding.reclDeviceIssue.layoutManager = LinearLayoutManager(this)
            binding.reclDeviceIssue.adapter = deviceIssueAdapter
            deviceIssueAdapter.setData(
                elssResponse?.elssDeviceDetail?.repairReasonList ?: ArrayList<String>()
            )
        }

        //set layout manager to recycler view
        binding.rvParts.layoutManager = LinearLayoutManager(this, RecyclerView.VERTICAL, false)

        //create Adapter instance and attach listener...
        viewModel.createAdapter()
        viewModel.adapter?.setElssActionListener(this)

        //pass adapter to recycler view...
        binding.rvParts.adapter = viewModel.adapter
        viewModel.adapter?.changeDataSet(elssResponse?.elssDeviceDetail?.partList)

        //bind data with view...
        binding.tvLine1.text = "Device Name: " + elssResponse?.elssDeviceDetail?.deviceName
        binding.tvLine2.text = "Repair Type: " + elssResponse?.elssDeviceDetail?.deviceRepairType
        binding.tvLine3.text = "Device Barcode: " + elssResponse?.elssDeviceDetail?.deviceBarcode
        binding.tvLine4.text = "Device Color: " + elssResponse?.elssDeviceDetail?.deviceColor
        binding.tvImei.text = "Device IMEI: " + elssResponse?.elssDeviceDetail?.imeiNumber

        setTitle("Part Selection")

    }

    fun getElssDeviceOptions(barcode: String) {

        if (barcode == "") {
            return
        }
        // scannerFragment.pauseScanner()

        viewModel.getElssDeviceActionOptions(barcode, object : OnResult<ElssOptionResponse> {
            override fun onResultAvailable(data: ElssOptionResponse) {
                if (data.isSuccess) {
                    showLoading(false)
                    data.list?.let {
                        initOptionsList(data)
                    }
                } else {
                    showError(data.errorMsg)
                }
            }
        }, object : OnResult<Boolean> {
            override fun onResultAvailable(data: Boolean) {


            }
        })
    }


    private fun initOptionsList(data: ElssOptionResponse) {
        data.let { it?.list?.let { it1 -> elssOptionList.addAll(it1) } }

        binding.bottomView.rvElssOptions.setLayoutManager(LinearLayoutManager(this, LinearLayoutManager.VERTICAL, true))
        elssOptionAdapter = ElssActionOptionsAdapter(elssOptionList, this)
        binding.bottomView.rvElssOptions.adapter = elssOptionAdapter

        when (elssResponse?.elssDeviceDetail?.deviceRepairType) {
            ElssRepairType.BULK.repairType -> {
                Log.e("BULK.repairType ","")
                elssOptionList.forEach {
                    if (it.key == ElssOptions.ACCEPT.value) it.isVisible = true
                    if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                    if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible = false
                    if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible = true
                }
                elssOptionAdapter?.notifyDataSetChanged()
            }

            ElssRepairType.WARRANTY.repairType -> {
                Log.e("WARRANTY.repairType ","")
                elssOptionList.forEach {
                    if (it.key == ElssOptions.ACCEPT.value) it.isVisible = true
                    if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                    if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible = true

                    if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible = false
                }
                elssOptionAdapter?.notifyDataSetChanged()
            }
            ElssRepairType.MARK_DEAD.repairType -> {
                Log.e("MARK_DEAD.repairType ","")
                elssOptionList.forEach {
                    if (it.key == ElssOptions.ACCEPT.value) it.isVisible = false
                    if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                    if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                        true
                    if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible = true
                }
                elssOptionAdapter?.notifyDataSetChanged()
            }

        }

    }


    /**
     * on click listener callback
     */
    override fun onClick(v: View?) {
        when (v?.id) {

            binding.addPartContainer.id -> {
                handleAddPartContainer()
            }

            binding.bottomView.selectedButton.id -> {

                if (isPNAPartSelectionEnable && isPNAPartSelectionApplied==null) {
                    openSKUPartMarkPNADialog()
                } else {
                    handleSelectedButton()
                }
            }
            binding.ivClear.id -> {
                clearFilter()
            }
        }

    }

    private fun clearFilter() {
        binding.etSearchView.setText("")
    }

    private fun handleSelectedButton() {

        elssOptionList.forEach {
            if (it.name?.equals(binding.bottomView.selectedButton.text.toString(), true) == true) {

                if (it.key == ElssOptions.DECLINE.value) {
                    showDeclineDialog(
                        "Decline",
                        "Please Enter Remark",
                        it.name ?: ""
                    )
                } else if (it.key == ElssOptions.SEND_TO_L4.value) {

                    submitGetMarkL4("Send to L4")

                } else {
                    submitElss(it.name ?: "")
                }
            }
        }

    }


    private fun handleAddPartContainer() {
        viewModel.getDevicePartList(
            elssResponse?.elssDeviceDetail?.deviceBarcode,
            object : OnResult<DevicePartList> {
                override fun onResultAvailable(data: DevicePartList) {
                    if (data.isSuccess != null && data.isSuccess!!) {
                        val partList = data.partInfoList
                        if (partList.isNullOrEmpty()) {
                            UIHelper.showSnackBar(
                                this@ElssPartSelectionActivity,
                                "Part list is empty",
                                Style.ALERT,
                                null
                            )
                        }
                        showBottomDialog(
                            this@ElssPartSelectionActivity,
                            ElssAddPartDialog.newInstance(partList),
                            "ReturnReasonDialog"
                        )

                    }
                }
            })
    }

    private fun submitGetMarkL4(repairType: String) {
        showAlertDialog(repairType, "OK",
            DialogInterface.OnClickListener { _, _ ->
                requestToSubmit(
                    repairType,
                    null,
                    true
                )
            },
            "Cancel", DialogInterface.OnClickListener { dialog, _ -> dialog?.dismiss() })
    }


    companion object {
        const val KEY_DETAIL = "key_detail"
        const val DEVICE_BARCODE = "device_barcode"
    }


    override fun onElssActionHappen(action: ElssAction) {
        when (elssResponse?.elssDeviceDetail?.deviceRepairType) {
            ElssRepairType.BULK.repairType -> {
                when (action) {
                    ElssAction.REPAIRABLE -> {
                        Log.e("REPAIRABLE  BULK","")
                        elssOptionList.forEach {
                            if (it.key == ElssOptions.ACCEPT.value) it.isVisible = true
                            if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                            if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                                false
                            if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible = true
                        }
                        elssOptionAdapter?.notifyDataSetChanged()

                    }

                    ElssAction.NOT_REPAIRABLE -> {
                        Log.e("NOT_REPAIRABLE  BULK","")
                        elssOptionList.forEach {
                            if (it.key == ElssOptions.ACCEPT.value) it.isVisible = true
                            if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                            if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                                false
                            if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible =
                                false
                        }
                        elssOptionAdapter?.notifyDataSetChanged()

                    }

                    ElssAction.NOT_REQUIRED -> {
                        Log.e("NOT_REQUIRED  BULK","")
                        elssOptionList.forEach {
                            if (it.key == ElssOptions.ACCEPT.value) it.isVisible = true
                            if (it.key == ElssOptions.DECLINE.value) it.isVisible = false
                            if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                                false
                            if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible = true
                        }
                        elssOptionAdapter?.notifyDataSetChanged()

                    }
                }

            }

            ElssRepairType.WARRANTY.repairType -> {
                when (action) {
                    ElssAction.REPAIRABLE -> {
                        Log.e("REPAIRABLE  WARRANTY","")
                        elssOptionList.forEach {
                            if (it.key == ElssOptions.ACCEPT.value) it.isVisible = true
                            if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                            if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                                false

                            if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible =
                                false
                        }
                        elssOptionAdapter?.notifyDataSetChanged()
                    }
                    ElssAction.NOT_REPAIRABLE -> {
                        Log.e("NOT_REPAIRABLE WARRANTY","")
                        elssOptionList.forEach {
                            if (it.key == ElssOptions.ACCEPT.value) it.isVisible = false
                            if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                            if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                                true

                            if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible =
                                false
                        }
                        elssOptionAdapter?.notifyDataSetChanged()

                    }
                    ElssAction.NOT_REQUIRED -> {
                        Log.e("NOT_REQUIRED  WARRANTY","")
                        elssOptionList.forEach {
                            if (it.key == ElssOptions.ACCEPT.value) it.isVisible = true
                            if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                            if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                                true

                            if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible =
                                false
                        }
                        elssOptionAdapter?.notifyDataSetChanged()
                    }
                }
            }

            ElssRepairType.MARK_DEAD.repairType -> {
                when (action) {
                    ElssAction.REPAIRABLE -> {
                        Log.e("MARK_DEAD  MARK_DEAD","")
                        elssOptionList.forEach {
                            if (it.key == ElssOptions.ACCEPT.value) it.isVisible = false
                            if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                            if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                                true
                            if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible = true
                        }
                        elssOptionAdapter?.notifyDataSetChanged()

                    }

                    ElssAction.NOT_REPAIRABLE -> {
                        Log.e("NOT_REPAIRABLE MARKDEAD","")
                        elssOptionList.forEach {
                            if (it.key == ElssOptions.ACCEPT.value) it.isVisible = false
                            if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                            if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                                true
                            if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible =
                                false
                        }
                        elssOptionAdapter?.notifyDataSetChanged()


                    }

                    ElssAction.NOT_REQUIRED -> {
                        Log.e("NOT_REQUIRED  MARK_DEAD","")
                        elssOptionList.forEach {
                            if (it.key == ElssOptions.ACCEPT.value) it.isVisible = false
                            if (it.key == ElssOptions.DECLINE.value) it.isVisible = true
                            if (it.key == ElssOptions.ACCEPT_FOR_BULK_SALES.value) it.isVisible =
                                true
                            if (it.key == ElssOptions.ACCEPT_FOR_WARRANTY.value) it.isVisible = true
                        }
                        elssOptionAdapter?.notifyDataSetChanged()

                    }
                }

            }
        }
        elssOptionAdapter?.notifyDataSetChanged()
    }

    override fun notifyFilter(repairPartList: ArrayList<ElssPart>?) {
        partList = repairPartList

        filterList(binding.etSearchView.text.toString())
    }


    private fun submitElss(repairType: String) {

        showAlertDialog(repairType, "OK",
            DialogInterface.OnClickListener { _, _ -> requestToSubmit(repairType, null) },
            "Cancel", DialogInterface.OnClickListener { dialog, _ -> dialog?.dismiss() })
    }


    private fun requestToSubmit(repairType: String, remark: String?, isL4: Boolean = false) {
        viewModel.updateElssRequest(viewModel.adapter?.elssRequest)
        viewModel.adapter?.elssRequest?.deviceBarcode = elssResponse?.elssDeviceDetail?.deviceBarcode
        viewModel.adapter?.elssRequest?.repairType = repairType
        viewModel.adapter?.elssRequest?.remark = remark
        viewModel.adapter?.elssRequest?.isRubbingApplicable = isRubbingApplicableFlag
        viewModel.adapter?.elssRequest?.isPnaApplicable = isPnaApplicableFlag
        viewModel.adapter?.elssRequest?.isGcApplicable = isGcApplicableFlag
        viewModel.adapter?.elssRequest?.action = actionSelected

        viewModel.submitElssDevice(viewModel.adapter?.elssRequest,
            object : OnResult<SubmitElssResponse> {
                override fun onResultAvailable(data: SubmitElssResponse) {
                    if (isL4) {
                        if (data.isSuccess) {
                            restartScanActivity()
                        } else {
                            showError(data.errorMsg)
                        }
                        return
                    }
                    if (data.isSuccess && (actionSelected == ElssOptions.ACCEPT.value || actionSelected == ElssOptions.ACCEPT_FOR_WARRANTY.value
                                || actionSelected == ElssOptions.ACCEPT_FOR_BULK_SALES.value)
                    ) {
                      isPNAPartSelectionApplied=true
                        viewModel.uploadImagerequest.deviceBarcode =
                            viewModel.adapter?.elssRequest?.deviceBarcode
                        viewModel.uploadImagerequest.imageDetailMap.clear()
                        for ((key, value) in viewModel.imageDetailMap) {

                            val part = viewModel.adapter?.elssRequest?.repairPartList?.firstOrNull {
                                key == it.partSku
                            }
                            if (part != null && (part.action.equals(
                                    ElssAction.REPAIRABLE.actionString,
                                    true
                                ) || part.action.equals(
                                    ElssAction.REPAIRABLE_SERVER.actionString,
                                    true
                                ) || part.isManualAdded)
                            ) {
                                viewModel.uploadImagerequest.imageDetailMap.put(key, value)
                            }

                        }


                        if (viewModel.uploadImagerequest.imageDetailMap.size <= 0) {

                            showDialog(
                                "Message",
                                data.alertMsg,
                                "Ok",
                                object : DialogInterface.OnClickListener {
                                    override fun onClick(dialog: DialogInterface?, which: Int) {
                                        restartScanActivity()
                                    }
                                },
                                "",
                                null
                            )

                            return

                        }



                        viewModel.uploadImages(object : OnResult<UploadImageResponse> {
                            override fun onResultAvailable(response: UploadImageResponse) {
                                if (response.success) {
                                    showDialog(
                                        "Message",
                                        data.alertMsg,
                                        "Ok",
                                        object : DialogInterface.OnClickListener {
                                            override fun onClick(
                                                dialog: DialogInterface?,
                                                which: Int
                                            ) {
                                                restartScanActivity()
                                            }
                                        },
                                        "",
                                        null
                                    )
                                } else {
                                    showError(resources.getString(R.string.error_uploading_image))
                                }

                            }

                        })


                    } else if (data.isSuccess) {
                       isPNAPartSelectionApplied=true
                        showDialog(
                            "Message",
                            data.alertMsg,
                            "Ok",
                            object : DialogInterface.OnClickListener {
                                override fun onClick(dialog: DialogInterface?, which: Int) {
                                    restartScanActivity()
                                }
                            },
                            "",
                            null
                        )
                    } else {
                        showError(data.errorMsg)
                    }
                }
            })
    }

    private fun restartScanActivity() {

        val intent = Intent(this, ScanElssBarcodeActivity::class.java).apply {
            addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP)
        }
        startActivity(intent)

    }


    private fun showDeclineDialog(title: String?, msg: String?, repairType: String) {
        val builder = AlertDialog.Builder(this)
        val input = EditText(this)
        val lp = LinearLayout.LayoutParams(
            LinearLayout.LayoutParams.MATCH_PARENT,
            LinearLayout.LayoutParams.MATCH_PARENT
        )
        lp.setMargins(150, 10, 150, 10)
        input.layoutParams = lp
        input.inputType = InputType.TYPE_CLASS_TEXT
        input.filters = arrayOf<InputFilter>(InputFilter.LengthFilter(100))
        builder.setView(input)

        builder.setTitle(title).setMessage(msg)
        builder.setPositiveButton("OK")
        { dialog: DialogInterface?, _: Int ->
            val remark = input.text.toString().trim { it <= ' ' }
            onRemarkEntered(remark, repairType)
        }.setNegativeButton("Cancel")
        { dialog, _ -> dialog.dismiss() }
            .setCancelable(false)
        val alertDialog = builder.create()
        alertDialog.show()
    }

    private fun onRemarkEntered(remark: String, repairType: String) {
        if (TextUtils.isEmpty(remark)) {
            UIHelper.showSnackBar(this, "Please enter remark", Style.ALERT, null)
            return
        }
        requestToSubmit(repairType, remark)
    }

    override fun onPartAdded(partList: ArrayList<DevicePartInfo>?) {
        clearFilter()
        if (partList != null) {
//            manualPartList.addAll(partList)
        }
        viewModel.adapter?.addPartData(partList)
    }

    private var textWatcher: TextWatcher = object : TextWatcher {
        override fun afterTextChanged(s: Editable) {
            partList = viewModel.adapter?.elssRequest?.repairPartList
            filterList(s.toString())
        }

        override fun beforeTextChanged(
            s: CharSequence,
            start: Int,
            count: Int,
            after: Int
        ) {
        }

        override fun onTextChanged(
            s: CharSequence,
            start: Int,
            before: Int,
            count: Int
        ) {
        }
    }

    private fun filterList(searchQuery: String) {
        if (viewModel.adapter?.elssRequest?.repairPartList == null) {
            return
        }
        if (searchQuery.isEmpty()) {
            mSearchPartList = viewModel.adapter?.elssRequest?.repairPartList
        } else {
            mSearchPartList = java.util.ArrayList()
            for (part in viewModel.adapter?.elssRequest?.repairPartList!!) {
                if (part.partName != null) {

                    if (part.partName!!.toLowerCase(Locale.getDefault()).contains(
                            searchQuery.toLowerCase(
                                Locale.getDefault()
                            ).trim()
                        )
                    ) {
                        mSearchPartList?.add(part)
                        continue
                    }
                }

                if (part.partSku != null) {

                    if (part.partSku!!.toLowerCase(Locale.getDefault()).contains(
                            searchQuery.toLowerCase(
                                Locale.getDefault()
                            ).trim()
                        )
                    ) {
                        mSearchPartList?.add(part)
                        continue
                    }
                }

            }
        }
        viewModel.adapter?.changeDataSet(mSearchPartList)
        binding.etSearchView.clearFocus()
        viewModel.adapter?.elssRequest?.repairPartList = partList
    }

    override fun onCaptureImage(partList: ElssPart) {
        val i = Intent(this, ElssCaptureImageActivity::class.java)
        i.putExtra("sku", partList.partSku)
        if (viewModel.imageDetailMap.containsKey(partList.partSku)) {
            i.putExtra("list", viewModel.imageDetailMap.get(partList.partSku))
        }
        startActivityForResult(i, 101)
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (resultCode == Activity.RESULT_OK && requestCode == 101) {
            if (data == null || TextUtils.isEmpty(data.getStringExtra("sku")) || data.getParcelableArrayListExtra<Parcelable>(
                    "list"
                ) == null
            ) {
                return
            }
            viewModel.imageDetailMap.put(
                data.getStringExtra("sku")!!,
                data.getStringArrayListExtra("list")!!
            )

        }
    }

    @SuppressLint("NotifyDataSetChanged")
    override fun onItemClick(pos: Int) {

        isRubbingApplicableFlag = false
        isPnaApplicableFlag = false
        isGcApplicableFlag = false
        isPNAPartSelectionEnable=false
        viewModel.adapter?.elssRequest?.repairPartList?.forEach {
            it.isPnaSelected=false
        }
        elssOptionList.forEach { item ->
            item.isSelected = false
            item.isRAVisible = false
            item.isGCVisible = false
            item.isPNAVisible = false
        }
        elssOptionList[pos].isSelected = true
        elssOptionList[pos].isGCVisible = elssOptionList[pos].isGlassChangeApplicable
        elssOptionList[pos].isRAVisible = elssOptionList[pos].isRubbingApplicable
        elssOptionList[pos].isPNAVisible = elssOptionList[pos].isPnaApplicable
        actionSelected = elssOptionList[pos].key ?: 0
        binding.bottomView.selectedButton.text = elssOptionList[pos].name
        elssOptionAdapter?.notifyDataSetChanged()
    }

    override fun onCheckBoxClick(pos: Int, isRa: Boolean, isGc: Boolean, isPna: Boolean, checkBoxId: Int) {
        when (checkBoxId) {
            CheckBoxType.ISRA.type -> isRubbingApplicableFlag = isRa
            CheckBoxType.ISPNA.type -> {
                isPnaApplicableFlag = isPna
                isPNAPartSelectionEnable=isPna
            }
            CheckBoxType.ISGCA.type -> isGcApplicableFlag = isGc
        }
    }

    private fun openSKUPartMarkPNADialog() {
        if (viewModel.adapter?.elssRequest?.repairPartList == null && viewModel.adapter?.elssRequest?.repairPartList?.isEmpty() == true) {
            return
        }
        viewModel.adapter?.elssRequest?.repairPartList?.forEach {
            it.isVisibleForPna = it.action==ElssAction.REPAIRABLE.actionString || it.action==ElssAction.REPAIRABLE_SERVER.actionString || it.isManualAdded
        }
        PnaPartSelectionDialog.newInstance(viewModel.adapter?.elssRequest?.repairPartList).show(fragmentManager, "skuPartPNA")
    }

    override fun onCheckBoxClick(pos: Int, isChecked: Boolean) {
        viewModel.adapter?.elssRequest?.repairPartList?.get(pos)?.isPnaSelected = isChecked
    }

    override fun onProceedClick() {

        handleSelectedButton()
    }

}