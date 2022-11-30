package `in`.cashify.androidtrc.module.rider.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.rider.data.response.RiderDeliverPendingReceivePartResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class PendingPartDeliverToEngineerAdapter(val listener:OnPartClickListener?) : RecyclerView.Adapter<PendingPartDeliverToEngineerAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<RiderDeliverPendingReceivePartResponse.Data>?> {


    var list: List<RiderDeliverPendingReceivePartResponse.Data>? = null

    inner  class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {



        var partName: TextView? = null
        var partSku: TextView? = null
        var partBarcode: TextView? = null



        var deviceBarcode: TextView? = null
        var deviceName: TextView? = null

        var tvNo:TextView? = null

        init {
            partName = itemView.findViewById(R.id.tv_part_name)


            partSku = itemView.findViewById(R.id.tv_part_sku)

            partBarcode = itemView.findViewById(R.id.tv_part_barcode)

            deviceBarcode = itemView.findViewById(R.id.device_barcode)


            deviceName =  itemView.findViewById(R.id.tv_device_name)
            tvNo = itemView.findViewById(R.id.tv_no)

            itemView.setOnClickListener {

                listener?.partClick(list?.get(adapterPosition)?: RiderDeliverPendingReceivePartResponse.Data())
            }

        }



    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_engineer_parts,
                parent,
                false
            )
        )


    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {

        holder.partName?.text = list?.get(position)?.partName
        holder.partSku?.text = list?.get(position)?.partSku

        holder.partBarcode?.text = list?.get(position)?.partBarcode


        holder.deviceBarcode?.text = list?.get(position)?.deviceBarcode
        holder.deviceName?.text = list?.get(position)?.deviceName


        holder.tvNo?.text = (position+1).toString()

    }

    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<RiderDeliverPendingReceivePartResponse.Data>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


    interface OnPartClickListener{
        fun partClick(list: RiderDeliverPendingReceivePartResponse.Data)
    }
}