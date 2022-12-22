package `in`.cashify.androidtrc.module.rider.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.rider.data.response.IMPartsResponse
import `in`.cashify.androidtrc.module.rider.data.response.IMPartListResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class DeliverInventoryManagerPartAdapter (val listener:OnPartClickListener?) : RecyclerView.Adapter<DeliverInventoryManagerPartAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<IMPartListResponse.Data.PartList>?> {


    var list: List<IMPartListResponse.Data.PartList>? = null

    inner  class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {



        var partName: TextView? = null
        var partSku: TextView? = null
        var partBarcode: TextView? = null


        init {
            partName = itemView.findViewById(R.id.tv_part_name)


            partSku = itemView.findViewById(R.id.tv_part_sku)
            partBarcode = itemView.findViewById(R.id.tv_part_barcode)





        }



    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_delivery_im_parts,
                parent,
                false
            )
        )


    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {

        holder.partBarcode?.text = list?.get(position)?.partBarcode
        holder.partName?.text = list?.get(position)?.partName
        holder.partSku?.text = list?.get(position)?.partSku
    }

    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<IMPartListResponse.Data.PartList>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


    interface OnPartClickListener{
        fun partClick(list: IMPartListResponse.Data.PartList)
    }
}