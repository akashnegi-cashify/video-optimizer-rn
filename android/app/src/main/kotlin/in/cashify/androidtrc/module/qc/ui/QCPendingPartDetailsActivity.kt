package `in`.cashify.androidtrc.module.qc.ui

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityQCPendingPartDetailsBinding
import `in`.cashify.androidtrc.module.qc.QCPendingPartDetailActivityViewModel
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import android.os.Bundle
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider

class QCPendingPartDetailsActivity : BaseActivity() {
    var binding: ActivityQCPendingPartDetailsBinding? = null
    var viewModel: QCPendingPartDetailActivityViewModel? = null
    var data: QCPendingListResponse.Data? = null


    override fun getLayoutResId(): Int {
        return R.layout.activity_q_c_pending_part_details
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        setTitle(getString(R.string.app_name))


        viewModel =
            ViewModelProvider(this, factory).get(QCPendingPartDetailActivityViewModel::class.java)
        data = intent?.getParcelableExtra("data")
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_QC_PENDING_PART_DETAILS, null, null, true)

        binding?.tvPartName?.text = data?.partName
        binding?.tvPartSku?.text = data?.sku
        binding?.tvPartColor?.text = data?.partColor
        binding?.tvPartBarcode?.text = data?.partBarcode


        if (data?.isDamaged ?: false) {
            binding?.spareOk?.visibility = View.GONE
        }



        binding?.faultySpare?.setOnClickListener {
            showConfirmDialog(
                String.format(
                    resources.getString(R.string.click_on_confirm_faulty),
                    data?.partBarcode
                ), true
            )


        }


        binding?.spareOk?.setOnClickListener {
            showConfirmDialog(
                String.format(
                    resources.getString(R.string.click_on_confirm_ok),
                    data?.partBarcode
                ), false
            )

        }



        viewModel?.qcSubmitResponse?.observe(this, Observer {
            showSubmittedSuccessDialog()
        })
    }


    fun showConfirmDialog(text: String, isFaulty: Boolean) {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_confirm_dialog, null)


        val builder = AlertDialog.Builder(this)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.btn_left) as TextView
        val confirm = dialogView.findViewById(R.id.btn_right) as TextView
        val txt = dialogView.findViewById(R.id.tv) as TextView
        txt.text = text



        val alertDialog = builder.create()

        confirm.setOnClickListener {

            if (isFaulty) {
                viewModel?.submitPartData(data?.prid ?: 0, true)
            } else {
                viewModel?.submitPartData(data?.prid ?: 0, false)
            }



            alertDialog.dismiss()


        }

        cancel.setOnClickListener {
            alertDialog.dismiss()


        }

        alertDialog.show()


    }


    fun showSubmittedSuccessDialog() {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_successfully_updated, null)


        val builder = AlertDialog.Builder(this)

            .setView(dialogView)
            .setCancelable(false)


        val yes = dialogView.findViewById(R.id.btn_yes) as TextView
        val txt = dialogView.findViewById(R.id.tv) as TextView
        yes.text = resources.getString(R.string.ok)
        txt.text = String.format(
            resources.getString(R.string.barcode_successfully_submitted),
            data?.partBarcode

        )


        val alertDialog = builder.create()

        yes.setOnClickListener {


            finish()


        }



        alertDialog.show()


    }


}