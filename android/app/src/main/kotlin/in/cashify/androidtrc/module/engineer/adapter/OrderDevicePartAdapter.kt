package `in`.cashify.androidtrc.module.engineer.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerDeviceInfo
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import android.widget.Toast
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class OrderDevicePartAdapter : RecyclerView.Adapter<OrderDevicePartAdapter.OrderDevicePartHolder>(),
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

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): OrderDevicePartHolder {
        return OrderDevicePartHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_order_part,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return deviceInfoList.size
    }

    override fun onBindViewHolder(holder: OrderDevicePartHolder, position: Int) {
        val allocatedToEng = deviceInfoList[position]
        holder.onBind(allocatedToEng)

    }

    inner class OrderDevicePartHolder(itemView: View) : RecyclerView.ViewHolder(itemView),
        View.OnClickListener {
        override fun onClick(v: View?) {
            when (v?.id) {
                R.id.btn_plus -> {

                    val orderQuantity: Int = deviceInfo!!.orderQuantity
                    if (deviceInfo?.quantity != null && orderQuantity + 1 > deviceInfo?.quantity!!) {
                        Toast.makeText(
                            itemView.context,
                            "Can not order more than " + orderQuantity,
                            Toast.LENGTH_SHORT
                        )
                            .show()
                    } else {
                        deviceInfo?.orderQuantity = orderQuantity + 1
                    }
                    notifyDataSetChanged()
                }
                R.id.btn_minus -> {
                    val orderQuantity: Int = deviceInfo!!.orderQuantity
                    if (orderQuantity - 1 < 0) {
                        Toast.makeText(itemView.context, "Already zero", Toast.LENGTH_SHORT)
                            .show()
                    } else {
                        deviceInfo?.orderQuantity = orderQuantity - 1
                    }
                    notifyDataSetChanged()
                }
            }
        }

        fun onBind(deviceInfo: DevicePartInfo) {
            this.deviceInfo = deviceInfo
            tvLine1.text = "Part Name- ${deviceInfo.partName}"
            tvLine2.text = "SKU- ${deviceInfo.partSku}"
            tvLine3.text = "Color- ${deviceInfo.partColor}"

            tvCount.text = "${deviceInfo.orderQuantity}"
        }

        private var deviceInfo: DevicePartInfo? = null
        var tvLine1 = itemView.findViewById(R.id.tv_line_1) as TextView
        var tvLine2 = itemView.findViewById(R.id.tv_line_2) as TextView
        var tvLine3 = itemView.findViewById(R.id.tv_line_3) as TextView

        var tvCount = itemView.findViewById(R.id.tv_count) as TextView


        init {
            itemView.findViewById<Button>(R.id.btn_plus).setOnClickListener(this)
            itemView.findViewById<Button>(R.id.btn_minus).setOnClickListener(this)
        }

    }

    interface OnItemClick {
        fun onItemClick(deviceInfo: EngineerDeviceInfo?)
    }
}