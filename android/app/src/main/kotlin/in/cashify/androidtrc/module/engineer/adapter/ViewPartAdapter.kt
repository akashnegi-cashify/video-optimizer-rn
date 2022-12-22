package `in`.cashify.androidtrc.module.engineer.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import `in`.cashify.androidtrc.module.runner.adapter.RoleAdapter
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class ViewPartAdapter(val itemClick: OnItemClick?) :
    RecyclerView.Adapter<ViewPartAdapter.ViewPartHolder>(),
    BaseViewModel.BindableAdapter<List<EngineerPartInfo>> {

    var deviceInfoList = emptyList<EngineerPartInfo>()

    override fun setData(data: List<EngineerPartInfo>) {
        deviceInfoList = ArrayList(data)
        notifyDataSetChanged()
    }

    fun changeDataSet(deviceList: List<EngineerPartInfo>?) {
        if (deviceList == null) {
            return
        }

        this.deviceInfoList = deviceList
//        this.deviceInfoList.clear()
//        for (item in deviceList) {
//            if (item.status.equals(RoleAdapter.STATUS_RECEIVED)) {
//                this.deviceInfoList.add(item)
//            }
//        }

        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewPartHolder {
        return ViewPartHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_view_part,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return deviceInfoList.size
    }

    override fun onBindViewHolder(holder: ViewPartHolder, position: Int) {
        val allocatedToEng = deviceInfoList[position]
        holder.onBind(allocatedToEng)

    }

    inner class ViewPartHolder(val itemView: View) : RecyclerView.ViewHolder(itemView),
        View.OnClickListener {
        override fun onClick(v: View?) {
//            when (v?.id) {
//                R.id.btn_consume -> {
//                    itemClick?.onConsumeClick(deviceInfo)
//                }
//                R.id.btn_return -> {
//                    itemClick?.onReturnClick(deviceInfo)
//                }
//            }
        }
        var tvName = itemView.findViewById(R.id.tv_part_name) as TextView
        var tvBarcode = itemView.findViewById(R.id.tv_part_barcode) as TextView
        var tvSku = itemView.findViewById(R.id.tv_part_sku) as TextView
        var tvStatus = itemView.findViewById(R.id.tv_part_status) as TextView
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
        }

//        private var deviceInfo: DevicePartInfo? = null
//        var tvLine1 = itemView.findViewById(R.id.tv_line_1) as TextView
//        var tvLine2 = itemView.findViewById(R.id.tv_line_2) as TextView
//        var tvLine3 = itemView.findViewById(R.id.tv_line_3) as TextView

        init {

        itemView.setOnClickListener{
            itemClick?.onItemClick(deviceInfoList.get(adapterPosition))
        }

//            itemView.findViewById<Button>(R.id.btn_consume).setOnClickListener(this)
//            itemView.findViewById<Button>(R.id.btn_return).setOnClickListener(this)
        }

    }

    interface OnItemClick {
        fun onItemClick(deviceInfo: EngineerPartInfo?)
//        fun onReturnClick(deviceInfo: DevicePartInfo?)
    }
}