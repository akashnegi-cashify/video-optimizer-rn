package `in`.cashify.androidtrc.module.elss.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.module.elss.api.response.ElssPart
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CheckBox
import android.widget.CompoundButton
import android.widget.FrameLayout
import android.widget.TextView
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.recyclerview.widget.RecyclerView

/**
 * Created by Rishika on 24/11/20.
 */
class SkuPartPnaAdapter(var actionsOptionList: ArrayList<ElssPart>, var onItemClickListener: OnCheckBoxClickListener)
    : RecyclerView.Adapter<SkuPartPnaAdapter.SKUPartViewHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): SKUPartViewHolder {
        return SKUPartViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_pna_part_elss,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        Log.d("sizeeeeee", actionsOptionList.size.toString())
        return actionsOptionList.size
    }

    override fun onBindViewHolder(holder: SKUPartViewHolder, position: Int) {
        if(actionsOptionList.get(position).isVisibleForPna){
            holder.card?.setLayoutParams( RecyclerView . LayoutParams (ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT))
        }else{
            holder.card?.setLayoutParams( RecyclerView . LayoutParams( ViewGroup.LayoutParams.MATCH_PARENT, 0))
        }

        holder.tvLine1?.text = "${actionsOptionList.get(position).partName}"
        holder.tvLine2?.text = "SKU- ${actionsOptionList.get(position).partSku}"
        holder.tvLine3?.text = "Color- ${actionsOptionList.get(position).partColor}"

        holder.container?.setOnClickListener {
            holder.checkBox?.isChecked = !(holder.checkBox?.isChecked?:false)
            holder.checkBox?.isChecked?.let { it1 -> onItemClickListener.onCheckBoxClick(position, it1) }
        }




    }

    inner class SKUPartViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView),
        CompoundButton.OnCheckedChangeListener, View.OnClickListener {

        var tvLine1 : TextView?=null
        var tvLine2 :  TextView?=null
        var tvLine3 : TextView?=null
        var checkBox : CheckBox?=null
        var card : FrameLayout?=null
        var container : ConstraintLayout?=null

        init {
             tvLine1 = itemView.findViewById(R.id.tv_line_1)
             tvLine2 = itemView.findViewById(R.id.tv_line_2)
             tvLine3 = itemView.findViewById(R.id.tv_line_3)
             checkBox = itemView.findViewById(R.id.cb_order_part)
             card = itemView.findViewById(R.id.cv_card)
            container = itemView.findViewById(R.id.cl_container)


        }

        override fun onCheckedChanged(buttonView: CompoundButton?, isChecked: Boolean) {
        }

        override fun onClick(v: View?) {
        }
    }

    interface OnCheckBoxClickListener {
        fun onCheckBoxClick(pos: Int,isChecked:Boolean=false)
    }

}