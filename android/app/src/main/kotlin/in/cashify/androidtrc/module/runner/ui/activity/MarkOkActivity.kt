package `in`.cashify.androidtrc.module.runner.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityMarkOkBinding
import `in`.cashify.androidtrc.module.runner.data.MarkOkViewModel
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
class MarkOkActivity : BaseActivity(), SwipeRefreshLayout.OnRefreshListener {
    override fun onRefresh() {
        binding.swipeLayout.setRefreshing(false)
        val selectedTabPosition = binding.slidingTabs.getSelectedTabPosition()
        markOkViewModel.makeRequest(selectedTabPosition)
    }

    private lateinit var markOkViewModel: MarkOkViewModel
    private lateinit var binding: ActivityMarkOkBinding

    override fun getLayoutResId(): Int {
        return R.layout.activity_mark_ok
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun create(savedInstanceState: Bundle?, mainContainer: LinearLayout, addToParent: Boolean) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        markOkViewModel = ViewModelProviders.of(this, factory).get(MarkOkViewModel::class.java)
        binding.lifecycleOwner = this
        binding.markOkViewModel = markOkViewModel
        markOkViewModel.activityListener = this
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_RUNNER_MARK_OK, null, null, true)

        binding.swipeLayout.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        binding.swipeLayout.setOnRefreshListener(this)
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Pending Pick up"))
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Picked up"))
        markOkViewModel.createMarkOkPagerAdapter(supportFragmentManager, binding.slidingTabs.tabCount)
        binding.vpDeviceDetail.adapter = markOkViewModel.pagerAdapter
        binding.vpDeviceDetail.addOnPageChangeListener(TabLayout.TabLayoutOnPageChangeListener(binding.slidingTabs))
        binding.slidingTabs.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabReselected(tab: TabLayout.Tab?) {

            }

            override fun onTabUnselected(tab: TabLayout.Tab?) {

            }

            override fun onTabSelected(tab: TabLayout.Tab?) {
                if (tab != null) {
                    binding.vpDeviceDetail.currentItem = tab.position
                    markOkViewModel.makeRequest(tab.position)
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
            markOkViewModel.makeRequest(0)
        }
    }

}