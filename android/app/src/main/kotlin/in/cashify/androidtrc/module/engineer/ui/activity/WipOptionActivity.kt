package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.api.BaseResponse
import `in`.cashify.androidtrc.databinding.ActivityWipOptionBinding
import `in`.cashify.androidtrc.module.engineer.adapter.EngDeviceIssueAdapter
import `in`.cashify.androidtrc.module.engineer.adapter.SendtoTLReasonSpinnerAdapter
import `in`.cashify.androidtrc.module.engineer.api.response.ChangeDeviceStatusResponse
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerDeviceInfo
import `in`.cashify.androidtrc.module.engineer.api.response.ListDeviceReason
import `in`.cashify.androidtrc.module.engineer.api.response.SendToTLReasonResponse
import `in`.cashify.androidtrc.module.engineer.data.WipOptionActivityModel
import `in`.cashify.androidtrc.module.runner.adapter.RoleAdapter
import android.app.Activity
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.text.TextUtils
import android.view.View
import android.widget.*
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager


/**
 * Created by Avaneesh Maurya on 20,August,2019
 */
class WipOptionActivity : BaseActivity(), View.OnClickListener {

    companion object {
        const val KEY_DEVICE_INFO = "key_device_list"
    }

    private var isRoleEngineer: Boolean = false
    var mDeviceInfo: EngineerDeviceInfo? = null

    private var deviceIssueAdapter = EngDeviceIssueAdapter()
    private var alertDialog: AlertDialog? = null

    private var selectedReasonId: String? = null

    override fun onClick(v: View?) {
        when (v?.id) {
            binding.btnPutHold.id -> {
                showAlertDialog("Are you sure?", "Yes", object : DialogInterface.OnClickListener {
                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        makeRequest("mark-onhold")
                    }
                }, "Cancel", null)

            }


            binding.btnMarkOk.id -> {

                val v = layoutInflater.inflate(R.layout.dialog_mark_ok, null, false)
                val builder = AlertDialog.Builder(this)
                    .setView(v)
                    .setCancelable(false)
                val alertDialog = builder.create()
                alertDialog.show()

                v.findViewById<TextView>(R.id.tv_device_name).setText(mDeviceInfo?.productTitle)
                v.findViewById<TextView>(R.id.tv_barcode).setText(mDeviceInfo?.deviceBarcode)
                v.findViewById<TextView>(R.id.tv_color).setText(mDeviceInfo?.color)
                v.findViewById<TextView>(R.id.tv_imei).setText(mDeviceInfo?.imei)

                v.findViewById<Button>(R.id.cancel).setOnClickListener {
                    finish()
                }
                v.findViewById<Button>(R.id.confirm).setOnClickListener {
                    if (isRoleEngineer) {
                        makeRequest("mark-ok")
                    } else {
                        makeRequest("mark-repair-done")
                    }

                    alertDialog?.dismiss()
                }


            }
            binding.btnStartWork.id -> {

                showAlertDialog("Are you sure?", "Yes", object : DialogInterface.OnClickListener {
                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        viewModel.changeDeviceStatus(
                            "mark-inprogress",
                            mDeviceInfo?.deviceBarcode,
                            object : OnResult<ChangeDeviceStatusResponse> {
                                override fun onResultAvailable(data: ChangeDeviceStatusResponse) {
                                    if (data.isSuccess!!) {
                                        binding.btnStartWork.visibility = View.GONE
                                        binding.llBtnContainer.visibility = View.VISIBLE
                                    } else {
                                        showError(data.errorMsg)
                                    }
                                }
                            })
                    }
                }, "Cancel", null)

            }


            binding.btnViewParts.id -> {
                val intent = Intent(this, ViewPartActivity::class.java)
                intent.putExtra(ViewPartActivity.KEY_DEVICE_INFO, mDeviceInfo)
                startActivity(intent)
            }

