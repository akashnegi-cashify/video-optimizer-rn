package `in`.cashify.androidtrc.module.inventory_manager.fragment.pending

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerPendingPartBinding
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerPendingPartViewModel
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

class InventoryManagerPendingPartActivity: BaseActivity() {
    private lateinit var binding: ActivityInventoryManagerPendingPartBinding
    private lateinit var pendingPartViewModel: InventoryManagerPendingPartViewModel

    override fun getLayoutResId(): Int {
        return R.layout.activity_inventory_manager_pending_part
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        pendingPartViewModel = ViewModelProviders.of(this, factory).get(
            InventoryManagerPendingPartViewModel::class.java)
        pendingPartViewModel.activityListener = this
        pendingPartViewModel.deviceId = intent?.getStringExtra("did")
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_IM_PENDING_PART, null, null, true)

        pendingPartViewModel.deviceId
        mActivityHelper.replaceFragment(this, IMPendingDeviceDetailsFragment.newInstance(pendingPartViewModel?.deviceId?:"") , binding?.container?.id, true)




    }


    override fun getContainerId(): Int {
        return binding.container?.id
    }


    override fun onBackPressed() {



            val fragment =
                supportFragmentManager.findFragmentByTag(IMPendingPartBarcodeAssignedFragment::class.java.simpleName)
            if ((fragment is IMPendingPartBarcodeAssignedFragment && fragment.onBackPressed())) {


            } else if (supportFragmentManager.backStackEntryCount == 1) {
                finish()
            } else {
                super.onBackPressed()
            }

    }
    

}
