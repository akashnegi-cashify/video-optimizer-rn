package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.response.ListAlternatePartResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class PendingAlternatePartAvailableAdapter (val listener: OnAlternatePartClickListener?) : RecyclerView.Adapter<PendingAlternatePartAvailableAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<ListAlternatePartResponse.Data>?> {


    var list: List<ListAlternatePartResponse.Data>? = null

    inner  class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        var tvPartName: TextView? = null


        var tvParkSku: TextView? = null
        var request: Button? = null



        init {
            tvPartName = itemView.findViewById(R.id.tv_part_name)


            tvParkSku = itemView.findViewById(R.id.tv_part_sku)
            request = itemView.findViewById(R.id.request)



            request?.setOnClickListener {

                listener?.alternatePartClick(list?.get(adapterPosition)?.sku?:""  ,list?.get(adapterPosition)?.pn?:"" )
            }

        }



    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_alternate_parts,
                parent,
                false
            )
        )


    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {

      holder.tvPartName?.text  = list?.get(position)?.pn
        holder.tvParkSku?.text  = list?.get(position)?.sku


    }

    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<ListAlternatePartResponse.Data>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


    interface OnAlternatePartClickListener{
        fun alternatePartClick(sku:String , partName:String)
    }
}