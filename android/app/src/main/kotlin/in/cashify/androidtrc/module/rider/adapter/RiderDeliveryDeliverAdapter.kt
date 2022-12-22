package `in`.cashify.androidtrc.module.rider.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel

import `in`.cashify.androidtrc.module.rider.data.response.DeliverEngineerListResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView

class RiderDeliveryDeliverAdapter (val listener:OnPartClickListener?) : RecyclerView.Adapter<RiderDeliveryDeliverAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<DeliverEngineerListResponse.Data>?> {


    var list: List<DeliverEngineerListResponse.Data>? = null

    inner  class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {



        var name: TextView? = null
        var loc: TextView? = null

        var card: CardView? = null
        init {
            name = itemView.findViewById(R.id.tv_engineer_name)
            card = itemView.findViewById(R.id.card)


            loc = itemView.findViewById(R.id.tv_location)

            itemView?.setOnClickListener {

                listener?.partClick(list?.get(adapterPosition)?: DeliverEngineerListResponse.Data())
            }

        }



    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_rider_delivery_deliver,
                parent,
                false
            )
        )


    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {

        holder.name?.text = list?.get(position)?.name
        holder.loc?.text = list?.get(position)?.location


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

    override fun setData(data: List<DeliverEngineerListResponse.Data>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


    interface OnPartClickListener{
        fun partClick(list: DeliverEngineerListResponse.Data)
    }
}