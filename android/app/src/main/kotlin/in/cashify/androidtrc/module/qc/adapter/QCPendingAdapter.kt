package `in`.cashify.androidtrc.module.qc.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.qc.QCActivityViewModel
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class QCPendingAdapter (var pendingPartClickListener:PendingPartClickListener?) : RecyclerView.Adapter<QCPendingAdapter.ViewHolder>() ,
    BaseViewModel.BindableAdapter<ArrayList<QCPendingListResponse.Data>> {
    var list:ArrayList<QCPendingListResponse.Data>?=null
    inner   class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var tv_barcode = itemView.findViewById<TextView>(R.id.tv_part_barcode)
        var tv_sku = itemView.findViewById<TextView>(R.id.tv_part_sku)

        var tv_name = itemView.findViewById<TextView>(R.id.tv_part_name)
        var tv_color = itemView.findViewById<TextView>(R.id.tv_part_color)
        init {
            itemView.setOnClickListener {
                pendingPartClickListener?.pendingPartClick(adapterPosition)
            }
        }


    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        return ViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_qc_pending_part,
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.tv_barcode.text = list?.get(position)?.partBarcode
        holder.tv_sku.text = list?.get(position)?.sku
        holder.tv_name.text = list?.get(position)?.partName
        holder.tv_color.text = list?.get(position)?.partColor
    }

    override fun getItemCount(): Int {
        return list?.size?:0
    }

    override fun setData(data: ArrayList<QCPendingListResponse.Data>) {
        list = data
        notifyDataSetChanged()
    }


    interface PendingPartClickListener{
        fun pendingPartClick(pos:Int)
    }

}