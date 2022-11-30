package `in`.cashify.androidtrc.module.rubbing_engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityScanRubbingBarcodeBinding
import `in`.cashify.androidtrc.module.rubbing_engineer.data.RubbingViewModel
import `in`.cashify.androidtrc.module.rubbing_engineer.ui.fragment.ReceivedRubbingDeviceFragment
import `in`.cashify.androidtrc.module.rubbing_engineer.ui.fragment.ScanRubbingBarcodeFragment
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.FragmentTransaction
import androidx.lifecycle.ViewModelProvider


class RubbingActivity : BaseActivity() {

   private lateinit var beginTransaction: FragmentTransaction
    override fun getLayoutResId(): Int {
        return R.layout.activity_scan_rubbing_barcode
    }

    lateinit var binding: ActivityScanRubbingBarcodeBinding
    private lateinit var viewModel: RubbingViewModel
    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProvider(this, factory).get(RubbingViewModel::class.java)
        binding.lifecycleOwner = this
        binding.viewModel = viewModel
        viewModel.activityListener = this
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_RUBBING, null, null, true)


        if(intent.getBooleanExtra(IS_SCANNING,true)){
            beginTransaction = supportFragmentManager.beginTransaction()
            beginTransaction.replace(
                binding.fmContainer.id,
                ScanRubbingBarcodeFragment(),
                "ScanRubbingBarcodeFragment"
            )
            beginTransaction.commitAllowingStateLoss()
        }else{
            openDevicesFragment("")
        }


    }

    companion object{
        var IS_SCANNING="is_scanning_rubbing"
    }

    fun openDevicesFragment(barcode:String){

        beginTransaction = supportFragmentManager.beginTransaction()

        beginTransaction.replace(
            binding.fmContainer.id,
            ReceivedRubbingDeviceFragment.newInstance(barcode),
            "ReceivedRubbingDeviceFragment"
        )
        beginTransaction.commitAllowingStateLoss()
    }

}