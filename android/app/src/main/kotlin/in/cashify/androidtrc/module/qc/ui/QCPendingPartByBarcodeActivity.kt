package `in`.cashify.androidtrc.module.qc.ui

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.ActivityQCBinding
import `in`.cashify.androidtrc.databinding.ActivityQCPendingPartByBarcodeBinding
import `in`.cashify.androidtrc.module.qc.QCActivityViewModel
import `in`.cashify.androidtrc.module.qc.QCPendingByBarcodeViewModel
import `in`.cashify.androidtrc.module.qc.adapter.QCPendingAdapter
import `in`.cashify.androidtrc.module.qc.adapter.QCViewPagerAdapter
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator

class QCPendingPartByBarcodeActivity : BaseActivity() {
    var binding: ActivityQCPendingPartByBarcodeBinding? = null
    var viewModel: QCPendingByBarcodeViewModel? = null
    var adapter: QCPendingAdapter? = null
    var response: ArrayList<QCPendingListResponse.Data>?=null

    override fun getLayoutResId(): Int {
        return R.layout.activity_q_c_pending_part_by_barcode
    }
    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        setTitle(getString(R.string.app_name))
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_QC_PART_PENDING_PART_SCAN, null, null, true)

        binding?.lifecycleOwner = this
        viewModel = ViewModelProvider(this, factory).get(QCPendingByBarcodeViewModel::class.java)

response = intent.getParcelableArrayListExtra<QCPendingListResponse.Data>("data") as ArrayList<QCPendingListResponse.Data>
        binding?.recyclerView?.layoutManager = LinearLayoutManager(this)
        adapter = QCPendingAdapter(object :
            QCPendingAdapter.PendingPartClickListener {
            override fun pendingPartClick(pos: Int) {
                startActivity(Intent(this@QCPendingPartByBarcodeActivity, QCPendingPartDetailsActivity::class.java).apply {
                    putExtra("data", response?.get(pos))

                })


                finish()
            }

        }).apply {
            setData( response?:ArrayList<QCPendingListResponse.Data>() )
        }

        binding?.recyclerView?.adapter = adapter









    }
}