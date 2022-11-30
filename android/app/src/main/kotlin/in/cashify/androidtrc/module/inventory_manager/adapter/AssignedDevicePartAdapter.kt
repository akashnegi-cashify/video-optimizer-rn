package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.DateUtils
import `in`.cashify.androidtrc.module.inventory_manager.api.response.PendingPartListResponse
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class AssignedDevicePartAdapter(val listener: OnPartClickListener?) : RecyclerView.Adapter<AssignedDevicePartAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<PendingPartListResponse.Data>?> {


    var list: List<PendingPartListResponse.Data>? = null

    inner  class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        var status: TextView? = null

        var repqirType: TextView? = null
        var grade: TextView? = null


        var folder: TextView? = null

        var name: TextView? = null
        var requestedAt: TextView? = null


        init {
            status = itemView.findViewById(R.id.tv_status)
            requestedAt = itemView.findViewById(R.id.tv_requested_at)

            repqirType = itemView.findViewById(R.id.tv_repair_type)
            grade = itemView.findViewById(R.id.tv_grade)


            folder = itemView.findViewById(R.id.tv_folder)
            name = itemView.findViewById(R.id.name)


            itemView.setOnClickListener {

                listener?.partClick(list?.get(adapterPosition))
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
        fun partClick(data:PendingPartListResponse.Data?)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {

        holder.requestedAt?.text =
            DateUtils.getDate(list?.get(position)?.requestedTime ?: 0, DateUtils.dateTimeFormat)
            holder.status?.setTextColor(holder.status?.resources?.getColor(R.color.teal)?:Color.GREEN)

        holder.status?.text = list?.get(position)?.st
        holder.folder?.text = list?.get(position)?.sku.toString()
        holder.name?.text = list?.get(position)?.pn.toString()

        //holder.repqirType?.text = list?.get(position)?.requestedTime.toString()
       // holder.grade?.text = list?.get(position)?.pn.toString()
    }
}