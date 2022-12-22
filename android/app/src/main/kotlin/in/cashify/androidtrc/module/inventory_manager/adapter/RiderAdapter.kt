package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.response.AssignedDeviceListResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.RiderListResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CheckBox
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.squareup.picasso.Picasso
import okhttp3.internal.addHeaderLenient

class RiderAdapter(val listener: OnDeviceClickListener?) :
    RecyclerView.Adapter<RiderAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<RiderListResponse.Data>?> {


    var list: List<RiderListResponse.Data>? = null
    var selectedItemPos = -1

    inner class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        var riderName: TextView? = null


        var image: ImageView? = null


        init {
            riderName = itemView.findViewById(R.id.tv_rider)


            image = itemView.findViewById(R.id.img)



            itemView?.setOnClickListener {
                selectedItemPos = adapterPosition
                listener?.riderClick(list?.get(adapterPosition))
                notifyDataSetChanged()




            }



        }


    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_assign_rider,
                parent,
                false
            )
        )


    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        if (position == selectedItemPos) {
            holder.image?.setImageDrawable(holder.image?.resources?.getDrawable(R.drawable.ic_teal_circle))
//            Picasso.get().load(R.drawable.ic_teal_circle).into(holder.image)
        } else {
            holder.image?.setImageDrawable(holder.image?.resources?.getDrawable(R.drawable.ic_teal_stroke_circle))
//            Picasso.get().load(R.drawable.ic_teal_stroke_circle).into(holder.image)
        }


        holder.riderName?.text = list?.get(position)?.riderName


    }

    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<RiderListResponse.Data>?) {
        selectedItemPos = -1
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


    interface OnDeviceClickListener {
        fun riderClick(data: RiderListResponse.Data?)


    }
}