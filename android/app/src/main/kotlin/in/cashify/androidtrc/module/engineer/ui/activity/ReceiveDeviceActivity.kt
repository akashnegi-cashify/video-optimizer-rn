package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityReceiveDeviceBinding
import `in`.cashify.androidtrc.module.engineer.api.response.BaseUpdateDeviceInfo
import `in`.cashify.androidtrc.module.engineer.data.ReceiveDeviceActivityViewModel
import android.os.Bundle
import android.text.TextUtils
import android.view.View
import android.widget.CompoundButton
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders
import de.keyboardsurfer.android.widget.crouton.Crouton
import de.keyboardsurfer.android.widget.crouton.Style


/**
 * Created by Avaneesh Maurya on 25,July,2019
 */
class ReceiveDeviceActivity : BaseActivity(), BarcodeScannerFragment.BarcodeScannerListener,
    View.OnClickListener {
    override fun onClick(v: View?) {
        when (v?.id) {
            binding.btnAccept.id -> {

            }
            binding.btnCancel.id -> {

            }
            binding.btnScanAgain.id -> {
                binding.btnScanAgain.visibility = View.GONE
                setEnterBarcodeVisibility(true)
            }
            binding.btnSubmitBarcode.id ->{
                if(TextUtils.isEmpty(binding.etBarcode.text.toString())){
                    Crouton.makeText(this, resources.getString(R.string.enter_barcode), Style.ALERT).show()
                    return
                }
                onBarcodeScanned(binding.etBarcode.text.toString())
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
        setEnterBarcodeVisibility(false)
        viewModel?.receiveDevice(barcode, object : OnResult<BaseUpdateDeviceInfo?> {
            override fun onResultAvailable(data: BaseUpdateDeviceInfo?) {
                binding.llSwitch.visibility = View.GONE
                binding.blurView.visibility = View.VISIBLE
                if (data!!.isSuccess) {
                    val deviceInfo = data.data
                    val builder = StringBuilder()
                    builder.append(
                        "Device Barcode: " + deviceInfo?.deviceBarcode +
                                "\n" + "Product Title: " + deviceInfo?.productTitle +
                                "\n" + "Status: " + deviceInfo?.status + "\n"
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

    override fun hideLayout(show: Boolean) {
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
        setTitle("Engineer Recieve Device")
        val beginTransaction = supportFragmentManager.beginTransaction()
        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        scannerFragment.setBarcodeScannerListener(this)
        beginTransaction.replace(
            binding.fmContainer.id,
            scannerFragment,
            BarcodeScannerFragment.TAG
        )
        beginTransaction.commitAllowingStateLoss()
        setEnterBarcodeVisibility(true)
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ENG_RECEIVE_DEVICE, null, null, true)

        binding.btnAccept.setOnClickListener(this)
        binding.btnCancel.setOnClickListener(this)
        binding.btnScanAgain.setOnClickListener(this)
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



    private fun setEnterBarcodeVisibility(isVisible: Boolean){
        binding.etBarcode.setText("")
//        if(isVisible) {
            binding.llEtContainer.visibility = View.VISIBLE

//        }
//
//        else{
//
//            binding.llEtContainer.visibility = View.GONE
//        }

    }

}