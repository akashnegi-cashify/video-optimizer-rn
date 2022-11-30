package `in`.cashify.androidtrc.module.rider.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.rider.data.response.ReceiveEngineerListResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class ReceiveEngineerListAdapter (val engineerClick :(ReceiveEngineerListResponse.Data ) -> Unit ) : RecyclerView.Adapter<ReceiveEngineerListAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<ReceiveEngineerListResponse.Data>?> {


    var list: List<ReceiveEngineerListResponse.Data>? = null

    inner  class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {



        var name: TextView? = null
        var loc: TextView? = null


        init {
            name = itemView.findViewById(R.id.tv_engineer_name)


            loc = itemView.findViewById(R.id.tv_location)

            itemView?.setOnClickListener {

                engineerClick(list?.get(adapterPosition)?: ReceiveEngineerListResponse.Data())
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

    }

    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<ReceiveEngineerListResponse.Data>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


}