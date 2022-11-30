package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.ActivityEngineerDevicePartAssignedListBinding
import `in`.cashify.androidtrc.databinding.FragmentEngPartBinding
import `in`.cashify.androidtrc.module.engineer.adapter.EngDevicePartInfoAdapter
import `in`.cashify.androidtrc.module.engineer.adapter.EngPartInfoAdapter
import `in`.cashify.androidtrc.module.engineer.api.response.CancelPartResponse
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.data.EngDevicePartAssignedListViewModel
import `in`.cashify.androidtrc.module.engineer.data.EngPartListActivityListener
import `in`.cashify.androidtrc.module.engineer.data.EngPartsViewModel
import `in`.cashify.androidtrc.util.CommonConstant
import `in`.cashify.androidtrc.util.UIHelper
import android.content.Intent
import android.graphics.Paint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import de.keyboardsurfer.android.widget.crouton.Style

class EngineerDevicePartAssignedListActivity : BaseActivity(),
    EngDevicePartInfoAdapter.OnItemClickListener{

    var engPartViewModel: EngDevicePartAssignedListViewModel? = null



    lateinit var binding: ActivityEngineerDevicePartAssignedListBinding
    var partInfoAdapter: EngDevicePartInfoAdapter? = null
    override fun getLayoutResId(): Int {
        return R.layout.activity_engineer_device_part_assigned_list
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        engPartViewModel = ViewModelProviders.of(this, factory).get(
            EngDevicePartAssignedListViewModel::class.java
        )
        getSupportActionBar()?.setDisplayHomeAsUpEnabled(true);
        binding.lifecycleOwner = this
        engPartViewModel?.activityListener = this
//        engPartViewModel?.engPartListListener = this
        partInfoAdapter = EngDevicePartInfoAdapter(engPartViewModel!!, false, this)
        binding.rvDevices.layoutManager = LinearLayoutManager(this, RecyclerView.VERTICAL, false)
        binding.rvDevices.adapter = partInfoAdapter
//        partInfoAdapter?.changeDataSet(mPartList)
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ENG_DEVICE_PART_ASSIGN, null, null, true)


        engPartViewModel?.partList?.observe(this, Observer {

            if (it.isEmpty()) {

                UIHelper.showSnackBar(this , String.format(resources.getString(R.string.no_parts_available_for), intent.getStringExtra("barcode")), Style.ALERT, null)

            } else {
                partInfoAdapter?.setData(it)
            }
        })



        binding.tvDeviceBarcode.setText(intent.getStringExtra("barcode"))
        binding.tvDeviceStatus.setText(intent.getStringExtra("status"))
        binding.tvDeviceProductTitle.setText(intent.getStringExtra("title"))


    }


    override fun onResume() {
        super.onResume()
        engPartViewModel?.getEngPartInfoList(intent.getStringExtra("did") ?: "")
    }





//    override fun inflateScanner(prid: Int?) {
//        val intent = Intent(
//            this,
//            ScanAllowedPartsActivity::class.java
//        ).apply {
//
//            putExtra("prid", prid.toString())
//        }
//        startActivity(
//            intent
//        )
//    }

    override fun itemClick(info: EngineerPartInfo) {
        startActivity(Intent(this , EngineerPartInfoActivity::class.java).apply {
            putExtra("did", intent.getStringExtra("did"))
            putExtra("barcode",intent.getStringExtra("barcode"))
            putExtra("status", intent.getStringExtra("status"))
            putExtra("title", intent.getStringExtra("title"))
            putExtra(CommonConstant.KEY_PART_INFO ,info )
        })



    }


}