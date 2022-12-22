package `in`.cashify.androidtrc.module.elss.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.module.elss.api.response.ElssOptionList
import `in`.cashify.androidtrc.module.elss.data.CheckBoxType
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CheckBox
import android.widget.CompoundButton
import android.widget.RadioButton
import androidx.recyclerview.widget.RecyclerView

/**
 * Created by Rishika on 24/11/20.
 */
class ElssActionOptionsAdapter(var actionsOptionList: ArrayList<ElssOptionList>, var onItemClickListener: OnItemClickListener)
    : RecyclerView.Adapter<ElssActionOptionsAdapter.ElssActionOptionsHolder>() {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ElssActionOptionsHolder {
        return ElssActionOptionsHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_elss_action_option,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        Log.d("sizeeeeee", actionsOptionList.size.toString())
        return actionsOptionList.size
    }

    override fun onBindViewHolder(holder: ElssActionOptionsHolder, position: Int) {

        holder.checkBoxIsRa?.isChecked=false
        holder.checkBoxIsPna?.isChecked=false
        holder.checkBoxIsGc?.isChecked=false



        if(actionsOptionList[position].isRAVisible){
            holder.checkBoxIsRa?.visibility=View.VISIBLE
        }else{
            holder.checkBoxIsRa?.visibility=View.GONE
        }

        if(actionsOptionList[position].isPNAVisible){
            holder.checkBoxIsPna?.visibility=View.VISIBLE
        }else{
            holder.checkBoxIsPna?.visibility=View.GONE
        }

        if(actionsOptionList[position].isGCVisible){
            holder.checkBoxIsGc?.visibility=View.VISIBLE
        }else{
            holder.checkBoxIsGc?.visibility=View.GONE
        }



        holder.radioBtn?.setOnClickListener {
            onItemClickListener.onItemClick(position)
        }

        holder.checkBoxIsRa?.setOnClickListener {

            onItemClickListener.onCheckBoxClick(position,isRa = holder.checkBoxIsRa?.isChecked?:false,checkBoxId=CheckBoxType.ISRA.type)
        }

        holder.checkBoxIsGc?.setOnClickListener {
            onItemClickListener.onCheckBoxClick(position, isGc = holder.checkBoxIsGc?.isChecked?:false,checkBoxId=CheckBoxType.ISGCA.type)
        }

        holder.checkBoxIsPna?.setOnClickListener {
            onItemClickListener.onCheckBoxClick(position, isPna = holder.checkBoxIsPna?.isChecked?:false,checkBoxId=CheckBoxType.ISPNA.type)
        }

        actionsOptionList[position].let { data->
            holder.radioBtn?.text=data.name
        }



        holder.radioBtn?.isChecked = actionsOptionList[position].isSelected

        if(actionsOptionList[position].isVisible)
            holder.radioBtn?.visibility=View.VISIBLE
        else
            holder.radioBtn?.visibility=View.GONE

    }

    inner class ElssActionOptionsHolder(itemView: View) : RecyclerView.ViewHolder(itemView),
        CompoundButton.OnCheckedChangeListener, View.OnClickListener {


        var radioBtn: RadioButton? = null
        var checkBoxIsRa: CheckBox? = null
        var checkBoxIsGc: CheckBox? = null
        var checkBoxIsPna: CheckBox? = null

        init {
            radioBtn = itemView.findViewById(R.id.radio_btn)
            checkBoxIsRa = itemView.findViewById(R.id.checkBox_isra)
            checkBoxIsGc = itemView.findViewById(R.id.checkBox_isgc)
            checkBoxIsPna = itemView.findViewById(R.id.checkBox_ispna)
        }

        override fun onCheckedChanged(buttonView: CompoundButton?, isChecked: Boolean) {

        }

        override fun onClick(v: View?) {

        }
    }

    interface OnItemClickListener {
        fun onItemClick(pos: Int)
        fun onCheckBoxClick(pos: Int,isRa:Boolean=false,isGc:Boolean=false,isPna:Boolean=false,checkBoxId:Int)
    }

}