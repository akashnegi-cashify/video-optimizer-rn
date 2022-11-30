package `in`.cashify.androidtrc.module.runner.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityPickMarkOkBinding
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.EngineerMarkOkDevice
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.PickMarkOkDevice
import `in`.cashify.androidtrc.module.runner.data.PickMarkOkDeviceViewModel
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkOkListFragment
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
class PickMarkOkDeviceActivity : BaseActivity(), BarcodeScannerFragment.BarcodeScannerListener, View.OnClickListener {

    override fun onClick(v: View?) {
        viewModel?.getEngineerMarkOkDevice(mEngineerId, object : OnResult<EngineerMarkOkDevice> {
            override fun onResultAvailable(data: EngineerMarkOkDevice) {
                val newInstance = MarkOkListFragment.newInstance(data)
                newInstance.show(supportFragmentManager, MarkOkListFragment.TAG)
            }
        })
    }

    override fun getLayoutResId(): Int {
        return R.layout.activity_pick_mark_ok
    }

    override fun onBarcodeScanned(barcode: String) {
        scannerFragment.pauseScanner()
        viewModel?.pickMarkOkDevice(barcode, object : OnResult<PickMarkOkDevice> {
            override fun onResultAvailable(data: PickMarkOkDevice) {
                if (data.isSuccess) {
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
                        data.errorMessage,
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
    private var mEngineerId: String? = null
    lateinit var binding: ActivityPickMarkOkBinding
    var viewModel: PickMarkOkDeviceViewModel? = null

    companion object {
        const val KEY_TRAY_BARCODE = "tray_barcode"
        const val KEY_ENGINEER_ID = "tray_engineer_id"
    }

    override fun create(savedInstanceState: Bundle?, mainContainer: LinearLayout, addToParent: Boolean) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        mTrayBarcode = intent.getStringExtra(KEY_TRAY_BARCODE)
        mEngineerId = intent.getStringExtra(KEY_ENGINEER_ID)
        viewModel = ViewModelProviders.of(this, factory).get(PickMarkOkDeviceViewModel::class.java)
        viewModel?.activityListener = this
        binding.lifecycleOwner = this
        setTitle("Mark Ok Scan")
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_RUNNER_PICK_MARK_OK, null, null, true)

        val beginTransaction = supportFragmentManager.beginTransaction()
        scannerFragment = BarcodeScannerFragment.newInstance(mTrayBarcode, true, false)
        scannerFragment.setBarcodeScannerListener(this)
        beginTransaction.replace(binding.fmContainer.id, scannerFragment, BarcodeScannerFragment.TAG)
        beginTransaction.commitAllowingStateLoss()
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

        binding.btnListDevice.setOnClickListener(this)
    }

}