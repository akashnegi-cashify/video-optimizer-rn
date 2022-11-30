package `in`.cashify.androidtrc.module.login

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityScanElssBarcodeBinding
import `in`.cashify.androidtrc.databinding.ActivityScanLocationBinding
import `in`.cashify.androidtrc.module.elss.data.ElssViewModel
import `in`.cashify.androidtrc.module.elss.ui.fragment.ScanElssBarcodeFragment
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider

class ScanLocationActivity : BaseActivity(), BarcodeScannerFragment.BarcodeScannerListener {

    private lateinit var scannerFragment: BarcodeScannerFragment

    override fun getLayoutResId(): Int {
        return R.layout.activity_scan_location
    }

    lateinit var binding: ActivityScanLocationBinding
    private lateinit var viewModel: ElssViewModel
    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProvider(this, factory).get(ElssViewModel::class.java)
        binding.lifecycleOwner = this

        viewModel.activityListener = this
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_SCAN_LOCATION, null, null, true)

        val beginTransaction = supportFragmentManager.beginTransaction()
        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        scannerFragment.setBarcodeScannerListener(this)

        beginTransaction.replace(
            binding.fmContainer.id,
            scannerFragment,
            "ScanElssBarcodeFragment"
        )
        beginTransaction.commitAllowingStateLoss()
    }

    override fun onBarcodeScanned(barcode: String) {
        scannerFragment.pauseScanner()
        setResult(RESULT_OK, Intent().apply {
            putExtra("loc" , barcode)
        })
        finish()

    }

    override fun hideLayout(show: Boolean) {

    }

}