package `in`.cashify.androidtrc.module.rider.ui.pickup

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityPickupPartFromEngineerScanBinding
import `in`.cashify.androidtrc.databinding.ActivityReceiveDeviceBinding
import `in`.cashify.androidtrc.module.engineer.api.response.BaseUpdateDeviceInfo
import `in`.cashify.androidtrc.module.engineer.data.ReceiveDeviceActivityViewModel
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.TextUtils
import android.view.View
import android.widget.CompoundButton
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders
import de.keyboardsurfer.android.widget.crouton.Crouton
import de.keyboardsurfer.android.widget.crouton.Style

class PickupPartFromEngineerScanActivity : BaseActivity(), BarcodeScannerFragment.BarcodeScannerListener,
    View.OnClickListener {
    override fun onClick(v: View?) {
        when (v?.id) {

            binding.btnSubmitBarcode.id ->{
                if(binding.etBarcode.text  == null || TextUtils.isEmpty(binding.etBarcode.text.toString())){
                    Crouton.makeText(this, resources.getString(R.string.enter_barcode), Style.ALERT).show()
                    return
                }
              onBarcodeScanned(binding.etBarcode.text.toString())
            }
        }
        reEnableScanner()
    }


    fun reEnableScanner() {

        scannerFragment.resumeScanner()
//        binding.blurView.visibility = View.GONE
//        binding.tvMessage.text = getString(R.string.scanning_is_disabled)


    }






    override fun getLayoutResId(): Int {
        return R.layout.activity_pickup_part_from_engineer_scan
    }
    override fun onBarcodeScanned(barcode: String) {
        scannerFragment.pauseScanner()


        setResult(RESULT_OK , Intent().apply {
            putExtra("barcode", barcode)
        })


        finish()
    }

    override fun hideLayout(show: Boolean) {
    }
    private lateinit var scannerFragment: BarcodeScannerFragment
    lateinit var binding: ActivityPickupPartFromEngineerScanBinding

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)

        binding.lifecycleOwner = this
        setTitle("Engineer Recieve Device")
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_PICKUP_PART_FROM_ENG_SCAN, null, null, true)

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


        binding.btnSubmitBarcode.setOnClickListener(this)


binding.tvPartName.setText(intent.getStringExtra("name"))
        binding.tvPartSku.setText(intent.getStringExtra("sku"))
        binding.tvPartColor.setText(intent.getStringExtra("color"))



    }



    private fun setEnterBarcodeVisibility(isVisible: Boolean){
        binding.etBarcode.setText("")
//        if(isVisible) {


//        }
//
//        else{
//
//            binding.llEtContainer.visibility = View.GONE
//        }

    }
}