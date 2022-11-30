package `in`.cashify.androidtrc.module.rider.ui.delivery

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityPendingPartsDelivertoEngineerBinding
import `in`.cashify.androidtrc.databinding.ActivityRiderBinding
import `in`.cashify.androidtrc.module.rider.adapter.PendingPartDeliverToEngineerAdapter
import `in`.cashify.androidtrc.module.rider.data.PendingPartDeliverToEngineerViewModel
import `in`.cashify.androidtrc.module.rider.data.RiderActivityViewModel
import `in`.cashify.androidtrc.module.rider.data.response.RiderDeliverPendingReceivePartResponse
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager

class PendingPartsDelivertoEngineerActivity : BaseActivity(), View.OnClickListener{


    private lateinit var binding: ActivityPendingPartsDelivertoEngineerBinding
    var viewModel: PendingPartDeliverToEngineerViewModel? = null
    var adapter: PendingPartDeliverToEngineerAdapter? = null



    override fun getLayoutResId(): Int {
 return R.layout.activity_pending_parts_deliverto_engineer
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProvider(this, factory).get(PendingPartDeliverToEngineerViewModel::class.java)
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_PENDING_PART_DEL_TO_ENG, null, null, true)

viewModel?.activityListener = this



        adapter = PendingPartDeliverToEngineerAdapter(object : PendingPartDeliverToEngineerAdapter.OnPartClickListener
        {
            override fun partClick(list: RiderDeliverPendingReceivePartResponse.Data) {

            }

        })
        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = adapter



        viewModel?.listEngineerParts(intent.getIntExtra("id", 0))

        viewModel?.engineerPartsResponse?.observe(this, Observer {
            adapter?.setData(it.data)
        })

        binding.tvEngineerName.text = intent.getStringExtra("name")

        binding.tvLocation.text = intent.getStringExtra("loc")

    }




    override fun onClick(v: View?) {

    }
}