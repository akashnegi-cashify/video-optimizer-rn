package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.DateUtils
import `in`.cashify.androidtrc.module.inventory_manager.api.response.AssignedDeviceListResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.PendingDeviceListResponse
import android.annotation.SuppressLint
import android.view.LayoutInflater
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.widget.CheckBox
import android.widget.ImageView
import android.widget.TextView
import androidx.cardview.widget.CardView
import androidx.core.content.res.ResourcesCompat
import androidx.recyclerview.widget.RecyclerView

class AssignDeviceListAdapter ( val assignRider:(Boolean) -> Unit , val deviceClick:(String)->Unit) : RecyclerView.Adapter<AssignDeviceListAdapter.MyViewHolder>(),
    BaseViewModel.BindableAdapter<List<AssignedDeviceListResponse.DataList>?> {


    var list: List<AssignedDeviceListResponse.DataList>? = null
    var selectedItemPos = ArrayList<Int>()

    @SuppressLint("ClickableViewAccessibility")
    inner  class MyViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        var deviceBarcode: TextView? = null




        var engineerName: TextView? = null
        var repairType: TextView? = null
        var grade: TextView? = null
        var location: TextView? = null
        var partStatus: TextView? = null
        var img:ImageView? = null
        var assignedAt: TextView? = null
var card:CardView? = null


        init {
            engineerName = itemView.findViewById(R.id.tv_engineer_name)
            assignedAt = itemView.findViewById(R.id.tv_assignes_at)
            repairType = itemView.findViewById(R.id.tv_repair_type)
            grade = itemView.findViewById(R.id.tv_grade)

            deviceBarcode = itemView.findViewById(R.id.tv_barcode)
            location = itemView.findViewById(R.id.tv_location)
            partStatus = itemView.findViewById(R.id.tv_part_status)
            img = itemView.findViewById(R.id.img)
            card = itemView.findViewById(R.id.card)


            itemView?.setOnClickListener {

             deviceClick(list?.get(adapterPosition)?.did.toString())
            }






            img?.setOnTouchListener { v, event ->
                if(event.action == MotionEvent.ACTION_UP){
                    if(selectedItemPos.contains(list?.get(adapterPosition)?.did)){
                   img?.background = ResourcesCompat.getDrawable(img?.resources!!,R.drawable.ic_grey_square ,  null)
                     img?.setImageDrawable(null)
                        selectedItemPos.remove(list?.get(adapterPosition)?.did)
                    }


                    else{
                        if(selectedItemPos.size>=10){
                             true
                        }

                        img?.background = ResourcesCompat.getDrawable(img?.resources!!, R.drawable.ic_teal_square ,  null)
                        img?.setImageDrawable(ResourcesCompat.getDrawable(img?.resources!!,R.drawable.ic_done ,  null))
                        selectedItemPos.add(list?.get(adapterPosition)?.did!!)
                    }


                    if(selectedItemPos.size>0){
                        assignRider(true)
//                        listener?.assignRider(true)
                    }
                    else{
                        assignRider(false)
//                        listener?.assignRider(false)
                    }


                }

                true
            }



        }



    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): MyViewHolder {

        return MyViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.row_assign_device,
                parent,
                false
            )
        )


    }

    override fun onBindViewHolder(holder: MyViewHolder, position: Int) {


        if(selectedItemPos.contains(list?.get(position)?.did)){
            holder.img?.background = ResourcesCompat.getDrawable(holder.img?.resources!!, R.drawable.ic_teal_square ,  null)
            holder.img?.setImageDrawable(ResourcesCompat.getDrawable(holder.img?.resources!!,R.drawable.ic_done ,  null))
        }
        else{
            holder.img?.background = ResourcesCompat.getDrawable(holder.img?.resources!!,R.drawable.ic_grey_square ,  null)
            holder.img?.setImageDrawable(null)
        }

if(list?.get(position)?.isUrgent?:false){
    holder.card?.setBackgroundColor(holder.card?.resources!!.getColor(R.color.red ))
}
        else{
    holder.card?.setBackgroundColor(holder.card?.resources!!.getColor(R.color.white ))
        }


        holder.assignedAt?.text =
            DateUtils.getDate(list?.get(position)?.assignedAt ?: 0, DateUtils.dateTimeFormat)
        holder.engineerName?.text = list?.get(position)?.engineerName
        holder.deviceBarcode?.text = list?.get(position)?.deviceBarcode
        holder.repairType?.text = list?.get(position)?.repairType
        holder.grade?.text = list?.get(position)?.grade
        holder.location?.text = list?.get(position)?.lc
        holder.partStatus?.text = list?.get(position)?.partCount.toString()+" out of "+list?.get(position)?.totalPartCount.toString()+" assigned"




    }

    override fun getItemCount(): Int {
        return list?.size ?: 0
    }

    override fun setData(data: List<AssignedDeviceListResponse.DataList>?) {
        list = data ?: ArrayList()
        notifyDataSetChanged()


    }



}