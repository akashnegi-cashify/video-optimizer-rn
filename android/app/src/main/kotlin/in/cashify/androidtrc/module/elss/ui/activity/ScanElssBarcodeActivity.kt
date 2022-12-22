package `in`.cashify.androidtrc.module.elss.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityScanElssBarcodeBinding
import `in`.cashify.androidtrc.module.elss.data.ElssViewModel
import `in`.cashify.androidtrc.module.elss.ui.fragment.ScanElssBarcodeFragment
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider


class ScanElssBarcodeActivity : BaseActivity() {
    override fun getLayoutResId(): Int {
        return R.layout.activity_scan_elss_barcode
    }

    lateinit var binding: ActivityScanElssBarcodeBinding
    private lateinit var viewModel: ElssViewModel
    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProvider(this, factory).get(ElssViewModel::class.java)
        binding.lifecycleOwner = this
        binding.viewModel = viewModel
        viewModel.activityListener = this
        val beginTransaction = supportFragmentManager.beginTransaction()
        beginTransaction.replace(
            binding.fmContainer.id,
            ScanElssBarcodeFragment(),
            "ScanElssBarcodeFragment"
        )
        beginTransaction.commitAllowingStateLoss()

        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ELSS_BARCODE, null, null, true)

    }

}