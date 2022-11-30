package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.ActivityViewPartBinding
import `in`.cashify.androidtrc.module.engineer.adapter.ViewPartAdapter
import `in`.cashify.androidtrc.module.engineer.api.response.*
import `in`.cashify.androidtrc.module.engineer.data.ViewPartActivityViewModel
import `in`.cashify.androidtrc.module.engineer.ui.fragment.ReturnReasonDialog
import `in`.cashify.androidtrc.module.runner.adapter.RoleAdapter
import `in`.cashify.androidtrc.util.CommonConstant
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 21,August,2019
 */
class ViewPartActivity : BaseActivity(), ViewPartAdapter.OnItemClick,
    View.OnClickListener {

    private lateinit var viewModel: ViewPartActivityViewModel
    private lateinit var binding: ActivityViewPartBinding
    var mDeviceInfo: EngineerDeviceInfo? = null
    var viewPartAdapter: ViewPartAdapter? = null


    var deviceInfo: DevicePartInfo? = null
//    override fun onPartReturned(returnResponse: ReturnPartResponse) {
//        if (returnResponse.isSucess) {
//            showAlertDialog(
//                "Part Returned",
//                getString(R.string.refresh),
//                DialogInterface.OnClickListener { dialog, which -> viewModel.getEngPartInfoList(mDeviceInfo?.deviceId?:"") },
//                null,
//                null
//            )
//        } else {
//            showError(returnResponse.errorMsg)
//        }
//    }


//    override fun onConsumeClick(deviceInfo: DevicePartInfo?) {
//        this.deviceInfo = deviceInfo
//       startActivityForResult(Intent(this, EngineerViewPartScannerActivity::class.java).apply {
//                                                                                              putExtra("nme", deviceInfo?.deviceName)
//           putExtra("barcode", deviceInfo?.partBarcode)
//       }
//
//           , REQ_CODE_CONSUME_SCAN)
//
//    }

//    override fun onReturnClick(deviceInfo: DevicePartInfo?) {
//        this.deviceInfo = deviceInfo
//
//        startActivityForResult(Intent(this, EngineerViewPartScannerActivity::class.java).apply {
//            putExtra("nme", deviceInfo?.deviceName)
//            putExtra("barcode", deviceInfo?.partBarcode)
//        }
//
//            , REQ_CODE_RETURN_SCAN)
//
//
//
//        showAlertDialog(
//            "Are you sure you want to return this part.",
//            "Yes",
//            object : DialogInterface.OnClickListener {
//                override fun onClick(dialog: DialogInterface?, which: Int) {
//                    viewModel.returnPartReason(object : OnResult<ReturnReasonList?> {
//                        override fun onResultAvailable(data: ReturnReasonList?) {
//                            showBottomDialog(
//                                this@ViewPartActivity,
//                                ReturnReasonDialog.newInstance(deviceInfo, data),
//                                "ReturnReasonDialog"
//                            )
//                        }
//                    })
//                }
//            },
//            "Cancel",
//            null
//        )
//    }

    override fun getLayoutResId(): Int {
        return R.layout.activity_view_part
    }

    companion object {
        const val KEY_DEVICE_INFO = "key_device_list"
    }



    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(ViewPartActivityViewModel::class.java)
        binding.lifecycleOwner = this
        binding.viewModel = viewModel
        viewModel.activityListener = this
        getSupportActionBar()?.setDisplayHomeAsUpEnabled(true);
        mDeviceInfo = intent.getParcelableExtra(KEY_DEVICE_INFO)
        setTitle("View Parts")
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ENG_PART_VIEW, null, null, true)

        viewPartAdapter = ViewPartAdapter(this)
        binding.rvDevices.layoutManager =
            LinearLayoutManager(this, RecyclerView.VERTICAL, false)
        binding.rvDevices.adapter =viewPartAdapter

        binding.tvDeviceBarcode.text = " ${mDeviceInfo?.deviceBarcode}"
        binding.tvDeviceStatus.text = "${mDeviceInfo?.status}"
        binding.tvDeviceProductTitle.text = "${mDeviceInfo?.productTitle}"
        binding.btnOrderPart.setOnClickListener {
            val intent = Intent(this, OrderPartActivity::class.java)
            intent.putExtra(OrderPartActivity.KEY_BARCODE, mDeviceInfo?.deviceBarcode)
            startActivity(intent)
        }

        binding.btnSelfAssignPart.setOnClickListener {
            val intent = Intent(this, SelfAssignPartActivity::class.java)
            intent.putExtra(OrderPartActivity.KEY_BARCODE, mDeviceInfo?.deviceBarcode)
            startActivity(intent)


        }


        viewModel?.wipPartList?.observe(this, Observer {
            viewPartAdapter?.changeDataSet(it)
        })


        val userDetailResponse = AppInfoProvider.getInstance().getUserDetailResponse()
        if (userDetailResponse?.roles?.contains(RoleAdapter.ROLE_ENGINEER)!! || userDetailResponse.roles?.contains(
                RoleAdapter.ROLE_L4
            )!!
        ) {
            binding.btnSelfAssignPart.visibility = View.VISIBLE

        } else {
            binding.btnSelfAssignPart.visibility = View.GONE
        }
    }

    override fun onClick(v: View?) {

    }

    override fun onResume() {
        super.onResume()
        viewModel.getEngPartInfoList(mDeviceInfo?.deviceId?:"")
    }
    override fun onItemClick(partInfo: EngineerPartInfo?) {
        startActivity(Intent(this , WIPPartInfoActivity::class.java).apply {
            putExtra(ViewPartActivity.KEY_DEVICE_INFO , mDeviceInfo)
            putExtra(CommonConstant.KEY_PART_INFO ,partInfo )
        })
    }
}

interface OnPartReturn {
    fun onPartReturned(returnResponse: ReturnPartResponse)
}