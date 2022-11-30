package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.EngineerMarkOkDevice
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class MarkOkListAdapter() : RecyclerView.Adapter<MarkOkListAdapter.MarkOkListHolder>(),
    BaseViewModel.BindableAdapter<EngineerMarkOkDevice> {

    private var list: ArrayList<Map.Entry<String, Boolean>> = ArrayList()
    override fun setData(data: EngineerMarkOkDevice) {
        list.plus(data.deviceMap.entries)
        notifyDataSetChanged()
    }

    fun changeDatSet(data: EngineerMarkOkDevice?) {
        list = ArrayList(data?.deviceMap!!.entries)
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MarkOkListHolder {
        return MarkOkListHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_mark_ok_l4,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return list.size
    }

    override fun onBindViewHolder(holder: MarkOkListHolder, position: Int) {
        holder.onBind(list[position])
    }

    class MarkOkListHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        var tvBarcode = itemView.findViewById(R.id.tv_barcode) as TextView
        var tvIsHaving = itemView.findViewById(R.id.tv_is_have) as TextView

        fun onBind(role: Map.Entry<String, Boolean>?) {
            tvBarcode.setText(role?.key)
            tvIsHaving.setText(if (role?.value!!) "Picked" else "Not Picked")
        }

    }

}