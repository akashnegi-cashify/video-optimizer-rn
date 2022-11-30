package `in`.cashify.androidtrc.module.runner.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityGivenDeviceBinding
import `in`.cashify.androidtrc.module.runner.data.DeviceAllocatedViewModel
import android.annotation.SuppressLint
import android.graphics.Color
import android.os.Bundle
import android.view.MotionEvent
import android.view.View
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.google.android.material.tabs.TabLayout


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class GivenDeviceActivity : BaseActivity(), SwipeRefreshLayout.OnRefreshListener {
    override fun onRefresh() {
        binding.swipeLayout.setRefreshing(false)
        val selectedTabPosition = binding.slidingTabs.getSelectedTabPosition()
        deviceAllocatedViewModel.makeRequest(selectedTabPosition)
    }

    private lateinit var deviceAllocatedViewModel: DeviceAllocatedViewModel
    private lateinit var binding: ActivityGivenDeviceBinding

    override fun getLayoutResId(): Int {
        return R.layout.activity_given_device
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun create(savedInstanceState: Bundle?, mainContainer: LinearLayout, addToParent: Boolean) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        deviceAllocatedViewModel = ViewModelProviders.of(this, factory).get(DeviceAllocatedViewModel::class.java)
        binding.lifecycleOwner = this
        binding.deviceAllocatedViewModel = deviceAllocatedViewModel
        deviceAllocatedViewModel.activityListener = this
        binding.swipeLayout.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        binding.swipeLayout.setOnRefreshListener(this)
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Pending Pick up"))
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Picked up"))
        deviceAllocatedViewModel.createGivenPagerAdapter(supportFragmentManager, binding.slidingTabs.tabCount)
        binding.vpDeviceDetail.adapter = deviceAllocatedViewModel.adapter
        binding.vpDeviceDetail.addOnPageChangeListener(TabLayout.TabLayoutOnPageChangeListener(binding.slidingTabs))
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_RUNNER_GIVEN_DEVICE, null, null, true)

        binding.slidingTabs.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabReselected(tab: TabLayout.Tab?) {

            }

            override fun onTabUnselected(tab: TabLayout.Tab?) {

            }

            override fun onTabSelected(tab: TabLayout.Tab?) {
                if (tab != null) {
                    binding.vpDeviceDetail.currentItem = tab.position
                    deviceAllocatedViewModel.makeRequest(tab.position)
                }
            }
        })

        binding.vpDeviceDetail.setOnTouchListener(object : View.OnTouchListener {
            override fun onTouch(v: View?, event: MotionEvent?): Boolean {

                when (event?.getAction()) {
                    MotionEvent.ACTION_MOVE -> binding.swipeLayout.setEnabled(false)
                    MotionEvent.ACTION_UP, MotionEvent.ACTION_CANCEL -> binding.swipeLayout.setEnabled(true)
                }

                return false
            }

        })
        if (savedInstanceState == null) {
            deviceAllocatedViewModel.getDeviceAllocatedToEngineer(false)
        }
    }

}