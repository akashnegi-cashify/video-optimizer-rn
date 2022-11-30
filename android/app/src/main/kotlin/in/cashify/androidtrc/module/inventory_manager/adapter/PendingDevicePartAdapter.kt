package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.DateUtils
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import `in`.cashify.androidtrc.module.inventory_manager.api.response.PendingPartListResponse
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class PendingDevicePartAdapter (val listener: OnPartClickListener?) : RecyclerView.Adapter<PendingDevicePartAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<PendingPartListResponse.Data>?> {


    var list: List<PendingPartListResponse.Data>? = null

    inner  class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        var status: TextView? = null


        var folder: TextView? = null

        var name: TextView? = null
        var requestedAt: TextView? = null

        init {
            status = itemView.findViewById(R.id.tv_status)


            folder = itemView.findViewById(R.id.tv_folder)
            name = itemView.findViewById(R.id.name)
            requestedAt = itemView.findViewById(R.id.tv_requested_at)


            itemView?.setOnClickListener {

                listener?.partClick(list?.get(adapterPosition)?.prid?:0, list?.get(adapterPosition)?.getPartStatus()!!)
            }

        }



    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_pending_part_details,
                parent,
                false
            )
        )


    }


    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<PendingPartListResponse.Data>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


    interface OnPartClickListener{
        fun partClick(prid:Int , partStatus:PartStatus)
    }

    override fun onBindViewHolder(holder: PendingDevicePartAdapter.MyViewHolder, position: Int) {
        holder.requestedAt?.text =
            DateUtils.getDate(list?.get(position)?.requestedTime ?: 0, DateUtils.dateTimeFormat)
        if(list?.get(position)?.getPartStatus()==(PartStatus.OTHER)){
            holder.status?.setTextColor(holder.itemView.resources.getColor(R.color.black))
        }
      else  if(list?.get(position)?.getPartStatus()==(PartStatus.AVAILABBLE)
            ){
            holder.status?.setTextColor(holder.itemView.resources.getColor(R.color.teal))
        }

        else{
            holder.status?.setTextColor(Color.RED)
        }
     holder.status?.text = list?.get(position)?.st
        holder.folder?.text = list?.get(position)?.sku.toString()
        holder.name?.text = list?.get(position)?.pn.toString()
    }
}