package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityEngPartListBinding
import `in`.cashify.androidtrc.module.engineer.data.EngPartListActivityListener
import `in`.cashify.androidtrc.module.engineer.data.EngPartsViewModel
import android.annotation.SuppressLint
import android.content.Intent
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
class EngPartListActivity : BaseActivity(), SwipeRefreshLayout.OnRefreshListener , EngPartListActivityListener {
    override fun onRefresh() {
        binding.swipeLayout.setRefreshing(false)
        val selectedTabPosition = binding.slidingTabs.getSelectedTabPosition()
        engPartViewModel.makeRequest(selectedTabPosition)
    }

    private lateinit var engPartViewModel: EngPartsViewModel
    private lateinit var binding: ActivityEngPartListBinding

    override fun getLayoutResId(): Int {
        return R.layout.activity_eng_part_list
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun create(savedInstanceState: Bundle?, mainContainer: LinearLayout, addToParent: Boolean) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        engPartViewModel = ViewModelProviders.of(this, factory).get(EngPartsViewModel::class.java)
        binding.lifecycleOwner = this
        binding.partInfoViewModel = engPartViewModel
        engPartViewModel.activityListener = this
        engPartViewModel.engPartListListener = this
        binding.swipeLayout.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        binding.swipeLayout.setOnRefreshListener(this)
        setTitle("Manage Parts")
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Received"))
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Consumed"))
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Pending"))
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Assigned"))
        engPartViewModel.createPartPagerAdapter(supportFragmentManager, binding.slidingTabs.tabCount)
        binding.vpDeviceDetail.adapter = engPartViewModel.adapter
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ENG_DEVICE_PART_LIST, null, null, true)

        binding.vpDeviceDetail.addOnPageChangeListener(TabLayout.TabLayoutOnPageChangeListener(binding.slidingTabs))
        binding.slidingTabs.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabReselected(tab: TabLayout.Tab?) {

            }

            override fun onTabUnselected(tab: TabLayout.Tab?) {

            }

            override fun onTabSelected(tab: TabLayout.Tab?) {
                if (tab != null) {
                    binding.vpDeviceDetail.currentItem = tab.position
                    engPartViewModel.makeRequest(tab.position)
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
        
        if (savedInstanceState == null)
        {
            engPartViewModel.makeRequest(0)
        }
    }



    override fun onRestart()
    {
        super.onRestart()

        engPartViewModel.makeRequest(binding.vpDeviceDetail.currentItem)

    }

    override fun onStop()
    {
        super.onStop()
    }


    override fun inflateScanner(prid:Int?)
    {
        val intent = Intent(
                this,
                ScanAllowedPartsActivity::class.java
        ).apply {

            putExtra("prid", prid.toString())
        }
        startActivity(
                intent
        )    }

}