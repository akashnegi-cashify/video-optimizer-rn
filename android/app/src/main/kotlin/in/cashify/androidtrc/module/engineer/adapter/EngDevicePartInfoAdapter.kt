package `in`.cashify.androidtrc.module.engineer.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.ReceivedPartResponse
import `in`.cashify.androidtrc.module.engineer.data.EngDevicePartAssignedListViewModel
import `in`.cashify.androidtrc.module.engineer.data.EngPartsViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import `in`.cashify.androidtrc.util.CommonConstant
import android.content.DialogInterface
import android.content.res.Resources
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.lifecycle.ViewModel
import androidx.recyclerview.widget.RecyclerView

class EngDevicePartInfoAdapter(
    viewModel: ViewModel,
    val isRequestCancelatn: Boolean, val listener:OnItemClickListener
) : RecyclerView.Adapter<EngDevicePartInfoAdapter.PartInfoHolder>(),
    BaseViewModel.BindableAdapter<List<EngineerPartInfo>?> {

    var viewModel = viewModel as EngDevicePartAssignedListViewModel

    var partInfoList = emptyList<EngineerPartInfo>()
    override fun setData(data: List<EngineerPartInfo>?) {
        changeDataSet(data)
    }

    fun changeDataSet(partInfo: List<EngineerPartInfo>?) {
        if (partInfo == null) {
            return
        }
        this.partInfoList = partInfo
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): PartInfoHolder {
        return PartInfoHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_eng_part_info,
                parent,
                false
            ), this, viewModel
        )
    }

    override fun getItemCount(): Int {
        return partInfoList.size
    }

    override fun onBindViewHolder(holder: PartInfoHolder, position: Int) {
//        if (isRequestCancelatn) {
//            holder.cancel.visibility = View.VISIBLE
//        } else {
//            holder.cancel.visibility = View.INVISIBLE
//        }
        val allocatedToEng = partInfoList[position]
        holder.onBind(allocatedToEng)

    }

    inner class PartInfoHolder(
        itemView: View,
        outerInstance: EngDevicePartInfoAdapter,
        viewModel: ViewModel
    ) : RecyclerView.ViewHolder(itemView) {


        init {

            itemView.setOnClickListener {
                listener.itemClick(partInfoList.get(adapterPosition))
            }
        }

        fun onBind(partInfo: EngineerPartInfo) {

            tvName.text = partInfo.partName
            tvBarcode.text = partInfo.partBarcode
           tvSku.text = partInfo.partSku
           tvStatus.text = partInfo.status


            if(partInfo.getPartStatus()==(PartStatus.OTHER)){
                tvStatus.setTextColor(tvStatus.resources.getColor(R.color.black))
            }
            else  if(partInfo.getPartStatus()==(PartStatus.AVAILABBLE)
            ){
                tvStatus.setTextColor(tvStatus.resources.getColor(R.color.teal))
            }

            else  if(partInfo.getPartStatus()==(PartStatus.NOT_AVAILABLE)
            ){
                tvStatus.setTextColor(tvStatus.resources.getColor(R.color.red))
            }


//            if (partInfo.status.equals(CommonConstant.ENGINEER_STATUS_ALLOTED)||partInfo.status.equals(CommonConstant.ENGINEER_STATUS_DELIVERY_PICKED)) {
//                receiveBtn.visibility = View.VISIBLE
//            } else {
//                receiveBtn.visibility = View.GONE
//
//            }
        }

        var tvName = itemView.findViewById(R.id.tv_part_name) as TextView
        var tvBarcode = itemView.findViewById(R.id.tv_part_barcode) as TextView
        var tvSku = itemView.findViewById(R.id.tv_part_sku) as TextView
        var tvStatus = itemView.findViewById(R.id.tv_part_status) as TextView
//        var tvLine4 = itemView.findViewById(R.id.tv_line_4) as TextView
//        var receiveBtn = itemView.findViewById(R.id.receive_button) as Button
//        var cancel = itemView.findViewById(R.id.cancel) as ImageView


        var engPartInfoAdapterInstance = outerInstance
        var viewModel = viewModel as EngDevicePartAssignedListViewModel

        init {

//            receiveBtn.setOnClickListener(object : View.OnClickListener {
//                override fun onClick(view: View?) {
//                    handleReceiveButton(adapterPosition , itemView.resources)
//                }
//            })
//
//
//
//            cancel.setOnClickListener {
//                handleCancelButton(adapterPosition)
//            }
        }

//        private fun handleReceiveButton(adapterPosition: Int , resources: Resources) {
//            //get object from list
//            val engPartInfo = engPartInfoAdapterInstance.partInfoList[adapterPosition]
//
//            //show pop up to the user
//            getConfirmationPopUp(engPartInfo , resources)
//        }


//        private fun handleCancelButton(adapterPosition: Int) {
//            //get object from list
//            var engPartInfo = engPartInfoAdapterInstance.partInfoList[adapterPosition]
//
//            getCancelConfirmationPopUp(engPartInfo)
//        }


//        private fun getCancelConfirmationPopUp(engPartInfo: EngineerPartInfo) {
//
//            listener.cancel(engPartInfo)
//        }


        /**
         *
         */
//        private fun getConfirmationPopUp(engPartInfo: EngineerPartInfo , resources: Resources) {//show confirmation pop up and make a request to server
//            if (engPartInfo.isBulk?:false) {
//                viewModel.activityListener?.showDialog(
//                    "",
//                    resources.getString(R.string.are_u_sure),
//                    resources.getString(R.string.yes),
//                    object : DialogInterface.OnClickListener {
//                        override fun onClick(dialog: DialogInterface?, which: Int) {
//                            viewModel.getReceivePartByEngineer(
//                                object : OnResult<ReceivedPartResponse> {
//                                    override fun onResultAvailable(data: ReceivedPartResponse) {
//                                        if (data.success) {
//                                            viewModel.getEngPartInfoList(viewModel?.did?:"")
//                                        } else {
//                                            viewModel.activityListener?.showError(data.errorMsg)
//                                        }
//                                    }
//                                }, engPartInfo.partId?:"", "", engPartInfo.prid.toString()
//                            )
//                        }
//                    },
//                    "No",
//                    object : DialogInterface.OnClickListener {
//                        override fun onClick(dialog: DialogInterface?, which: Int) {
//                            dialog?.dismiss()
//                        }
//                    })
//            }
////            //show barcode scanner and make a request to server
//            else {
//
//                viewModel.engPartListListener?.inflateScanner(engPartInfo.prid)
//
//            }
//
//        }
    }


    interface OnItemClickListener {
        fun itemClick(info: EngineerPartInfo)
    }
}