package `in`.cashify.androidtrc.module.qc

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityQCBinding
import `in`.cashify.androidtrc.module.qc.adapter.QCViewPagerAdapter
import android.os.Bundle
import android.widget.LinearLayout
import androidx.annotation.NonNull
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator

class QCActivity : BaseActivity() {
    var binding: ActivityQCBinding? = null
    var viewModel: QCActivityViewModel? = null


    override fun getLayoutResId(): Int {
        return R.layout.activity_q_c
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        setTitle("Parts QC")

        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_QC, null, null, true)

        viewModel = ViewModelProvider(this, factory).get(QCActivityViewModel::class.java)
        viewModel?.activityListener = this



        binding?.viewPager?.setAdapter(QCViewPagerAdapter(supportFragmentManager, lifecycle))
       TabLayoutMediator(binding?.tabLayout!!, binding?.viewPager!!, object : TabLayoutMediator.TabConfigurationStrategy
       {
           override fun onConfigureTab(tab: TabLayout.Tab, position: Int) {
               if(position == 0) {
                   tab.text = resources.getString(R.string.home)
               }

               if(position == 1){
                   tab.text =resources.getString(R.string.qc_pending)
               }
           }

       }).attach()
    }
}