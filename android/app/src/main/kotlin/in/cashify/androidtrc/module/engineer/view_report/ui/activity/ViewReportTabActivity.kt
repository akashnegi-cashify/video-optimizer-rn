package `in`.cashify.androidtrc.module.engineer.view_report.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity

import `in`.cashify.androidtrc.databinding.ActivityViewReportTabBinding

import `in`.cashify.androidtrc.module.engineer.view_report.data.ViewReportViewModel
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.google.android.material.tabs.TabLayout

class ViewReportTabActivity: BaseActivity(),
    View.OnClickListener {

    private lateinit var viewModel: ViewReportViewModel
    lateinit var binding: ActivityViewReportTabBinding




    override fun getLayoutResId(): Int {
      return R.layout.activity_view_report_tab
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel =
            ViewModelProviders.of(this, factory).get(ViewReportViewModel::class.java)
        binding.lifecycleOwner = this


        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Device"))
        binding.slidingTabs.addTab(binding.slidingTabs.newTab().setText("Parts"))
        viewModel.createPartPagerAdapter(supportFragmentManager, binding.slidingTabs.tabCount)
        binding.viewPager.adapter = viewModel.adapter
        binding.viewPager.addOnPageChangeListener(TabLayout.TabLayoutOnPageChangeListener(binding.slidingTabs))
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_VIEW_REPORT, null, null, true)

        binding.slidingTabs.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener {
            override fun onTabReselected(tab: TabLayout.Tab?) {

            }

            override fun onTabUnselected(tab: TabLayout.Tab?) {

            }

            override fun onTabSelected(tab: TabLayout.Tab?) {
                if (tab != null) {
                    binding.viewPager.currentItem = tab.position

                }
            }
        })

    }

    override fun onClick(v: View?) {

    }



}