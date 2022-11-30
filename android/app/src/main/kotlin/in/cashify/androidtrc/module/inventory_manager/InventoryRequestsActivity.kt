package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityInventoryRequestsBinding
import `in`.cashify.androidtrc.module.inventory_manager.fragment.pending.IMPendingPartDeliveryFragment
import `in`.cashify.androidtrc.module.inventory_manager.fragment.pending.IMPendingPartDeliveryFragment.Companion.ENG_ID
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil

class InventoryRequestsActivity : BaseActivity() {
    private lateinit var binding: ActivityInventoryRequestsBinding

    override fun getLayoutResId(): Int {
        return R.layout.activity_inventory_requests
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {

        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        setTitle(getString(R.string.pending_delivery))
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_INVENTORY_REQUEST, null, null, true)

        val fragment: IMPendingPartDeliveryFragment =
            IMPendingPartDeliveryFragment.newInstance(intent.getIntExtra(ENG_ID, 0))
        mActivityHelper.replaceFragment(this, fragment, binding.container.id, true)
    }

    override fun getContainerId(): Int {
        return R.id.container
    }

    override fun onBackPressed() {
        finish()
    }

}