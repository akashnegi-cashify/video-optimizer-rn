package `in`.cashify.androidtrc.module.inventory_manager.fragment.return_parts

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityIMPartReturnDetailBinding

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders

class IMPartReturnDetailActivity : BaseActivity() {
    private lateinit var binding: ActivityIMPartReturnDetailBinding
    private lateinit var viewModel: IMPartReturnDetailViewModel

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding = DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(IMPartReturnDetailViewModel::class.java)
        viewModel.activityListener = this
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_IM_PART_RETURN, null, null, true)
        binding.tvPartName.setText(intent.getStringExtra("name"))
        binding.tvPartSku.setText(intent.getStringExtra("sku"))
        binding.tvPartBarcode.setText(intent.getStringExtra("barcode"))
        binding.tvPartColor.setText(intent.getStringExtra("color"))
        binding.faultySpare.setOnClickListener {
            showConfirmDialog(
                String.format(
                    resources.getString(R.string.click_on_confirm_faulty),
                    intent?.getStringExtra("barcode")
                )
            ) {
                viewModel.returnPart(intent?.getIntExtra("prid", 0).toString() , true)
            }
        }


        binding.send.setOnClickListener {
            showConfirmDialog(
                String.format(
                    resources.getString(R.string.click_on_confirm_to_send),
                    intent?.getStringExtra("barcode")
                )
            ) {
                viewModel.returnPart(intent?.getIntExtra("prid" , 0).toString() , true)
            }
        }


        viewModel?.updateReturnPartResponse?.observe(this, Observer {
            showSubmittedSuccessDialog()
        })
    }


    override fun getLayoutResId(): Int {
    return R.layout.activity_i_m_part_return_detail
    }


    fun showConfirmDialog(text: String , returnPart:()->Unit) {


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
returnPart()
//            if (isFaulty) {
//                viewModel?.submitPartData(data?.prid ?: 0, true)
//            } else {
//                viewModel?.submitPartData(data?.prid ?: 0, false)
//            }



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
       intent?.getStringExtra("barcode")

        )


        val alertDialog = builder.create()

        yes.setOnClickListener {


            finish()


        }



        alertDialog.show()


    }
}