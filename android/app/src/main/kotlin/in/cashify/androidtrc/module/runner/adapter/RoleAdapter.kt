package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.runner.data.RoleData
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class RoleAdapter() : RecyclerView.Adapter<RoleAdapter.RoleHolder>(),
    BaseViewModel.BindableAdapter<List<RoleData>> {

    companion object {
        const val ENGINEER = "Give to Engineer"
        const val MARK_OK = "Mark Ok Devices"
        const val L4 = "Give to L4"
        const val RECEIVED_DEVICES = "Receive Devices"

        const val VIEW_REPORT = "View Report"
        const val RECEIVED_PARTS = "Receive Parts"
        const val MY_DEVICES = "My Devices"
        const val MANAGE_PARTS = "Manage Parts"
        const val ROLE_RUNNER = "RUNNER"
        const val ROLE_ENGINEER = "ENGINEER"
        const val ROLE_L4 = "L4_ENGINEER"
        const val ROLE_ELSS = "ELSS"
        const val ROLE_RUBBING = "RUBBING_ENGINEER"
        const val STATUS_ALLOTED = "Alloted"
        const val STATUS_RECEIVED = "Received"
        const val SCAN_BARCODE = "Scan Barcode"

        const val SCAN_BARCODE_RUBBING = " Scan Barcode "
        const val RECEIVED_DEVICES_RUBBING = " Received Devices "

        const val ROLE_STORAGE_MANAGER= "STORAGE_MANAGER"

        const val ROLE_INVENTORY_MANAGER = "INVENTORY_MANAGER"
        const val ROLE_RIDER = "RIDER"
        const val ROLE_QC = "PART_QC"

        const val STORE_IN = "Store In"
        const val STORE_OUT = "Store Out"

    }

    private var roleList = emptyList<RoleData>()
    var mOnRoleClick: OnRoleClick? = null
    override fun setData(data: List<RoleData>) {
        roleList = data
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RoleHolder {
        return RoleHolder(
            LayoutInflater.from(parent.context).inflate(
                R.layout.item_role,
                parent,
                false
            )
        )
    }

    override fun getItemCount(): Int {
        return roleList.size
    }

    override fun onBindViewHolder(holder: RoleHolder, position: Int) {
        holder.onBind(roleList[position], mOnRoleClick)
    }

    class RoleHolder(itemView: View) : RecyclerView.ViewHolder(itemView), View.OnClickListener {
        private lateinit var mRole: RoleData
        var mOnRoleClick: OnRoleClick? = null
        override fun onClick(v: View?) {
            mOnRoleClick?.onRoleClick(mRole)
        }

        var tvRole = itemView.findViewById(R.id.tv_roll_name) as TextView

        init {
            itemView.setOnClickListener(this)
        }

        fun onBind(
            role: RoleData,
            onRoleClick: OnRoleClick?
        ) {
            mRole = role
            mOnRoleClick = onRoleClick
            if (!TextUtils.isEmpty(role.roleName)) {
                tvRole.setText(role.roleName)
            }
        }

    }

    interface OnRoleClick {
        fun onRoleClick(roleData: RoleData)
    }
}