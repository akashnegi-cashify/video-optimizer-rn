package `in`.cashify.androidtrc.module.elss.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerDeviceInfo
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CheckBox
import android.widget.CompoundButton
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.recyclerview.widget.RecyclerView

/**
 * Created by Avaneesh Maurya on 30,December,2019
 */
class ElssDevicePartAdapter : RecyclerView.Adapter<ElssDevicePartAdapter.ElssDevicePartHolder>(),
    BaseViewModel.BindableAdapter<List<DevicePartInfo>> {

    var deviceInfoList = emptyList<DevicePartInfo>()

    override fun setData(data: List<DevicePartInfo>) {
        deviceInfoList = data
        notifyDataSetChanged()
    }

    fun getPartForOrder(): ArrayList<DevicePartInfo> {
        val partList = ArrayList<DevicePartInfo>()
        for (part in deviceInfoList) {
            if (part.orderQuantity > 0) {
                part.quantity = part.orderQuantity
                partList.add(part)
            }
        }
        return partList
    }

    fun changeDataSet(deviceList: ArrayList<DevicePartInfo>?) {
        if (deviceList == null) {
            return
        }
        this.deviceInfoList = deviceList
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ElssDevicePartHolder {
        return ElssDevicePartHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_order_part_elss,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return deviceInfoList.size
    }

    override fun onBindViewHolder(holder: ElssDevicePartHolder, position: Int) {
        val allocatedToEng = deviceInfoList[position]
        holder.onBind(allocatedToEng)
    }

    inner class ElssDevicePartHolder(itemView: View) : RecyclerView.ViewHolder(itemView),
        CompoundButton.OnCheckedChangeListener, View.OnClickListener {

        fun onBind(deviceInfo: DevicePartInfo) {
            this.deviceInfo = deviceInfo
            tvLine1.text = "${deviceInfo.partName}"
            tvLine2.text = "SKU- ${deviceInfo.partSku}"
            tvLine3.text = "Color- ${deviceInfo.partColor}"

            checkBox.isChecked = true && deviceInfo.orderQuantity > 0
        }

        private var deviceInfo: DevicePartInfo? = null
        var tvLine1 = itemView.findViewById(R.id.tv_line_1) as TextView
        var tvLine2 = itemView.findViewById(R.id.tv_line_2) as TextView
        var tvLine3 = itemView.findViewById(R.id.tv_line_3) as TextView
        var checkBox = itemView.findViewById<CheckBox>(R.id.cb_order_part)

        init {

            checkBox.setOnCheckedChangeListener(this)
            itemView.findViewById<ConstraintLayout>(R.id.cl_container).setOnClickListener(this)
        }

        override fun onCheckedChanged(buttonView: CompoundButton?, isChecked: Boolean) {
            if (isChecked) {
                deviceInfo?.orderQuantity = 1
            } else {
                deviceInfo?.orderQuantity = 0
            }
//            notifyDataSetChanged()
        }

        override fun onClick(v: View?) {
            checkBox.isChecked = !checkBox.isChecked
        }
    }

    interface OnItemClick {
        fun onItemClick(deviceInfo: EngineerDeviceInfo?)
    }
}