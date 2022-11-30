package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.response.ListReceivePendingPartResponse
import `in`.cashify.androidtrc.module.rider.data.response.IMPartListResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class IMReceivePartListAdaoter(val receiveClick:(data:ListReceivePendingPartResponse.Data?)->Unit) : RecyclerView.Adapter<IMReceivePartListAdaoter.ViewHolder>(), BaseViewModel.BindableAdapter<ArrayList<ListReceivePendingPartResponse.Data>?> {

private var list : ArrayList<ListReceivePendingPartResponse.Data>?  = null
   inner class ViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        var partName: TextView? = null
        var partSku: TextView? = null
        var partBarcode: TextView? = null
        var receive: Button? = null

        init {
            partName = itemView.findViewById(R.id.tv_part_name)


            partSku = itemView.findViewById(R.id.tv_part_sku)
            partBarcode = itemView.findViewById(R.id.tv_part_barcode)



            receive = itemView.findViewById(R.id.receive)

            receive?.setOnClickListener {

           receiveClick(list?.get(adapterPosition))


            }
        }

    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): IMReceivePartListAdaoter.ViewHolder {
        return ViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_im_receive_list,
                parent,
                false
            )
        )

    }

    override fun onBindViewHolder(holder: IMReceivePartListAdaoter.ViewHolder, position: Int) {
        holder.partBarcode?.text = list?.get(position)?.partBarcode
        holder.partName?.text = list?.get(position)?.partName
        holder.partSku?.text = list?.get(position)?.sku
    }

    override fun getItemCount(): Int {


        return  list?.size?:0

    }

    override fun setData(data: ArrayList<ListReceivePendingPartResponse.Data>?) {
        list = data?:ArrayList()
        notifyDataSetChanged()

    }
}