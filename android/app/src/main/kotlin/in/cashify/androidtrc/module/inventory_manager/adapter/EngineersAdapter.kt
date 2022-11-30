package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.response.EngineerListResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.recyclerview.widget.RecyclerView

class EngineersAdapter(val listener: OnEngineerClickListener?) :
    RecyclerView.Adapter<EngineersAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<EngineerListResponse.DataList>?> {


    var list: List<EngineerListResponse.DataList>? = null

    var startingCount = 1

    inner class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var engineerName: TextView? = null
        var card: CardView? = null
        var tvCount: TextView? = null

        init {
            engineerName = itemView.findViewById(R.id.tv_engineer_name)
            tvCount = itemView.findViewById(R.id.tv_count)
            card = itemView.findViewById(R.id.card)

            itemView.setOnClickListener {
                listener?.engineerClick(list?.get(adapterPosition)?.id!!)
            }

        }


    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_engineers,
                parent,
                false
            )
        )


    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {
        holder.tvCount?.text = ""+(startingCount+position)
        holder.engineerName?.text = list?.get(position)?.name

    }

    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<EngineerListResponse.DataList>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }


    interface OnEngineerClickListener {
        fun engineerClick(id: Int)
    }
}