            binding.btnMarkFi.id -> {
                showAlertDialog("Are you sure?", "Yes", object : DialogInterface.OnClickListener {
                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        makeRequest("mark-fi")
                    }
                }, "Cancel", null)

            }

            binding.btnMarkFfi.id -> {
                showAlertDialog("Are you sure?", "Yes", object : DialogInterface.OnClickListener {
                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        makeRequest("mark-nff")
                    }
                }, "Cancel", null)

            }

            binding.btnMarkNr.id -> {
                showAlertDialog("Are you sure?", "Yes", object : DialogInterface.OnClickListener {
                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        makeRequest("mark-nr")
                    }
                }, "Cancel", null)

            }


            binding.btnSendTl.id -> {
                val inflater = this.layoutInflater
                val dialogView = inflater.inflate(R.layout.dialog_send_to_tl, null)
                val builder = AlertDialog.Builder(this)

                    .setView(dialogView)
                    .setCancelable(false)
                val cancel = dialogView.findViewById(R.id.btn_cancel) as Button
                val confirm = dialogView.findViewById(R.id.btn_confirm) as Button

                val deviceName = dialogView.findViewById(R.id.tv_device_name) as TextView
                val barcode = dialogView.findViewById(R.id.tv_barcode) as TextView
                val color = dialogView.findViewById(R.id.tv_color) as TextView
                val imei = dialogView.findViewById(R.id.tv_imei) as TextView

                val spinnerReason = dialogView.findViewById(R.id.spinner_reason) as Spinner





                deviceName.text = mDeviceInfo?.productTitle
                barcode.text = mDeviceInfo?.deviceBarcode
                color.text = mDeviceInfo?.color
                imei.text = mDeviceInfo?.imei


                alertDialog = builder.create()
                cancel.setOnClickListener {
                    alertDialog?.dismiss()
                }
                confirm.setOnClickListener {
                    if (selectedReasonId?.equals("-1") ?: false) {

                        showDialog(
                            "",
                            resources?.getString(R.string.select_return_reason),
                            "Ok",
                            object : DialogInterface.OnClickListener {
                                override fun onClick(dialog: DialogInterface?, which: Int) {
                                    dialog?.dismiss()
                                }
                            },
                            "",
                            null
                        )
                        return@setOnClickListener
                    }


                    viewModel.sendToTL(mDeviceInfo?.deviceBarcode ?: "", selectedReasonId ?: "")
                    alertDialog?.dismiss()
                }

                cancel.setOnClickListener {
                    alertDialog?.dismiss()


                }

                alertDialog?.show()



                spinnerReason.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                    override fun onItemSelected(
                        parent: AdapterView<*>?,
                        view: View?,
                        position: Int,
                        id: Long
                    ) {
                        selectedReasonId = (parent?.selectedItem as ListDeviceReason).id
                    }

                    override fun onNothingSelected(parent: AdapterView<*>?) {

                    }

                }

                viewModel.getReasons(object : OnResult<SendToTLReasonResponse> {
                    override fun onResultAvailable(data: SendToTLReasonResponse) {
                        var list = ArrayList<ListDeviceReason>()
                        data?.map?.entries?.forEach {
                            list.add(ListDeviceReason().apply {
                                reason = it.value
                                id = it.key
                            })

                        }



                        list?.add(ListDeviceReason().apply {
                            reason = resources.getString(R.string.select_reasons)
                            id = "-1"
                        })

                        val stateAdapter = SendtoTLReasonSpinnerAdapter(
                            this@WipOptionActivity,
                            android.R.layout.simple_spinner_item,
                            list ?: ArrayList()
                        )
                        spinnerReason.adapter = stateAdapter
                        spinnerReason.setSelection((list?.size ?: 1) - 1)


                    }

                })

            }

        }

    }

    private fun makeRequest(status: String?) {
        viewModel.changeDeviceStatus(status, mDeviceInfo?.deviceBarcode,
            object : OnResult<ChangeDeviceStatusResponse> {
                override fun onResultAvailable(data: ChangeDeviceStatusResponse) {
                    if (data.isSuccess!!) {
                        if (status.equals("mark-nff") || status.equals("mark-repair-done")) {
                            showDialog(
                                "Message",
                                data.dt!!.msg,
                                "Ok",
                                object : DialogInterface.OnClickListener {
                                    override fun onClick(dialog: DialogInterface?, which: Int) {
                                        setResult(Activity.RESULT_OK)
                                        finish()
                                    }
                                },
                                "",
                                null
                            )
                        } else {
                            setResult(Activity.RESULT_OK)
                            finish()
                        }

                    } else {
                        showError(data.errorMsg)
                    }
                }
            })
    }

    override fun getLayoutResId(): Int {
        return R.layout.activity_wip_option
    }

    private lateinit var viewModel: WipOptionActivityModel
    private lateinit var binding: ActivityWipOptionBinding

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(WipOptionActivityModel::class.java)
        binding.lifecycleOwner = this
        binding.viewModel = viewModel
        viewModel.activityListener = this
        getSupportActionBar()?.setDisplayHomeAsUpEnabled(true);
        binding.btnPutHold.setOnClickListener(this)


        binding.btnMarkOk.setOnClickListener(this)
        binding.btnOrderPart.setOnClickListener(this)
        binding.btnViewParts.setOnClickListener(this)
        binding.btnStartWork.setOnClickListener(this)
        AnalyticsEventHelper.fireScreenEvent(
            this,
            AnalyticsController.AnalyticEventKey.EVENT_ONCREATE,
            AnalyticsController.AnalyticScreen.SCREEN_ENG_WIPE_OPTION,
            null,
            null,
            true
        )

        val userDetailResponse = AppInfoProvider.getInstance().getUserDetailResponse()
        if (userDetailResponse?.roles?.contains(RoleAdapter.ROLE_ENGINEER)!!) {
            isRoleEngineer = true

            binding.btnMarkFi.visibility = View.GONE
            binding.btnMarkFfi.visibility = View.GONE
            binding.btnMarkNr.visibility = View.GONE
            binding.btnSendTl.visibility = View.VISIBLE
            binding.btnSendTl.setOnClickListener(this)
        } else {


            binding.btnMarkFi.visibility = View.VISIBLE
            binding.btnMarkFfi.visibility = View.VISIBLE
            binding.btnMarkNr.visibility = View.VISIBLE
            binding.btnSendTl.visibility = View.GONE
            binding.btnMarkOk.setText("Repair Done")
            binding.btnMarkFi.setOnClickListener(this)
            binding.btnMarkFfi.setOnClickListener(this)
            binding.btnMarkNr.setOnClickListener(this)
        }



        setTitle("Wip Option")
        mDeviceInfo = intent.getParcelableExtra(KEY_DEVICE_INFO)
        if (mDeviceInfo?.status == BaseResponse.STATUS_HOLD) {
            binding.btnStartWork.visibility = View.VISIBLE
            binding.llBtnContainer.visibility = View.GONE
        } else {
            binding.btnStartWork.visibility = View.GONE
            binding.llBtnContainer.visibility = View.VISIBLE
        }
        binding.tvLine1.text = "Device Barcode- ${mDeviceInfo?.deviceBarcode}"
        binding.tvLine2.text = "Product Title- ${mDeviceInfo?.productTitle}"
        binding.tvLine3.text = "Status- ${mDeviceInfo?.status}"
        binding.tvImei.text = "Device IMEI- ${mDeviceInfo?.imei}"
        binding.tvRepairType.text = "Repair Type- ${mDeviceInfo?.repairType}"
        binding.tvGrade.text = "Grade- ${mDeviceInfo?.grade}"


        //        elssResponse?.elssDeviceDetail?.requestReason = "dfxgchvjkfghjklyguiotyguhikiuhuiyhvfuhudhuhdvguyhuyfvjdygfhjdhuhfudhfjdgfhvhufghvfuhvhfudhvjghhhuvguhhgfvhjdfhvjfhgiuhfuhfuhguhugfhu"
