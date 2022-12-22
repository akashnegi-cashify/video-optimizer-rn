package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.response.GroupListResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.RiderListResponse
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CheckBox
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.google.gson.Gson
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap
import kotlin.collections.LinkedHashMap

class GroupListAdapter(var groupClick : (Pair<List<String>, LinkedHashMap<String,Boolean>>)->Unit)  :
    RecyclerView.Adapter<GroupListAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<Pair<List<String>, LinkedHashMap<String,Boolean>>>{


    var list: List<String>? = null
    var groupMap  = LinkedHashMap<String, Boolean>()

    inner class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {
var checkBox:CheckBox? = null
        init {
            checkBox = itemView.findViewById(R.id.checkbox)
       checkBox?.isClickable = false


          itemView?.setOnClickListener {
                if(groupMap.get(list?.get(adapterPosition))?:false){

                    groupMap.put(list?.get(adapterPosition)?:""  , false)
                }


              else{
                    groupMap.put(list?.get(adapterPosition)?:""  , true)
              }




                groupClick(Pair(list!!, groupMap))



            }




        }


    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_group_list,
                parent,
                false
            )
        )


    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {

        holder.checkBox?.text = list?.get(position)

        holder?.checkBox?.isChecked = groupMap.get(list?.get(position))?:false








    }

    override fun getItemCount(): Int {
        return list?.size ?: 0
    }


    override fun setData(data: Pair<List<String>, LinkedHashMap<String, Boolean>>) {
        groupMap?.clear()
        list = ArrayList(data.first)
        groupMap.putAll( data.second)
        notifyDataSetChanged()
    }


}