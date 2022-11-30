package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class MarkedOkPickedAdapter : RecyclerView.Adapter<MarkedOkPickedAdapter.MarkedOkPickedHolder>(),
    BaseViewModel.BindableAdapter<List<String>> {

    var pickedList = emptyList<String>()
    override fun setData(data: List<String>) {
        pickedList = data
        notifyDataSetChanged()
    }

    fun changeDataSet(trayList: ArrayList<String>?) {
        if (trayList == null) {
            return
        }
        this.pickedList = trayList
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MarkedOkPickedHolder {
        return MarkedOkPickedHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_single_text,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return pickedList.size
    }

    override fun onBindViewHolder(holder: MarkedOkPickedHolder, position: Int) {
        val allocatedToEng = pickedList[position]
        holder.onBind(allocatedToEng)

    }

    class MarkedOkPickedHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        var pickedDeviceBarcode: String? = null

        fun onBind(barcode: String) {
            this.pickedDeviceBarcode = barcode
            if (!TextUtils.isEmpty(barcode)) {
                tvLine1.text = "Barcode- ${barcode}"
            }
        }

        var tvLine1 = itemView.findViewById(R.id.tv_line_1) as TextView

    }

}