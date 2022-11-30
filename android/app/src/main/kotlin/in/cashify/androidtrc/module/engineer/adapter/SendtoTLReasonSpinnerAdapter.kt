package `in`.cashify.androidtrc.module.engineer.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.module.engineer.api.response.ListDeviceReason
import `in`.cashify.androidtrc.module.engineer.api.response.SendToTLReasonResponse
import android.app.Activity
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.TextView

class SendtoTLReasonSpinnerAdapter (
    var context: Activity,
    private var resouceId: Int,
    var list: ArrayList<ListDeviceReason>
) : ArrayAdapter<ListDeviceReason>(context, resouceId, list) {


    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        val label = super.getView(position, convertView, parent) as TextView
        label.setPadding(context.resources.getDimensionPixelSize(R.dimen.space_10dp),context.resources.getDimensionPixelSize(R.dimen.space_10dp),context.resources.getDimensionPixelSize(R.dimen.space_10dp),context.resources.getDimensionPixelSize(R.dimen.space_10dp))

        label.setText(list.get(position).reason)

        return label
    }


    override fun getDropDownView(position: Int, convertView: View?, parent: ViewGroup): View {
        val label = super.getDropDownView(position, convertView, parent) as TextView
        label.setPadding(context.resources.getDimensionPixelSize(R.dimen.space_10dp),context.resources.getDimensionPixelSize(R.dimen.space_10dp),context.resources.getDimensionPixelSize(R.dimen.space_10dp),context.resources.getDimensionPixelSize(R.dimen.space_10dp))
        label.setText(list.get(position).reason)
        return label
    }


    override fun getCount(): Int {
        return super.getCount()-1
    }
}