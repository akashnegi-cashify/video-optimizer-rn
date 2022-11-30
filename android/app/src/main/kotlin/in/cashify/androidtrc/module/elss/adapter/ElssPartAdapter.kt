package `in`.cashify.androidtrc.module.elss.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.module.elss.api.response.ElssPart
import `in`.cashify.androidtrc.module.elss.api.response.SubmitElssRequest
import `in`.cashify.androidtrc.module.elss.data.ElssAction
import `in`.cashify.androidtrc.module.elss.data.OnElssActionHappen
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartInfo
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
class ElssPartAdapter : RecyclerView.Adapter<ElssPartAdapter.ElssBaseViewHolder>() {
    private val VIEW_TYPE_ELSS_PART = 0
    private val VIEW_TYPE_ELSS_PART_MANUAL = 1
    private var elssDeviceList: ArrayList<ElssPart> = ArrayList()
    private var elssAction = arrayListOf(
        ElssAction.NOT_REQUIRED.actionString,
        ElssAction.REPAIRABLE.actionString,
        ElssAction.NOT_REPAIRABLE.actionString
    )
    private var listener: OnElssActionHappen? = null
    var elssRequest: SubmitElssRequest? = null

    fun setElssActionListener(listener: OnElssActionHappen?) {
        this.listener = listener
    }

    fun addPartData(partList: ArrayList<DevicePartInfo>?) {
        if (partList.isNullOrEmpty()) {
            return
        }
        for (part: DevicePartInfo in partList) {
            val elssPart = ElssPart()
            elssPart.partName = part.partName
            elssPart.partSku = part.partSku
            elssPart.isManualAdded = true
            elssPart.partCount = part.orderQuantity
            elssPart.partColor = part.partColor
            this.elssRequest?.repairPartList?.add(elssPart)
        }
        notifyDataSetChanged()
    }

    private fun removePart(part: ElssPart?) {
        if (this.elssRequest?.repairPartList == null) {
            return
        }

        for (elssPart: ElssPart in this.elssRequest?.repairPartList!!) {
            if (elssPart.partName.equals(part?.partName) && elssPart.isManualAdded) {
                this.elssRequest?.repairPartList?.remove(elssPart)
                break
            }
        }
        notifyDataSetChanged()
        listener!!.notifyFilter(this.elssRequest?.repairPartList!!)
    }

    fun changeDataSet(elssDeviceList: ArrayList<ElssPart>?) {
        if (elssDeviceList == null) {
            return
        }
        if (elssRequest == null) {
            elssRequest = SubmitElssRequest()
        }
        this.elssDeviceList = elssDeviceList
        this.elssRequest?.repairPartList = elssDeviceList
//        val repairPartList = elssRequest?.repairPartList
//        if (repairPartList != null) {
//            for (i in 0 until repairPartList.size) {
//                repairPartList.get(i).
//            }
//
//        }
        notifyDataSetChanged()
    }

    inner class ElssManualPartHolder(itemView: View) : ElssBaseViewHolder(itemView),
        View.OnClickListener {
        var tvCount: TextView? = null
        var tvPartName: TextView? = null
        var tvPartCount: TextView? = null
        var tvPartColor: TextView? = null
        var tvPartSku: TextView? = null
        var button: ImageView? = null
        var currentPosition: Int = -1
        var elssPart: ElssPart? = null
        var camera:ImageView? = null

        init {
            tvCount = itemView.findViewById(R.id.tv_counter)
            tvPartName = itemView.findViewById(R.id.tv_part_name)
            tvPartCount = itemView.findViewById(R.id.tv_part_count)
            tvPartColor = itemView.findViewById(R.id.tv_part_color)
            tvPartSku = itemView.findViewById(R.id.tv_part_sku)


            button = itemView.findViewById(R.id.btn_remove)
            camera = itemView.findViewById(R.id.camera)
            camera?.setOnClickListener {
                listener?.onCaptureImage(elssDeviceList.get(adapterPosition))
            }
        }

        override fun bindData(position: Int) {
            currentPosition = position
            elssPart = elssDeviceList.get(position)
            button?.setOnClickListener(this)
            tvCount?.text = (currentPosition + 1).toString().plus(". ")
            tvPartName?.text = elssPart?.partName
            tvPartCount?.text = "-" + elssPart?.partCount
            tvPartColor?.text = "-" + elssPart?.partColor
            tvPartSku?.text = "-" + elssPart?.partSku




        }

        override fun onClick(v: View?) {
            removePart(elssPart)
        }

    }

