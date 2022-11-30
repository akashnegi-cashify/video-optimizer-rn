package `in`.cashify.androidtrc.module.inventory_manager.fragment.assigned

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerPendingPartBinding
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerAssignedPartViewModel

import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

class IMDeviceAssignedActivity: BaseActivity() {
    private lateinit var binding: ActivityInventoryManagerPendingPartBinding
    private lateinit var pendingPartViewModel: InventoryManagerAssignedPartViewModel

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
            InventoryManagerAssignedPartViewModel::class.java)
        pendingPartViewModel.activityListener = this
        pendingPartViewModel.deviceId = intent?.getStringExtra("did")

        pendingPartViewModel.deviceId
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_IM_DEVICE_ASSIGN, null, null, true)

        mActivityHelper.replaceFragment(this, IMAssignedDeviceDetailsFragment.newInstance() , binding?.container?.id, true)




    }


    override fun getContainerId(): Int {
        return binding.container?.id
    }


    override fun onBackPressed() {




        if(supportFragmentManager.backStackEntryCount == 1){
            finish()
        }
        else{
            super.onBackPressed()
        }
    }
}
