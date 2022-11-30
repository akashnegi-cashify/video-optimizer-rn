package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.runner.api.response.device_list.DeviceInfoAllocatedToEng
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class AllocatedDeviceAdapter : RecyclerView.Adapter<AllocatedDeviceAdapter.AllocatedDeviceHolder>(),
    BaseViewModel.BindableAdapter<List<DeviceInfoAllocatedToEng>> {

    var deviceInfoList = emptyList<DeviceInfoAllocatedToEng>()
    var onItemClick: OnItemClick? = null
    override fun setData(data: List<DeviceInfoAllocatedToEng>) {
        deviceInfoList = data
        notifyDataSetChanged()
    }

    fun changeDataSet(deviceList: ArrayList<DeviceInfoAllocatedToEng>?) {
        if (deviceList == null) {
            return
        }
        this.deviceInfoList = deviceList
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): AllocatedDeviceHolder {
        return AllocatedDeviceHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_allocated_device,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return deviceInfoList.size
    }

    override fun onBindViewHolder(holder: AllocatedDeviceHolder, position: Int) {
        val allocatedToEng = deviceInfoList[position]
        holder.onBind(allocatedToEng, onItemClick)

    }

    class AllocatedDeviceHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {
        var onItemClick: OnItemClick? = null
        var allocatedToEng: DeviceInfoAllocatedToEng? = null
        override fun onClick(v: View?) {
            onItemClick?.onItemClick(allocatedToEng)
        }

        fun onBind(allocatedToEng: DeviceInfoAllocatedToEng, onItemClick: OnItemClick?) {
            this.allocatedToEng = allocatedToEng
            this.onItemClick = onItemClick
            if (!TextUtils.isEmpty(allocatedToEng.engineerName)) {
                tvLine1.text = "Engineer Name- ${allocatedToEng.engineerName}"
            }
            tvLine2.text = "Number of devices- ${allocatedToEng.deviceCount}"
        }

        var tvLine1 = itemView.findViewById(R.id.tv_line_1) as TextView
        var tvLine2 = itemView.findViewById(R.id.tv_line_2) as TextView
        var tvLine3 = itemView.findViewById(R.id.tv_line_3) as TextView

        init {
            itemView.setOnClickListener(this)
        }

    }

    interface OnItemClick {
        fun onItemClick(deviceInfo: DeviceInfoAllocatedToEng?)
    }
}