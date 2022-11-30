package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.response.ListReturnPartsResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.PendingPartListResponse
import android.graphics.Color
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class IMReturnedPartsAdapter(val partClick: (ListReturnPartsResponse.PartListResponse?)-> Unit) : RecyclerView.Adapter<IMReturnedPartsAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<ListReturnPartsResponse.PartListResponse>?> {


    var list: List<ListReturnPartsResponse.PartListResponse>? = null

    inner  class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        var partName: TextView? = null


        var partBarcode: TextView? = null

        var sku: TextView? = null

        init {
            partName = itemView.findViewById(R.id.tv_part_name)


            partBarcode = itemView.findViewById(R.id.tv_part_barcode)
            sku = itemView.findViewById(R.id.tv_part_sku)


            itemView.setOnClickListener {

          partClick(list?.get(adapterPosition))
            }

        }



    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_return_parts,
                parent,
                false
            )
        )


    }


    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<ListReturnPartsResponse.PartListResponse>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


    interface OnPartClickListener{
        fun partClick(data: PendingPartListResponse.Data?)
    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {



        holder.partName?.text = list?.get(position)?.partName
        holder.sku?.text = list?.get(position)?.sku.toString()
        holder.partBarcode?.text = list?.get(position)?.partBarcode
    }
}