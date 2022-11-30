package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityEngineerDevicePartAssignedListBinding
import `in`.cashify.androidtrc.databinding.ActivityEngineerMyDevicesTabBinding
import `in`.cashify.androidtrc.module.engineer.adapter.EngineerMyDeviceViewPagerAdapter
import `in`.cashify.androidtrc.module.engineer.data.EngineerMyDevicesTabViewModel
import `in`.cashify.androidtrc.module.inventory_manager.adapter.IMPartDevicesStatusAdapter
import `in`.cashify.androidtrc.module.runner.data.HomeViewModel
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

class EngineerMyDevicesTabActivity : BaseActivity() {
    var binding:ActivityEngineerMyDevicesTabBinding? = null
    var viewModel: EngineerMyDevicesTabViewModel? = null

    override fun getLayoutResId(): Int {
      return R.layout.activity_engineer_my_devices_tab
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(EngineerMyDevicesTabViewModel::class.java)
        binding?.lifecycleOwner = this
       viewModel?.activityListener = this


        binding?.tabLayout?.setupWithViewPager(binding!!.viewPager)
        binding?.viewPager?.adapter = EngineerMyDeviceViewPagerAdapter(supportFragmentManager, resources)
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_DEVICES_TAB, null, null, true)

    }
}