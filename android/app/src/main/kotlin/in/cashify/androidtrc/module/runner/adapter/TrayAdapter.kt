package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.runner.api.response.engineer_tray.TrayInfoAllocatedToEng
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class TrayAdapter : RecyclerView.Adapter<TrayAdapter.TrayHolder>(),
    BaseViewModel.BindableAdapter<List<TrayInfoAllocatedToEng>> {

    var trayInfoList = emptyList<TrayInfoAllocatedToEng>()
    var onItemClick: OnItemClick? = null
    override fun setData(data: List<TrayInfoAllocatedToEng>) {
        trayInfoList = data
        notifyDataSetChanged()
    }

    fun changeDataSet(trayList: ArrayList<TrayInfoAllocatedToEng>?) {
        if (trayList == null) {
            return
        }
        this.trayInfoList = trayList
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): TrayHolder {
        return TrayHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_allocated_device,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return trayInfoList.size
    }

    override fun onBindViewHolder(holder: TrayHolder, position: Int) {
        val allocatedToEng = trayInfoList[position]
        holder.onBind(allocatedToEng, onItemClick)

    }

    class TrayHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {
        var onItemClick: OnItemClick? = null
        var trayInfo: TrayInfoAllocatedToEng? = null
        override fun onClick(v: View?) {
            onItemClick?.onItemClick(trayInfo)
        }

        fun onBind(tray: TrayInfoAllocatedToEng, onItemClick: OnItemClick?) {
            this.trayInfo = tray
            this.onItemClick = onItemClick
            if (!TextUtils.isEmpty(tray.trayBarcode)) {
                tvLine1.text = "Tray Barcode- ${tray.trayBarcode}"
            }
            tvLine2.text = "Number of devices- ${tray.deviceCount}"
        }

        var tvLine1 = itemView.findViewById(R.id.tv_line_1) as TextView
        var tvLine2 = itemView.findViewById(R.id.tv_line_2) as TextView
        var tvLine3 = itemView.findViewById(R.id.tv_line_3) as TextView

        init {
            itemView.setOnClickListener(this)
        }

    }

    interface OnItemClick {
        fun onItemClick(trayInfo: TrayInfoAllocatedToEng?)
    }
}