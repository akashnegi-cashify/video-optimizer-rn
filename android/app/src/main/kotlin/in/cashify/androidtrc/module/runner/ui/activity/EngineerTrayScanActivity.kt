package `in`.cashify.androidtrc.module.runner.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityEngTrayScanBinding
import `in`.cashify.androidtrc.module.runner.api.response.engineer_tray.ScanRunnerTray
import `in`.cashify.androidtrc.module.runner.data.EngTrayScanViewModel
import android.content.DialogInterface
import android.os.Bundle
import android.view.View
import android.widget.CompoundButton
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders


/**
 * Created by Avaneesh Maurya on 25,July,2019
 */
class EngineerTrayScanActivity : BaseActivity(), BarcodeScannerFragment.BarcodeScannerListener {

    override fun getLayoutResId(): Int {
        return R.layout.activity_eng_tray_scan
    }

    override fun onBarcodeScanned(barcode: String) {
        scannerFragment.pauseScanner()
        viewModel?.updateTrayScan(barcode, object : OnResult<ScanRunnerTray> {
            override fun onResultAvailable(response: ScanRunnerTray) {
                if (response.isSuccess) {
                    showDialog(
                        "Alert",
                        "Are you sure you want this tray",
                        "Yes",
                        object : DialogInterface.OnClickListener {
                            override fun onClick(dialog: DialogInterface?, which: Int) {
                                finish()
                            }
                        },
                        "No",
                        object : DialogInterface.OnClickListener {
                            override fun onClick(dialog: DialogInterface?, which: Int) {
                                scannerFragment.resumeScanner()
                            }
                        })
                } else {
                    showDialog(
                        "Alert",
                        response.errorMessage,
                        "Ok",
                        object : DialogInterface.OnClickListener {
                            override fun onClick(dialog: DialogInterface?, which: Int) {
                                scannerFragment.resumeScanner()
                            }
                        },
                        "",
                        null
                    )
                }
            }
        })
    }

    override fun hideLayout(show: Boolean) {

    }


    private lateinit var scannerFragment: BarcodeScannerFragment
    private var mTrayBarcode: String? = null
    lateinit var binding: ActivityEngTrayScanBinding
    var viewModel: EngTrayScanViewModel? = null

    companion object {
        const val KEY_TRAY_BARCODE = "tray_barcode"
    }

    override fun create(savedInstanceState: Bundle?, mainContainer: LinearLayout, addToParent: Boolean) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        mTrayBarcode = intent.getStringExtra(KEY_TRAY_BARCODE)
        viewModel = ViewModelProviders.of(this, factory).get(EngTrayScanViewModel::class.java)
        viewModel?.activityListener = this
        binding.lifecycleOwner = this
        setTitle("Tray Scan")
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_RUNNER_TRAY_SCAN, null, null, true)

        val beginTransaction = supportFragmentManager.beginTransaction()
        scannerFragment = BarcodeScannerFragment.newInstance(mTrayBarcode, true, false)
        scannerFragment.setBarcodeScannerListener(this)
        beginTransaction.replace(binding.fmContainer.id, scannerFragment, BarcodeScannerFragment.TAG)
        beginTransaction.commitAllowingStateLoss()

        binding.tvTrayBarCode.text = "Tray Barcode- " + mTrayBarcode
        binding.toggleButton.setOnCheckedChangeListener(object : CompoundButton.OnCheckedChangeListener {

            override fun onCheckedChanged(buttonView: CompoundButton?, isChecked: Boolean) {
                if (isChecked) {
                    binding.tvSwitchText.text = "Click to enable scan"
                    scannerFragment.pauseScanner()
                    binding.blurView.visibility = View.GONE
                } else {
                    binding.tvSwitchText.text = "Click to disable scan"
                    scannerFragment.resumeScanner()
                    binding.blurView.visibility = View.VISIBLE
                }
            }
        })
    }

}