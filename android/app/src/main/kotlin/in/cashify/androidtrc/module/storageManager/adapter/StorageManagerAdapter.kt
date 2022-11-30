package `in`.cashify.androidtrc.module.elss.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.module.elss.adapter.StorageManagerAdapter.StorageManagerAdapterItemViewHolder
import `in`.cashify.androidtrc.module.engineer.api.response.DeviceDetails
import `in`.cashify.androidtrc.module.storageManager.data.DeviceDetailsList
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
class StorageManagerAdapter : RecyclerView.Adapter<StorageManagerAdapterItemViewHolder>()
{
     private var deviceList: ArrayList<DeviceDetails> = ArrayList()


    fun changeDataSet(deviceDetailsList : DeviceDetailsList)
    {
        if (deviceDetailsList == null)
        {
            return
        }

         this.deviceList = deviceDetailsList.deviceDetailsList!!
         notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): StorageManagerAdapterItemViewHolder {
        return StorageManagerAdapterItemViewHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.device_info,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int
    {
        return deviceList!!.size
    }




    class StorageManagerAdapterItemViewHolder(itemView: View) : RecyclerView.ViewHolder(itemView) {

        fun onBind(
            deviceInfo: DeviceDetails,
            position: Int
        ) {

            deviceName.text = deviceInfo.pt
            deviceBarcode.text = deviceInfo.dbr
            index.text = (position+1).toString()

        }

        var deviceName = itemView.findViewById(R.id.device_name) as TextView
        var deviceBarcode = itemView.findViewById(R.id.device_barcode) as TextView
        var index = itemView.findViewById(R.id.index) as TextView

    }

    override fun onBindViewHolder(holder: StorageManagerAdapterItemViewHolder, position: Int)
    {
        val allocatedDevice = deviceList[position]
        holder.onBind(allocatedDevice ,position)


    }

}