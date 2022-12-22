package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityReceiveDeviceBinding
import `in`.cashify.androidtrc.module.engineer.api.response.BaseReceivePartByEng
import `in`.cashify.androidtrc.module.engineer.data.ReceiveDeviceActivityViewModel
import android.os.Bundle
import android.text.TextUtils
import android.view.View
import android.widget.CompoundButton
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders


/**
 * Created by Avaneesh Maurya on 25,July,2019
 */
class ReceivePartsActivity : BaseActivity(), BarcodeScannerFragment.BarcodeScannerListener,
    View.OnClickListener {
    override fun onClick(v: View?) {
        when (v?.id) {
            binding.btnAccept.id -> {

            }
            binding.btnCancel.id -> {

            }
            binding.btnScanAgain.id -> {
                binding.btnScanAgain.visibility = View.GONE
            }
            binding.btnSubmitBarcode.id -> {
                val trim = binding.etBarcode.text?.toString()?.trim()
                if (TextUtils.isEmpty(trim)) {
                    return
                }

                requestForPartDetail(trim)

                return
            }
        }
        reEnableScanner()
    }


    fun reEnableScanner() {
        binding.llSwitch.visibility = View.VISIBLE
        scannerFragment.resumeScanner()
        binding.blurView.visibility = View.GONE
        binding.tvMessage.text = getString(R.string.scanning_is_disabled)
    }

    override fun getLayoutResId(): Int {
        return R.layout.activity_receive_device
    }

    override fun onBarcodeScanned(barcode: String) {
        scannerFragment.pauseScanner()
        requestForPartDetail(barcode)
    }

    override fun hideLayout(show: Boolean) {

    }


    private fun requestForPartDetail(barcode: String?) {
        viewModel?.receivePart(barcode, object : OnResult<BaseReceivePartByEng> {
            override fun onResultAvailable(data: BaseReceivePartByEng) {
                binding.llSwitch.visibility = View.GONE
                binding.blurView.visibility = View.VISIBLE
                if (data.isSuccess) {
                    val deviceInfo = data.data
                    val builder = StringBuilder()
                    builder.append(
                        "Device Barcode: " + barcode +
                                "\n" + "Status: " + "Received"
                    )
                    binding.tvMessage.text = builder.toString()
                    binding.btnScanAgain.visibility = View.VISIBLE
                } else {
                    binding.llButton.visibility = View.GONE
                    binding.btnScanAgain.visibility = View.VISIBLE
                    binding.tvMessage.text = if (!TextUtils.isEmpty(data.errorMsg)) {
                        data.errorMsg
                    } else {
                        "Assigned barcode is not assigned to you"
                    }
                }
            }
        })
    }

    private lateinit var scannerFragment: BarcodeScannerFragment
    lateinit var binding: ActivityReceiveDeviceBinding
    var viewModel: ReceiveDeviceActivityViewModel? = null

    companion object {
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel =
            ViewModelProviders.of(this, factory).get(ReceiveDeviceActivityViewModel::class.java)
        viewModel?.activityListener = this
        binding.lifecycleOwner = this
        setTitle("Engineer Receive Parts")
        val beginTransaction = supportFragmentManager.beginTransaction()
        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        scannerFragment.setBarcodeScannerListener(this)

        beginTransaction.replace(
            binding.fmContainer.id,
            scannerFragment,
            BarcodeScannerFragment.TAG
        )
        beginTransaction.commitAllowingStateLoss()
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ENG_RECEIVE_PART, null, null, true)

        binding.btnAccept.setOnClickListener(this)
        binding.btnCancel.setOnClickListener(this)
        binding.btnScanAgain.setOnClickListener(this)
        binding.llEtContainer.visibility = View.VISIBLE
        binding.btnSubmitBarcode.setOnClickListener(this)
        binding.toggleButton.setOnCheckedChangeListener(object :
            CompoundButton.OnCheckedChangeListener {

            override fun onCheckedChanged(buttonView: CompoundButton?, isChecked: Boolean) {
                binding.btnScanAgain.visibility = View.GONE
                if (isChecked) {
                    binding.tvSwitchText.text = "Click to disable scan"
                    scannerFragment.resumeScanner()
                    binding.blurView.visibility = View.GONE

                } else {
                    binding.tvSwitchText.text = "Click to enable scan"
                    scannerFragment.pauseScanner()
                    binding.blurView.visibility = View.VISIBLE
                }
            }
        })
    }

}