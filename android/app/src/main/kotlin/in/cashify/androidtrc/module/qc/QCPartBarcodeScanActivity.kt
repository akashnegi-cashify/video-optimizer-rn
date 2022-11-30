package `in`.cashify.androidtrc.module.qc

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityQCPartBarcodeScanBinding
import `in`.cashify.androidtrc.databinding.FragmentIMPendingPartBarcodeScannedBinding
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerPendingPartViewModel
import `in`.cashify.androidtrc.module.inventory_manager.fragment.pending.IMPendingPartBarcodeScannedFragment
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import `in`.cashify.androidtrc.module.qc.ui.QCPendingPartByBarcodeActivity
import `in`.cashify.androidtrc.module.qc.ui.QCPendingPartDetailsActivity
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import de.keyboardsurfer.android.widget.crouton.Style

class QCPartBarcodeScanActivity : BaseActivity(),
    BarcodeScannerFragment.BarcodeScannerListener {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null

    private lateinit var scannerFragment: BarcodeScannerFragment

    var binding: ActivityQCPartBarcodeScanBinding? = null


    var barcode: String? = ""






    var activityViewModel: QCPartBBarcodeScanActivityViewModel? = null



    override fun onBarcodeScanned(barcode: String) {

        this.barcode = barcode


        if (!TextUtils.isEmpty(barcode)) {

            setResult(RESULT_OK , Intent().apply {
                putExtra("barcode", barcode)
            })
           finish()

        }
    }

    override fun hideLayout(show: Boolean) {

    }


    private fun createScannerBarcode() {
        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        scannerFragment.setBarcodeScannerListener(this)
        val beginTransaction = supportFragmentManager.beginTransaction()
        beginTransaction?.replace(
            binding?.container?.id!!,
            scannerFragment,
            BarcodeScannerFragment.TAG
        )
        beginTransaction?.commitAllowingStateLoss()
//        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
//        mActivityHelper.addFragment(activity!!, scannerFragment,binding?.container?.id!! , true ,tag)
//
//        scannerFragment.setBarcodeScannerListener(this)

    }


    fun showBarcodeFragment() {
        resetBarcodeUI()

        createScannerBarcode()
    }


    private fun resetBarcodeUI() {
//        binding.etBarcode.setText("")

    }

    override fun getLayoutResId(): Int {
   return  R.layout.activity_q_c_part_barcode_scan
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =  DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        activityViewModel =
            ViewModelProvider(this, factory).get(QCPartBBarcodeScanActivityViewModel::class.java)
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_QC_PART_SCAN, null, null, true)

        binding?.btnSubmit?.setOnClickListener {
            binding?.etEnterPartCode?.text?.let {
                onBarcodeScanned(binding?.etEnterPartCode?.text?.toString()?:"")

            }



        }

        showBarcodeFragment()
    }
}