//
//        var list = ArrayList<String>()
//        list.add("gfhjkljhgklhbjk")
//        list.add("gfhjkljhgklhbjk")
//        list.add("gfhjkljhgklhbjk")
//        list.add("gfhjkljhgklhbjk")
//        list.add("gfhjkljhgklhbjk")
//        list.add("gfhjkljhgklhbjk")
//        list.add("gfhjkljhgklhbjk")
//        list.add("gfhjkljhgklhbjk")
//        elssResponse?.elssDeviceDetail?.repairReasonList = list


        if (mDeviceInfo?.returnReason != null && !mDeviceInfo?.returnReason!!.isEmpty()) {
            binding.tvReason.visibility = View.VISIBLE
            binding.tvReasonHeading.visibility = View.VISIBLE

            binding.tvReason.text = mDeviceInfo?.returnReason
        } else {
            binding.tvReason.visibility = View.GONE
            binding.tvReasonHeading.visibility = View.GONE

        }


        if (TextUtils.isEmpty(mDeviceInfo?.returnReason)) {
            binding.lblRmsRemarks.visibility = View.GONE
            binding.tvRmsRemarks.visibility = View.GONE

        } else {
            binding.lblRmsRemarks.visibility = View.VISIBLE
            binding.tvRmsRemarks.visibility = View.VISIBLE
            binding.tvRmsRemarks.setText(mDeviceInfo?.returnReason)
        }


        if (mDeviceInfo?.repairReasonList == null || mDeviceInfo?.repairReasonList?.size!! == 0) {
            binding.tvDeviceIssues.visibility = View.GONE
            binding.reclDeviceIssue.visibility = View.GONE
        } else {
            binding.tvDeviceIssues.visibility = View.VISIBLE
            binding.reclDeviceIssue.visibility = View.VISIBLE
            binding.reclDeviceIssue.layoutManager = LinearLayoutManager(this)
            binding.reclDeviceIssue.adapter = deviceIssueAdapter
            deviceIssueAdapter.setData(mDeviceInfo?.repairReasonList ?: ArrayList<String>())
        }



        viewModel?.sendToTLResponse?.observe(this, Observer {
            val v = layoutInflater.inflate(R.layout.dialog_mark_tl_succsess, null, false)
            val builder = AlertDialog.Builder(this)
                .setView(v)
                .setCancelable(false)
            val alertDialog = builder.create()
            alertDialog.show()



            v.findViewById<Button>(R.id.btn_ok).setOnClickListener {
                setResult(RESULT_OK)
                finish()
            }



            if (it?.s ?: false) {
                v.findViewById<TextView>(R.id.lbl_msg)
                    .setText(resources.getString(R.string.device_successfully_updated))
                v.findViewById<TextView>(R.id.lbl_error).visibility = View.GONE

                v.findViewById<ImageView>(R.id.img).visibility = View.VISIBLE
            } else {
                v.findViewById<TextView>(R.id.lbl_msg).setText(it?.message)
                v.findViewById<TextView>(R.id.lbl_error).visibility = View.VISIBLE

                v.findViewById<ImageView>(R.id.img).visibility = View.GONE

            }

        })


    }
}