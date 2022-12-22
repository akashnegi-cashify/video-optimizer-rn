package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityEngineerViewPartScannerBinding
import `in`.cashify.androidtrc.databinding.ActivityPickupPartFromEngineerScanBinding
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.TextUtils
import android.view.View
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import de.keyboardsurfer.android.widget.crouton.Crouton
import de.keyboardsurfer.android.widget.crouton.Style

class EngineerViewPartScannerActivity : BaseActivity() , BarcodeScannerFragment.BarcodeScannerListener,
    View.OnClickListener {


    private lateinit var scannerFragment: BarcodeScannerFragment
    lateinit var binding: ActivityEngineerViewPartScannerBinding

    override fun getLayoutResId(): Int {
       return R.layout.activity_engineer_view_part_scanner
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)

        binding.lifecycleOwner = this

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

        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ENG_PART_SCANNER, null, null, true)

        binding.btnSubmitBarcode.setOnClickListener(this)


        binding.tvPartName.setText(intent.getStringExtra("name"))
        binding.tvPartBarcode.setText(intent.getStringExtra("barcode"))




    }


    private fun setEnterBarcodeVisibility(isVisible: Boolean){
        binding.etBarcode.setText("")


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




}