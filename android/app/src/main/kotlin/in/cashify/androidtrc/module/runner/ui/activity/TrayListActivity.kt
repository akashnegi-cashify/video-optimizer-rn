package `in`.cashify.androidtrc.module.runner.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityTrayListBinding
import `in`.cashify.androidtrc.module.runner.api.response.device_list.DeviceInfoAllocatedToEng
import `in`.cashify.androidtrc.module.runner.data.TrayActivityViewModel
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
 * Created by Avaneesh Maurya on 23,July,2019
 */
class TrayListActivity : BaseActivity(), SwipeRefreshLayout.OnRefreshListener {

    var mDeviceInfo: DeviceInfoAllocatedToEng? = null

    companion object {
        const val KEY_DEVICE_INFO = "key_device_list"
    }

    override fun onRefresh() {

    }

    private lateinit var trayActivityViewModel: TrayActivityViewModel
    private lateinit var binding: ActivityTrayListBinding

    override fun getLayoutResId(): Int {
        return R.layout.activity_tray_list
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun create(savedInstanceState: Bundle?, mainContainer: LinearLayout, addToParent: Boolean) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        trayActivityViewModel = ViewModelProviders.of(this, factory).get(TrayActivityViewModel::class.java)
        binding.lifecycleOwner = this
        mDeviceInfo = intent.getParcelableExtra(KEY_DEVICE_INFO)
        binding.trayViewModel = trayActivityViewModel
        trayActivityViewModel.activityListener = this
        setTitle("Tray List")
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_RUNNER_TRAY_LIST, null, null, true)

        binding.swipeLayout.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        binding.swipeLayout.setOnRefreshListener(this)
        binding.tvTrayCount.text = """Total Trays to be scanned- ${trayActivityViewModel.trayCount.value}"""
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Pending Scan"))
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Tray Scanned"))
        trayActivityViewModel.createTrayPagerAdapter(supportFragmentManager, binding.slidingTabs.tabCount)
        binding.vpDeviceDetail.adapter = trayActivityViewModel.pagerAdapter
        binding.vpDeviceDetail.addOnPageChangeListener(TabLayout.TabLayoutOnPageChangeListener(binding.slidingTabs))
        binding.slidingTabs.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabReselected(tab: TabLayout.Tab?) {

            }

            override fun onTabUnselected(tab: TabLayout.Tab?) {

            }

            override fun onTabSelected(tab: TabLayout.Tab?) {
                if (tab != null) {
                    binding.vpDeviceDetail.currentItem = tab.position
                    trayActivityViewModel.makeRequest(tab.position, mDeviceInfo)
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
            trayActivityViewModel.getTrayList(false, mDeviceInfo)
        }
    }
}