    inner class ElssViewHolder(itemView: View) : ElssBaseViewHolder(itemView),
        AdapterView.OnItemSelectedListener {
        var tvCount: TextView? = null
        var tvColor: TextView? = null
        var tvPartName: TextView? = null
        var skuPart: TextView? = null

        var spinner: Spinner? = null
        var currentPosition: Int = -1
        var camera:ImageView? = null

        init {
            tvCount = itemView.findViewById(R.id.tv_counter)
            tvPartName = itemView.findViewById(R.id.tv_part_name)
            tvColor = itemView.findViewById(R.id.tv_part_color)
            skuPart = itemView.findViewById(R.id.tv_part_sku)

            spinner = itemView.findViewById(R.id.spinner)
            camera = itemView.findViewById(R.id.camera)
            camera?.setOnClickListener {
                listener?.onCaptureImage(elssDeviceList.get(adapterPosition))
            }
        }

        override fun bindData(position: Int) {
            currentPosition = position
            val elssPart = elssDeviceList.get(position)
            tvCount?.text = (position + 1).toString().plus(". ")
            tvColor?.text = "color -"+elssPart.partColor
            skuPart?.text = "sku -"+elssPart.partSku


            tvPartName?.text = elssPart.partName
            val adapter = ArrayAdapter<String>(
                spinner?.context!!,
                R.layout.simple_spinner_item, elssAction
            )
            adapter.setDropDownViewResource(R.layout.spinner_dropdown_item)

            spinner?.adapter = adapter

            val selectedRepairTypeIndex = getSelectedRepairTypeIndex(elssPart)
            if(elssPart.selectedPos == -1 && selectedRepairTypeIndex >= 0){
                spinner?.setSelection(selectedRepairTypeIndex)
                elssPart.selectedPos = selectedRepairTypeIndex
            }
            else{
                spinner?.setSelection(elssPart.selectedPos)
            }



            spinner?.onItemSelectedListener = this
        }

        override fun onNothingSelected(parent: AdapterView<*>?) {
            Log.e("onNothingSelected","")
        }

        override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
            if (currentPosition == -1) {
                return
            }
            Log.e("onItemSelected","")
            elssRequest?.repairPartList?.get(currentPosition)?.action = elssAction[position]
            elssDeviceList.get(adapterPosition).selectedPos = position
            listener?.onElssActionHappen(getElssAction())
        }
    }

    private fun getSelectedRepairTypeIndex(elssPart: ElssPart?): Int {
        for (index: Int in 1 until elssAction.size) {
            if (elssAction[index].equals(elssPart?.action)) {
                return index
            }
        }
        return 0
    }

    private fun getElssAction(): ElssAction {
        val action = ElssAction.REPAIRABLE
        val repairPartList = elssRequest?.repairPartList ?: return action

        var REPAIRABLE = 0
        var NOT_REPAIRABLE = 0
        var NOT_REQUIRED = 0

        for (part: ElssPart in repairPartList) {
            when (part.action) {
                ElssAction.REPAIRABLE.actionString -> {
                    REPAIRABLE++
                }
                ElssAction.NOT_REPAIRABLE.actionString -> {
                    NOT_REPAIRABLE++
                }
                ElssAction.NOT_REQUIRED.actionString -> {
                    NOT_REQUIRED++
                }
            }

        }
        if (REPAIRABLE == repairPartList.size) {
            return action
        }
        if (NOT_REPAIRABLE > 0 || NOT_REPAIRABLE == repairPartList.size) {
            return ElssAction.NOT_REPAIRABLE
        }
        if (NOT_REQUIRED > 0) {
            return ElssAction.NOT_REQUIRED
        }
        return action
    }

    private fun getElssActionList(): ArrayList<String> {
        val elssActionList = ArrayList<String>()
        val repairPartList = elssRequest?.repairPartList ?: return elssActionList
        for (elssPart: ElssPart in repairPartList) {
            elssActionList.add(elssPart.action!!)
        }
        return elssActionList
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ElssBaseViewHolder {
        when (viewType) {
            VIEW_TYPE_ELSS_PART_MANUAL -> {
                return ElssManualPartHolder(
                    LayoutInflater.from(parent.context).inflate(
                        R.layout.item_elss_manual_part,
                        parent,
                        false
                    )
                )
            }

            VIEW_TYPE_ELSS_PART -> {
                return ElssViewHolder(
                    LayoutInflater.from(parent.context).inflate(
                        R.layout.item_elss_part,
                        parent,
                        false
                    )
                )
            }

        }
        return ElssViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_elss_part,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return elssDeviceList.size
    }

    override fun getItemViewType(position: Int): Int {
        val part = elssDeviceList.get(position)
        return if (part.isManualAdded) {
            VIEW_TYPE_ELSS_PART_MANUAL
        } else {
            VIEW_TYPE_ELSS_PART
        }
    }

    override fun onBindViewHolder(holder: ElssBaseViewHolder, position: Int) {
        holder.bindData(position)
    }

    abstract class ElssBaseViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
        abstract fun bindData(position: Int)
    }

}