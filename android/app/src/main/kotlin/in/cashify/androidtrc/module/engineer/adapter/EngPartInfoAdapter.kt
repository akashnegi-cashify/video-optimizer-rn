package `in`.cashify.androidtrc.module.engineer.adapter

 import `in`.cashify.androidtrc.R
 import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
 import `in`.cashify.androidtrc.module.engineer.api.response.CancelPartResponse
 import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.ReceivedPartResponse
import `in`.cashify.androidtrc.module.engineer.data.EngPartsViewModel
import `in`.cashify.androidtrc.module.engineer.ui.activity.ReceivePartsActivity
import `in`.cashify.androidtrc.module.storageManager.api.response.VirtualStoreResponse
import `in`.cashify.androidtrc.util.CommonConstant
import android.content.DialogInterface
import android.content.Intent
 import android.opengl.Visibility
 import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
 import android.widget.ImageView
 import android.widget.TextView
import androidx.lifecycle.ViewModel
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class EngPartInfoAdapter(viewModel: ViewModel, val isRequestCancelatn:Boolean , val status:String , val listener:CancelLitener) : RecyclerView.Adapter<EngPartInfoAdapter.PartInfoHolder>(),
    BaseViewModel.BindableAdapter<List<EngineerPartInfo>> {

    var viewModel = viewModel as EngPartsViewModel

    var partInfoList = emptyList<EngineerPartInfo>()
    override fun setData(data: List<EngineerPartInfo>) {
        partInfoList = data
        notifyDataSetChanged()
    }

    fun changeDataSet(partInfo: ArrayList<EngineerPartInfo>?) {
        if (partInfo == null) {
            return
        }
        this.partInfoList = partInfo
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PartInfoHolder {
        return PartInfoHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_part_info,
                parent,
                false
            ),this ,viewModel
        )
    }

    override fun getItemCount(): Int {
        return partInfoList.size
    }

    override fun onBindViewHolder(holder: PartInfoHolder, position: Int) {
        if(isRequestCancelatn){
            holder.cancel.visibility = View.VISIBLE
        }

        else{
            holder.cancel.visibility = View.INVISIBLE
        }
        val allocatedToEng = partInfoList[position]
        holder.onBind(allocatedToEng)

    }

  inner  class PartInfoHolder(itemView: View ,outerInstance: EngPartInfoAdapter ,viewModel: ViewModel) : RecyclerView.ViewHolder(itemView)
    {

        fun onBind(partInfo: EngineerPartInfo)
        {

            tvLine1.text = "Part Name- ${partInfo.partName}"
            tvPartBarcode.text = "Part Barcode- ${partInfo.partBarcode}"
            tvLine2.text = "SKU- ${partInfo.partSku}"
            tvLine3.text = "Device Name- ${partInfo.deviceName}"
            tvLine4.text = "Device Barcode- ${partInfo.deviceBarcode}"

            if(partInfo.status.equals(CommonConstant.ENGINEER_STATUS_ALLOTED) ||partInfo.status.equals(CommonConstant.ENGINEER_STATUS_DELIVERY_PICKED))
            {
               receiveBtn.visibility = View.VISIBLE
            }
            else
            {
                receiveBtn.visibility = View.GONE

            }
        }

        var tvLine1 = itemView.findViewById(R.id.tv_line_1) as TextView
        var tvPartBarcode = itemView.findViewById(R.id.tv_part_barcode) as TextView
        var tvLine2 = itemView.findViewById(R.id.tv_line_2) as TextView
        var tvLine3 = itemView.findViewById(R.id.tv_line_3) as TextView
        var tvLine4 = itemView.findViewById(R.id.tv_line_4) as TextView
        var receiveBtn = itemView.findViewById(R.id.receive_button) as Button
        var cancel = itemView.findViewById(R.id.cancel) as ImageView



        var engPartInfoAdapterInstance = outerInstance
        var viewModel = viewModel as EngPartsViewModel

        init
        {

            receiveBtn.setOnClickListener(object : View.OnClickListener {
                override fun onClick(view: View?)
                {
                    handleReceiveButton(adapterPosition)
                } })



            cancel.setOnClickListener {
                handleCancelButton(adapterPosition)
            }
        }

        private fun handleReceiveButton(adapterPosition: Int)
        {
            //get object from list
           var engPartInfo = engPartInfoAdapterInstance.partInfoList[adapterPosition]

            //show pop up to the user
           getConfirmationPopUp(engPartInfo)
        }




        private fun handleCancelButton(adapterPosition: Int){
            //get object from list
            var engPartInfo = engPartInfoAdapterInstance.partInfoList[adapterPosition]

            getCancelConfirmationPopUp(engPartInfo)
        }


        private fun getCancelConfirmationPopUp(engPartInfo: EngineerPartInfo){

            listener.cancel(engPartInfo)
        }



        /**
         *
         */
        private fun getConfirmationPopUp(engPartInfo: EngineerPartInfo) =//show confirmation pop up and make a request to server
                if(engPartInfo.isBulk!!)
                {
                    viewModel.activityListener!!.showDialog(
                            "",
                            "Are you sure you want to receive",
                            "Yes",
                            object : DialogInterface.OnClickListener
                            {
                                override fun onClick(dialog: DialogInterface?, which: Int)
                                {
                                    viewModel.getReceivePartByEngineer(
                                            object : OnResult<ReceivedPartResponse>
                                            {
                                                override fun onResultAvailable(data: ReceivedPartResponse)
                                                {
                                                    if (data.success)
                                                    {
                                                        viewModel.getEngPartInfoList(CommonConstant.ENGINEER_ALLOWED_PARTS)
                                                    }
                                                    else
                                                    {
                                                        viewModel.activityListener!!.showError(data.errorMsg)
                                                    }
                                                }
                                            }, engPartInfo.partId!!, "", engPartInfo.prid.toString())
                                }
                            },
                            "No",
                            object : DialogInterface.OnClickListener {
                                override fun onClick(dialog: DialogInterface?, which: Int) {
                                    dialog!!.dismiss()
                                }
                            })
                }
                //show barcode scanner and make a request to server
                else
                {
                    viewModel.activityListener!!.showDialog(
                            "",
                            "Are you sure you want to Receive?",
                            "Yes",
                            object : DialogInterface.OnClickListener
                            {
                                override fun onClick(dialog: DialogInterface?, which: Int)
                                {
                                    viewModel.engPartListListener!!.inflateScanner(engPartInfo.prid)
                                }
                            },
                            "No",
                            object : DialogInterface.OnClickListener {
                                override fun onClick(dialog: DialogInterface?, which: Int) {
                                    dialog!!.dismiss()
                                }
                            })
                }

    }


    interface CancelLitener{
        fun cancel(info:EngineerPartInfo)
    }
}