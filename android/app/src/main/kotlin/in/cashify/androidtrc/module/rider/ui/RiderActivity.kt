package `in`.cashify.androidtrc.module.rider.ui

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityRiderBinding
import `in`.cashify.androidtrc.module.rider.adapter.RiderViewpagerAdapter
import `in`.cashify.androidtrc.module.rider.data.RiderActivityViewModel
import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator

class RiderActivity : BaseActivity(), View.OnClickListener{


    private lateinit var binding: ActivityRiderBinding
    var viewModel: RiderActivityViewModel? = null

    override fun getLayoutResId(): Int {
        return R.layout.activity_rider
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProvider(this, factory).get(RiderActivityViewModel::class.java)

        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_RIDER, null, null, true)

        binding.viewPager.setAdapter(RiderViewpagerAdapter(supportFragmentManager, lifecycle))
        TabLayoutMediator(binding.tabLayout, binding.viewPager, object : TabLayoutMediator.TabConfigurationStrategy
        {
            override fun onConfigureTab(tab: TabLayout.Tab, position: Int) {
                if(position == 0) {
                    tab.text = resources.getString(R.string.pending_delivery)
                }

                if(position == 1){
                    tab.text =resources.getString(R.string.pending_pickup)
                }
            }

        }).attach()
    }

    override fun onClick(v: View?) {

    }
}