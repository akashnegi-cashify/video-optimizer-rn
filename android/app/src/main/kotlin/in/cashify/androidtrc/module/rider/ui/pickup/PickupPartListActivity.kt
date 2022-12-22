package `in`.cashify.androidtrc.module.rider.ui.pickup

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityPendingPartsDelivertoEngineerBinding
import `in`.cashify.androidtrc.databinding.ActivityPickupPartListBinding

import `in`.cashify.androidtrc.module.rider.adapter.PickUpPartListAdapter
import `in`.cashify.androidtrc.module.rider.data.PendingPartDeliverToEngineerViewModel
import `in`.cashify.androidtrc.module.rider.data.PickupPartListActivityViewmodel
import `in`.cashify.androidtrc.module.rider.data.response.RiderDeliverPendingReceivePartResponse
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.LinearLayoutManager

class PickupPartListActivity : BaseActivity(), View.OnClickListener{


    private lateinit var binding: ActivityPickupPartListBinding
    var viewModel: PickupPartListActivityViewmodel? = null
    var adapter: PickUpPartListAdapter? = null

    var REQ_CODE = 100


    var selectedPart:RiderDeliverPendingReceivePartResponse.Data? = null


    var selectedPartBBarcode:String? = ""




    override fun getLayoutResId(): Int {
        return R.layout.activity_pickup_part_list
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProvider(this, factory).get(PickupPartListActivityViewmodel::class.java)

        viewModel?.activityListener = this
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_PICKUP_PART_LIST, null, null, true)


//
//
        adapter = PickUpPartListAdapter(this::partClick)
        binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = adapter
        viewModel?.pickupEngineerPartsResponse?.value = null

        viewModel?.receiveEngineerPartsResponse?.value = null
viewModel?.pickupEngineerPartsResponse?.observe(this, Observer {
    it?.let {

        adapter?.setData(it.data)


    }
})


        viewModel?.receiveEngineerPartsResponse?.observe(this, Observer {
            it?.let {
                showReceiveSuccessDialog()
//                viewModel?.pickUpEngineerParts(intent.getIntExtra("id", 0))



            }
        })




        viewModel?.pickUpEngineerParts(intent.getIntExtra("id", 0))

        binding.tvEngineerName.text = intent.getStringExtra("name")

        binding.tvLocation.text = intent.getStringExtra("loc")

    }

    private fun partClick(data:RiderDeliverPendingReceivePartResponse.Data) {
        selectedPart = data
startActivityForResult(Intent(this , PickupPartFromEngineerScanActivity::class.java).apply {
putExtra("name", data.partName)
    putExtra("sku", data.partSku)
    putExtra("color", data.partColor)

}, REQ_CODE)
    }


    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if(requestCode == REQ_CODE && resultCode == RESULT_OK){
            selectedPartBBarcode = data?.getStringExtra("barcode")
            viewModel?.receiveEngineerParts(selectedPart?.partId, selectedPartBBarcode)


        }
    }

    override fun onClick(v: View?) {

    }





    fun showReceiveSuccessDialog() {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_rider, null)


        val builder = AlertDialog.Builder(this)

            .setView(dialogView)
            .setCancelable(false)


        val left = dialogView.findViewById(R.id.btn_left) as TextView
        val right = dialogView.findViewById(R.id.btn_right) as TextView
        val txt = dialogView.findViewById(R.id.tv) as TextView

        left.visibility = View.GONE


        right.text = resources.getString(R.string.ok)
//        left.text = resources.getString(R.string.cancel)

        txt.text = String.format(resources.getString(R.string.part_successfully_received) , selectedPartBBarcode)

        val alertDialog = builder.create()
        left.setOnClickListener {
            alertDialog.dismiss()
        }
        right.setOnClickListener {
            viewModel?.pickUpEngineerParts(intent.getIntExtra("id", 0))

            alertDialog.dismiss()


        }

        alertDialog.show()


    }


}