package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.DateUtils
import `in`.cashify.androidtrc.module.inventory_manager.api.response.PendingDeviceListResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView

class PendingDeviceAdapter(val listener: OnDeviceClickListener?) :
    RecyclerView.Adapter<PendingDeviceAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<PendingDeviceListResponse.DataList>?> {


    var list: List<PendingDeviceListResponse.DataList>? = null

    var startingCount = 1

    inner class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        var deviceBarcode: TextView? = null


        var engineerName: TextView? = null
        var repaireType: TextView? = null
        var grade: TextView? = null
        var location: TextView? = null
        var partStatus: TextView? = null
        var assignedAt: TextView? = null
        var card: CardView? = null
        var tvCount: TextView? = null

        init {
            engineerName = itemView.findViewById(R.id.tv_engineer_name)
            assignedAt = itemView.findViewById(R.id.tv_assignes_at)
            tvCount = itemView.findViewById(R.id.tv_count)
            repaireType = itemView.findViewById(R.id.tv_repair_type)
            grade = itemView.findViewById(R.id.tv_grade)
            card = itemView.findViewById(R.id.card)


            deviceBarcode = itemView.findViewById(R.id.tv_barcode)
            location = itemView.findViewById(R.id.tv_location)
            partStatus = itemView.findViewById(R.id.tv_part_status)


            itemView.setOnClickListener {

                listener?.deviceClick(list?.get(adapterPosition)?.did.toString())
            }

        }


    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_pending_device,
                parent,
                false
            )
        )


    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.tvCount?.text = (startingCount + position).toString()
        holder.assignedAt?.text =
            DateUtils.getDate(list?.get(position)?.assignedAt ?: 0, DateUtils.dateTimeFormat)
        holder.engineerName?.text = list?.get(position)?.engineerName
        holder.deviceBarcode?.text = list?.get(position)?.deviceBarcode

        holder.repaireType?.text = list?.get(position)?.repairType
        holder.grade?.text = list?.get(position)?.grade
        holder.location?.text = list?.get(position)?.lc
        holder.partStatus?.text =
            list?.get(position)?.partCount.toString() + " out of " + list?.get(position)?.totalPartCount.toString() + " Not available"

        if(list?.get(position)?.isUrgent?:false){
            holder.card?.setBackgroundColor(holder.card?.resources!!.getColor(R.color.red ))
        }
        else{
            holder.card?.setBackgroundColor(holder.card?.resources!!.getColor(R.color.white ))
        }
    }

    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<PendingDeviceListResponse.DataList>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


    interface OnDeviceClickListener {
        fun deviceClick(code: String)
    }
}