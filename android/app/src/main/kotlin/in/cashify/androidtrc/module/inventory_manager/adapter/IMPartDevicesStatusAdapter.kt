package `in`.cashify.androidtrc.module.inventory_manager.adapter

import `in`.cashify.androidtrc.module.inventory_manager.IMDeviceAssignedFragment
import `in`.cashify.androidtrc.module.inventory_manager.IMPartListReturnFragment
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerEnum
import `in`.cashify.androidtrc.module.inventory_manager.fragment.pending.IMPendingEngineersFragment
import `in`.cashify.androidtrc.module.inventory_manager.fragment.receive.IMReceiveFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter

class IMPartDevicesStatusAdapter(fragmentMAnager: FragmentManager, val type: Int) :
    FragmentStatePagerAdapter(fragmentMAnager, BEHAVIOR_SET_USER_VISIBLE_HINT) {
    override fun getPageTitle(position: Int): CharSequence? {
        when (type) {
            InventoryManagerEnum.DELIVERY.value -> {
                when (position) {
                    0 -> return "Pending Delivery"
                    1 -> return "Assigned"
                }


            }

            InventoryManagerEnum.RETURNS.value -> {
                when (position) {
                    0 -> return "Receive"
                    1 -> return "Return"
                }

            }

        }

        return "Return"
    }


    override fun getCount(): Int {
        return 2
    }

    override fun getItem(position: Int): Fragment {
        when (type) {
            InventoryManagerEnum.DELIVERY.value -> {
                when (position) {
                    0 -> return IMPendingEngineersFragment.newInstance()
                    1 -> return IMDeviceAssignedFragment.newInstance()
                }

            }

            InventoryManagerEnum.RETURNS.value -> {
                when (position) {
                    0 -> return IMReceiveFragment.newInstance()
                    1 -> return IMPartListReturnFragment.newInstance()
                }

            }
        }

        return IMPendingEngineersFragment()
    }


}