package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerBinding
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerSummaryBinding
import `in`.cashify.androidtrc.module.inventory_manager.fragment.InventoryManagerSummaryFragment
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

class InventoryManagerSummaryActivity : BaseActivity()  {


    private lateinit var binding: ActivityInventoryManagerSummaryBinding
    private lateinit var viewModel: InventoryManagerSummaryViewModel

    override fun getLayoutResId(): Int {
        return R.layout.activity_inventory_manager_summary
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(InventoryManagerSummaryViewModel::class.java)
        viewModel.activityListener = this
        getSupportActionBar()?.setDisplayHomeAsUpEnabled(true);
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_INVENTORY_MANAGER_SUMMERY, null, null, true)

        setTitle(resources.getString(R.string.summary))
        mActivityHelper.replaceFragment(
            this,
            InventoryManagerSummaryFragment.newInstance(),
            getContainerId(),
            true
        )
    }

    override fun getContainerId(): Int {
        return R.id.container
    }

    override fun onBackPressed() {
   finish()

    }

}