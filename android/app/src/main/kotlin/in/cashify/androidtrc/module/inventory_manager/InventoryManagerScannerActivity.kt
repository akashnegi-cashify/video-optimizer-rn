package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityIMReceiveScanAcitityBinding
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerBinding
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerScannerBinding
import `in`.cashify.androidtrc.module.inventory_manager.api.response.ListReceivePendingPartResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.UpdateReceivePartResponse
import android.content.DialogInterface
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.TextUtils
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

class InventoryManagerScannerActivity : BaseActivity() , BarcodeScannerFragment.BarcodeScannerListener{



    private lateinit var binding: ActivityInventoryManagerScannerBinding
    lateinit var scannerFragment: BarcodeScannerFragment



    override fun getLayoutResId(): Int {
        return R.layout.activity_inventory_manager_scanner
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_INVENTORY_MANAGER_SCANNER, null, null, true)

        showBarcodeFragment()




    }



    override fun onBarcodeScanned(barcode: String) {
setResult(RESULT_OK, Intent().apply {
    putExtra("barcode", barcode)
})


finish()

    }

    override fun hideLayout(show: Boolean) {

    }

    private fun createScannerBarcode() {
        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        scannerFragment.setBarcodeScannerListener(this)
        val beginTransaction = supportFragmentManager.beginTransaction()
        beginTransaction.replace(
            binding.container.id,
            scannerFragment,
            BarcodeScannerFragment.TAG
        )
        beginTransaction.commitAllowingStateLoss()


    }


    fun showBarcodeFragment() {
        resetBarcodeUI()

        createScannerBarcode()
    }


    private fun resetBarcodeUI() {


    }


}