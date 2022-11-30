package `in`.cashify.androidtrc.module.engineer.adapter

 import `in`.cashify.androidtrc.R
 import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerDeviceInfo
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
 import android.widget.CheckBox
 import android.widget.TextView
 import androidx.cardview.widget.CardView
 import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class EngDevListAdapter() : RecyclerView.Adapter<EngDevListAdapter.EngDevListHolder>(),
    BaseViewModel.BindableAdapter<List<EngineerDeviceInfo>> {
    var selectedPosition: Int = -1
    var onDeviceClick: OnDeviceClick? = null
    var list: List<EngineerDeviceInfo> = emptyList()
    override fun setData(data: List<EngineerDeviceInfo>) {
        list = data
        notifyDataSetChanged()
    }

    fun changeDataSet(data: List<EngineerDeviceInfo>?) {
        if (data == null) {
            return
        }
        list = data
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): EngDevListHolder {
        return EngDevListHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_eng_dev_list,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return list.size
    }

    override fun onBindViewHolder(holder: EngDevListHolder, position: Int) {
        holder.onBind(list[position], position)
    }

    inner class EngDevListHolder(itemView: View) : RecyclerView.ViewHolder(itemView),
        View.OnClickListener {

        var info: EngineerDeviceInfo? = null
        var currentPosition: Int = -1
        override fun onClick(v: View?) {
            onDeviceClick?.onCardClick(info)

        }

        var tvBarcode = itemView.findViewById(R.id.tv_barcode) as TextView
        var tvProductTitle = itemView.findViewById(R.id.tv_product_title) as TextView
        var tvStatus = itemView.findViewById(R.id.tv_status) as TextView
        var checkBox = itemView.findViewById(R.id.radioButton) as CheckBox



        fun onBind(info: EngineerDeviceInfo?, position: Int) {
            checkBox.setOnCheckedChangeListener(null)


            this.info = info
            this.currentPosition = position
            tvBarcode.setText(info?.deviceBarcode)
            tvProductTitle.setText(info?.productTitle)
            tvStatus.setText(info?.status)
            if (info?.status.equals("In Progress")) {
                checkBox.visibility = View.INVISIBLE
            } else {
                checkBox.visibility = View.VISIBLE
            }
            checkBox.isChecked = selectedPosition == position




            checkBox.setOnCheckedChangeListener { buttonView, isChecked ->
                if (!(info?.status.equals("In Progress"))) {
                    if(isChecked){
                        selectedPosition = adapterPosition
                    }
                    else{
                        selectedPosition = -1
                    }

                    onDeviceClick?.onDeviceClick(info)
                    selectedPosition = currentPosition
                    notifyDataSetChanged()
                }



            }

        }

        init {
            itemView.setOnClickListener(this)

        }

    }

    interface OnDeviceClick {
        fun onDeviceClick(info: EngineerDeviceInfo?)

        fun onCardClick(info: EngineerDeviceInfo?)

    }

}