package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerReturnBinding
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerSummaryBinding
import `in`.cashify.androidtrc.module.inventory_manager.adapter.IMPartDevicesStatusAdapter
import `in`.cashify.androidtrc.module.inventory_manager.fragment.InventoryManagerSummaryFragment
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

class InventoryManagerReturnActivity : BaseActivity()  {


    private lateinit var binding: ActivityInventoryManagerReturnBinding
    private lateinit var viewModel: InventoryManagerReturnViewModel

    override fun getLayoutResId(): Int {
        return R.layout.activity_inventory_manager_return
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(InventoryManagerReturnViewModel::class.java)
        viewModel.activityListener = this
        getSupportActionBar()?.setDisplayHomeAsUpEnabled(true);
        setTitle(resources.getString(R.string.returns))
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_INVENTORY_MANAGER_RETURN, null, null, true)

        binding?.tabLayout?.setupWithViewPager(binding?.viewPager)
        binding?.viewPager?.adapter = IMPartDevicesStatusAdapter(supportFragmentManager, InventoryManagerEnum.RETURNS.value?:InventoryManagerEnum.DELIVERY.value)

    }

    override fun getContainerId(): Int {
        return R.id.container
    }

}