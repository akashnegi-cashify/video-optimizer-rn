package `in`.cashify.androidtrc.module.runner.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityMarkL4Binding
import `in`.cashify.androidtrc.module.runner.data.L4ViewModel
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
class MarkL4Activity : BaseActivity(), SwipeRefreshLayout.OnRefreshListener {
    override fun onRefresh() {
        binding.swipeLayout.setRefreshing(false)
        val selectedTabPosition = binding.slidingTabs.getSelectedTabPosition()
        l4ViewModel.makeRequest(selectedTabPosition)
    }

    private lateinit var l4ViewModel: L4ViewModel
    private lateinit var binding: ActivityMarkL4Binding

    override fun getLayoutResId(): Int {
        return R.layout.activity_mark_l4
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun create(savedInstanceState: Bundle?, mainContainer: LinearLayout, addToParent: Boolean) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        l4ViewModel = ViewModelProviders.of(this, factory).get(L4ViewModel::class.java)
        binding.lifecycleOwner = this
        binding.l4ViewModel = l4ViewModel
        l4ViewModel.activityListener = this
        binding.swipeLayout.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        binding.swipeLayout.setOnRefreshListener(this)
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Pending"))
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("On Ground"))
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_RUNNER_MARK_L4, null, null, true)

        l4ViewModel.createMarkOkPagerAdapter(supportFragmentManager, binding.slidingTabs.tabCount)
        binding.vpDeviceDetail.adapter = l4ViewModel.pagerAdapter
        binding.vpDeviceDetail.addOnPageChangeListener(TabLayout.TabLayoutOnPageChangeListener(binding.slidingTabs))
        binding.slidingTabs.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabReselected(tab: TabLayout.Tab?) {

            }

            override fun onTabUnselected(tab: TabLayout.Tab?) {

            }

            override fun onTabSelected(tab: TabLayout.Tab?) {
                if (tab != null) {
                    binding.vpDeviceDetail.currentItem = tab.position
                    l4ViewModel.makeRequest(tab.position)
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
            l4ViewModel.makeRequest(0)
        }
    }

}