package `in`.cashify.androidtrc.module.rubbing_engineer.adapter

import `in`.cashify.androidtrc.databinding.RowRubbingDeviceBinding
import `in`.cashify.androidtrc.module.rubbing_engineer.api.response.RubbingDeviceData
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import kotlinx.android.synthetic.main.row_rubbing_device.view.*


class RubbingDevicesAdapter( onHasMoreListener: OnHasMoreListener?, val lotDoneOrNotDoneClick:(RubbingDeviceData?,Boolean) -> Unit): PagingAdapter<RubbingDeviceData>() {

    private val mOnHasMoreListener: OnHasMoreListener?

    fun addData(list: ArrayList<RubbingDeviceData>, isSearchedData: Boolean) {
        if (isSearchedData) {
            clear()
        }
        dataSetObserver.onDataSetChanged(list, list.size == 10)
    }

    override fun onCreateBasicItemViewHolder(parent: ViewGroup, viewType: Int): RecyclerView.ViewHolder {
        return CreatedLotListItemViewHolder(
            RowRubbingDeviceBinding.inflate( LayoutInflater.from(parent.context) , parent, false),
            lotDoneOrNotDoneClick)
    }

    override fun onBindBasicItemView(genericHolder: RecyclerView.ViewHolder, position: Int) {
        val detail: RubbingDeviceData = getItem(position)
        if (genericHolder is CreatedLotListItemViewHolder) {
            genericHolder.bindData( detail)
        }
    }

    init {
        mOnHasMoreListener = onHasMoreListener
    }

    override fun getNextPage(dataSetObserver: DataSetObserver<RubbingDeviceData>) {
        if (mOnHasMoreListener != null) {
            mOnHasMoreListener.hasMore(itemCount - 5)
        }
    }
}

class CreatedLotListItemViewHolder(itemView: RowRubbingDeviceBinding, val lotDoneOrNotDoneClick:(RubbingDeviceData?,Boolean) -> Unit
): RecyclerView.ViewHolder(itemView.root){


    private var binding: RowRubbingDeviceBinding? = null

    private var itemResponse: RubbingDeviceData? = null
    init {
        this.binding = itemView

        itemView.root.btn_rubbing_done.setOnClickListener {
            lotDoneOrNotDoneClick(itemResponse,true)
        }

        itemView.root.btn_rubbing_not_done.setOnClickListener {
            lotDoneOrNotDoneClick(itemResponse,false)
        }

    }


    fun bindData(itemResponse: RubbingDeviceData) {

        this.itemResponse = itemResponse

        binding?.tvDeviceBarcode?.text=itemResponse.deviceBarcode
        binding?.tvDeviceId?.text=itemResponse.deviceId.toString()
        binding?.tvDeviceName?.text=itemResponse.productTitle

        binding?.executePendingBindings()

    }

}
