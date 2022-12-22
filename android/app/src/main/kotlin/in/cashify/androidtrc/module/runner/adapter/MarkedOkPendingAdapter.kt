package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.MarkedOkPendingDeviceInfo
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class MarkedOkPendingAdapter : RecyclerView.Adapter<MarkedOkPendingAdapter.MarkedOkPendingHolder>(),
    BaseViewModel.BindableAdapter<List<MarkedOkPendingDeviceInfo>> {

    var markedOkPendingInfoList = emptyList<MarkedOkPendingDeviceInfo>()
    var onItemClick: OnItemClick? = null
    override fun setData(data: List<MarkedOkPendingDeviceInfo>) {
        markedOkPendingInfoList = data
        notifyDataSetChanged()
    }

    fun changeDataSet(trayList: ArrayList<MarkedOkPendingDeviceInfo>?) {
        if (trayList == null) {
            return
        }
        this.markedOkPendingInfoList = trayList
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MarkedOkPendingHolder {
        return MarkedOkPendingHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_allocated_device,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return markedOkPendingInfoList.size
    }

    override fun onBindViewHolder(holder: MarkedOkPendingHolder, position: Int) {
        val allocatedToEng = markedOkPendingInfoList[position]
        holder.onBind(allocatedToEng, onItemClick)

    }

    class MarkedOkPendingHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {
        var onItemClick: OnItemClick? = null
        var pendingDeviceInfo: MarkedOkPendingDeviceInfo? = null
        override fun onClick(v: View?) {
            onItemClick?.onItemClick(pendingDeviceInfo)
        }

        fun onBind(info: MarkedOkPendingDeviceInfo, onItemClick: OnItemClick?) {
            this.pendingDeviceInfo = info
            this.onItemClick = onItemClick
            if (!TextUtils.isEmpty(info.engineerName)) {
                tvLine1.text = "Engineer Name- ${info.engineerName}"
            }
            tvLine2.text = "Number of devices- ${info.deviceCount}"
            tvLine3.visibility = View.VISIBLE
            tvLine3.text = "Type- ${info.engineerType}"
        }

        var tvLine1 = itemView.findViewById(R.id.tv_line_1) as TextView
        var tvLine2 = itemView.findViewById(R.id.tv_line_2) as TextView
        var tvLine3 = itemView.findViewById(R.id.tv_line_3) as TextView

        init {
            itemView.setOnClickListener(this)
        }

    }

    interface OnItemClick {
        fun onItemClick(trayInfo: MarkedOkPendingDeviceInfo?)
    }
}