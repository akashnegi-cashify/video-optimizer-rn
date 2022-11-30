package `in`.cashify.androidtrc.module.inventory_manager.fragment.receive

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityIMReceiveScanAcitityBinding
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerPendingPartBinding
import `in`.cashify.androidtrc.module.inventory_manager.IMReceiveScanActivityViewModel
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerAssignedPartViewModel
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

class IMReceiveScanAcitity : BaseActivity() {
    private lateinit var binding: ActivityIMReceiveScanAcitityBinding
    private lateinit var viewModel: IMReceiveScanActivityViewModel


    override fun getLayoutResId(): Int {
 return R.layout.activity_i_m_receive_scan_acitity
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(
            IMReceiveScanActivityViewModel::class.java)
        viewModel.activityListener = this
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_IM_RECEIVE_SCAN, null, null, true)

        mActivityHelper?.addFragment(this ,IMReceiveScanFragment.newInstance(), binding.container.id , true)
    }


    override fun onBackPressed() {
        if(supportFragmentManager.backStackEntryCount == 1){
            finish()
        }
        else {
            super.onBackPressed()
        }
    }
}