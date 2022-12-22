package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment.BarcodeScannerListener
import `in`.cashify.androidtrc.databinding.ActivitySelfAssignPartBinding
import `in`.cashify.androidtrc.module.engineer.data.SelfAssignViewModel
import `in`.cashify.androidtrc.module.engineer.ui.fragment.SelfAssignPartFragment
import `in`.cashify.androidtrc.util.UIHelper
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import de.keyboardsurfer.android.widget.crouton.Style

class SelfAssignPartActivity : BaseActivity() {

    private lateinit var binding: ActivitySelfAssignPartBinding
    private lateinit var viewModel: SelfAssignViewModel
    override fun getLayoutResId(): Int {
        return R.layout.activity_self_assign_part
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(SelfAssignViewModel::class.java)
        binding.lifecycleOwner = this
        binding.viewModel = viewModel
        viewModel.activityListener = this
        setTitle("View Parts")
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ENG_DEVICE_PART_SELF_ASSIGN, null, null, true)

        viewModel.newDeviceBarcode = intent.getStringExtra(OrderPartActivity.KEY_BARCODE)
        viewModel.openDeviceBarcodeScanFragment.observe(this, Observer {
            var scannerFragment = BarcodeScannerFragment.newInstance(null, true, false)
            scannerFragment.setBarcodeScannerListener(object : BarcodeScannerListener {
                override fun onBarcodeScanned(barcode: String) {
                    viewModel.deviceBarcode.value = barcode
                    supportFragmentManager.popBackStack()
                }

                override fun hideLayout(show: Boolean) {

                }

            })


            mActivityHelper.addFragment(this, scannerFragment, binding.container.id, true)
        })


        viewModel.openPartBarcodeScanFragment.observe(this, Observer {
            var scannerFragment = BarcodeScannerFragment.newInstance(null, true, false)
            scannerFragment.setBarcodeScannerListener(object : BarcodeScannerListener {
                override fun onBarcodeScanned(barcode: String) {
                    viewModel.partBarcode.value = barcode
                    supportFragmentManager.popBackStack()
                }

                override fun hideLayout(show: Boolean) {

                }

            })


            mActivityHelper.addFragment(this, scannerFragment, binding.container.id, true)
        })

        openSelfAssignFragment()


    }


    override fun getContainerId(): Int {
        return R.id.container
    }


    private fun openSelfAssignFragment() {
        val fragment = SelfAssignPartFragment.newInstance()
        mActivityHelper.addFragment(this, fragment, binding.container.id, true)
    }


    override fun onBackPressed() {


        if(supportFragmentManager.backStackEntryCount == 1){
            finish()
        }

        else{
            super.onBackPressed()
        }
    }


    override fun showError(msg: String?) {
        UIHelper.showSnackBar(this, msg.toString(), Style.ALERT, null)
    }


}