package `in`.cashify.androidtrc.module.engineer.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerDeviceInfo
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class WipDeviceAdapter : RecyclerView.Adapter<WipDeviceAdapter.WipDeviceHolder>(),
    BaseViewModel.BindableAdapter<List<EngineerDeviceInfo>> {

    var deviceInfoList = emptyList<EngineerDeviceInfo>()
    var onItemClick: OnItemClick? = null
    override fun setData(data: List<EngineerDeviceInfo>) {
        deviceInfoList = data
        notifyDataSetChanged()
    }

    fun changeDataSet(deviceList: ArrayList<EngineerDeviceInfo>?) {
        if (deviceList == null) {
            return
        }
        this.deviceInfoList = deviceList
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): WipDeviceHolder {
        return WipDeviceHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_wip_device,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return deviceInfoList.size
    }

    override fun onBindViewHolder(holder: WipDeviceHolder, position: Int) {
        val allocatedToEng = deviceInfoList[position]
        holder.onBind(allocatedToEng, onItemClick)

    }

    class WipDeviceHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {
        var onItemClick: OnItemClick? = null
        var allocatedToEng: EngineerDeviceInfo? = null
        override fun onClick(v: View?) {
            onItemClick?.onItemClick(allocatedToEng)
        }

        fun onBind(deviceInfo: EngineerDeviceInfo, onItemClick: OnItemClick?) {
            this.allocatedToEng = deviceInfo
            this.onItemClick = onItemClick
            if (!TextUtils.isEmpty(deviceInfo.deviceBarcode)) {
                tvLine1.text = "Device Barcode- ${deviceInfo.deviceBarcode}"
            }
            tvLine2.text = "Product Title- ${deviceInfo.productTitle}"
            tvLine3.text = "Status- ${deviceInfo.status}"
        }

        var tvLine1 = itemView.findViewById(R.id.tv_line_1) as TextView
        var tvLine2 = itemView.findViewById(R.id.tv_line_2) as TextView
        var tvLine3 = itemView.findViewById(R.id.tv_line_3) as TextView

        init {
            itemView.setOnClickListener(this)
        }

    }

    interface OnItemClick {
        fun onItemClick(deviceInfo: EngineerDeviceInfo?)
    }
}