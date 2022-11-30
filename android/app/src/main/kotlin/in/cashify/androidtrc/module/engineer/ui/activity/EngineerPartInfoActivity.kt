package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.ActivityEngineerPartInfoBinding
import `in`.cashify.androidtrc.databinding.ActivityWipOptionBinding
import `in`.cashify.androidtrc.module.engineer.api.response.CancelPartResponse
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.ReceivedPartResponse
import `in`.cashify.androidtrc.module.engineer.data.EngineerPartInfoActivityViewmodel
import `in`.cashify.androidtrc.module.engineer.data.WipOptionActivityModel
import `in`.cashify.androidtrc.module.engineer.data.WipPartInfoctivityModel
import `in`.cashify.androidtrc.util.CommonConstant
import android.content.DialogInterface
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.view.View
import android.widget.Button
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders

class EngineerPartInfoActivity : BaseActivity() , View.OnClickListener{

    private val SCAN_REQ_CODE: Int = 103
    var partInfo: EngineerPartInfo? = null




    private lateinit var viewModel: EngineerPartInfoActivityViewmodel
    private lateinit var binding: ActivityEngineerPartInfoBinding
    override fun getLayoutResId(): Int {
        return R.layout.activity_engineer_part_info
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(EngineerPartInfoActivityViewmodel::class.java)
        getSupportActionBar()?.setDisplayHomeAsUpEnabled(true);
viewModel?.activityListener = this



        partInfo = intent.getParcelableExtra(CommonConstant.KEY_PART_INFO)


        if(partInfo?.statusCode == CommonConstant.ALLOTED_STATUS_CODE ||partInfo?.statusCode == CommonConstant.RIDER_DELIVERY_PICKED_STATUS_CODE ){
            binding?.btnReceive?.visibility = View.VISIBLE
        }
        if( partInfo?.statusCode == CommonConstant.REQUESTED_STATUS_CODE ||partInfo?.statusCode == CommonConstant.AVAILABLE_STATUS_CODE || partInfo?.statusCode == CommonConstant.NOT_AVAILABLE_STATUS_CODE){
            binding?.btnCancel?.visibility = View.VISIBLE
        }

        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ENG_DEVICE_PART_INFO, null, null, true)

        binding.btnReceive.setOnClickListener(this)
        binding.btnCancel.setOnClickListener(this)


        binding.tvDeviceBarcode.setText(intent.getStringExtra("barcode"))
        binding.tvDeviceStatus.setText(intent.getStringExtra("status"))
        binding.tvDeviceProductTitle.setText(intent.getStringExtra("title"))






        binding.tvPartName.text = partInfo?.partName
        binding.tvPartBarcode.text = partInfo?.partBarcode
        binding.tvPartSku.text = partInfo?.partSku
        binding.tvPartStatus.text = partInfo?.status

        getSupportActionBar()?.setDisplayHomeAsUpEnabled(true);

    }

    override fun onClick(v: View?) {

        when(v?.id) {
            R.id.btn_receive -> {


                getConfirmationPopUp()
            }

            R.id.btn_cancel -> {
                getCancelConfirmationPopUp()


            }


        }
    }private fun getConfirmationPopUp() {//show confirmation pop up and make a request to server
        if (partInfo?.isBulk?:false) {
          showDialog(
                "",
                resources.getString(R.string.are_u_sure),
                resources.getString(R.string.yes),
                object : DialogInterface.OnClickListener {
                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        viewModel.getReceivePartByEngineer(
                            object : OnResult<ReceivedPartResponse> {
                                override fun onResultAvailable(data: ReceivedPartResponse) {
                                    if (data.success) {

                                        receiveSuccessDialog()












                                    } else {
                                        viewModel.activityListener?.showError(data.errorMsg)
                                    }
                                }
                            }, partInfo?.partId?:"", "", partInfo?.prid.toString()
                        )
                    }
                },
                "No",
                object : DialogInterface.OnClickListener {
                    override fun onClick(dialog: DialogInterface?, which: Int) {
                        dialog?.dismiss()
                    }
                })
        }
//            //show barcode scanner and make a request to server
        else {

            val intent = Intent(
                this,
                ScanAllowedPartsActivity::class.java
            ).apply {

                putExtra("prid", partInfo?.prid.toString())
            }
            startActivityForResult(
                intent, SCAN_REQ_CODE
            )

        }

    }






    private fun receiveSuccessDialog(){
       showDialog(
            "",
            String.format(resources.getString(R.string.part_successfully_received) , partInfo?.partName),
            resources.getString(R.string.yes),
            object : DialogInterface.OnClickListener {
                override fun onClick(dialog: DialogInterface?, which: Int) {
                    dialog?.dismiss()
                    finish()
                }
            },
            "",
            object : DialogInterface.OnClickListener {
                override fun onClick(dialog: DialogInterface?, which: Int) {
                    dialog?.dismiss()
                    finish()
                }
            })



    }




    private fun getCancelConfirmationPopUp() {
        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel, null)


        val builder = AlertDialog.Builder(this)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.cancel) as ImageView
        val message = dialogView.findViewById(R.id.tv_message) as TextView
        val confirm = dialogView.findViewById(R.id.confirm) as Button
        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        confirm.setOnClickListener {
            alertDialog.dismiss()
            alertDialog.dismiss()

            viewModel?.cancelPart(
                object : OnResult<CancelPartResponse> {
                    override fun onResultAvailable(data: CancelPartResponse) {
                        if (data.success)
                        {


                            cancelSuccessDialog()
                        }
                        else
                        {
                            viewModel?.activityListener!!.showError(data.errorMsg)
                        }


                    }
                }, partInfo?.prid.toString()
            )



        }

        message.text = resources.getString(R.string.click_on_confirm_to_cancel)
        confirm.text = resources.getString(R.string.confirm)

        alertDialog.show()

    }
    fun cancelSuccessDialog() {
        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel, null)


        val builder = AlertDialog.Builder(this)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.cancel) as ImageView
        val message = dialogView.findViewById(R.id.tv_message) as TextView
        val confirm = dialogView.findViewById(R.id.confirm) as Button
        val tv1 = dialogView.findViewById(R.id.tv1) as TextView
        val tv2 = dialogView.findViewById(R.id.tv2) as TextView
        tv1.visibility = View.VISIBLE
        tv2.visibility = View.VISIBLE

        message.text = "Part request for part name"
        tv1.text = partInfo?.partName.toString()
        tv2.text = "is successfully cancelled"

        cancel.visibility = View.INVISIBLE
        val alertDialog = builder.create()
        cancel.setOnClickListener {
            finish()
        }
        confirm.setOnClickListener {
            alertDialog.dismiss()
            finish()
        }


        confirm.text = resources.getString(R.string.ok)

        alertDialog.show()
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
       if(requestCode == SCAN_REQ_CODE  && resultCode == RESULT_OK){
           finish()
       }

        super.onActivityResult(requestCode, resultCode, data)
    }


}

