package `in`.cashify.androidtrc.module.engineer.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.elss.adapter.ElssDeviceIssueAdapter
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView

class EngDeviceIssueAdapter : RecyclerView.Adapter<EngDeviceIssueAdapter.Holder>() ,
    BaseViewModel.BindableAdapter<List<String>> {

    var list = emptyList<String>()

    class Holder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var tvIssue = itemView.findViewById(R.id.tv_device_issue) as TextView
    }

    override fun onCreateViewHolder(
        parent: ViewGroup,
        viewType: Int
    ): EngDeviceIssueAdapter.Holder {
        return Holder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_eng_device_issue,
                parent,
                false
            )
        )
    }

    override fun onBindViewHolder(holder: Holder, position: Int) {
        holder.tvIssue.text = list.get(position)
    }

    override fun getItemCount(): Int {
        return list?.size?:0
    }

    override fun setData(data: List<String>) {
        list = data
        notifyDataSetChanged()
    }
}