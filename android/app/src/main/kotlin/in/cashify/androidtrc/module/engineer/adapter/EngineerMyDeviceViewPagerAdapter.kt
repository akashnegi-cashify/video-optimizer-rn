package `in`.cashify.androidtrc.module.engineer.adapter

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.module.engineer.ui.fragment.EngDeviceListFragment
import `in`.cashify.androidtrc.module.engineer.ui.fragment.WipDeviceFragment
import `in`.cashify.androidtrc.module.inventory_manager.IMDeviceAssignedFragment
import `in`.cashify.androidtrc.module.inventory_manager.IMPartListReturnFragment
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerEnum
import `in`.cashify.androidtrc.module.inventory_manager.fragment.pending.IMPendingPartDeliveryFragment
import `in`.cashify.androidtrc.module.inventory_manager.fragment.receive.IMReceiveFragment
import android.content.res.Resources
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter

class EngineerMyDeviceViewPagerAdapter (fragmentMAnager: FragmentManager, val resources:Resources): FragmentStatePagerAdapter(fragmentMAnager , BEHAVIOR_SET_USER_VISIBLE_HINT) {
    override fun getPageTitle(position: Int): CharSequence? {



                when(position){
                    0->return resources.getString(R.string.all_devices)
                    1-> return resources.getString(R.string.wip_devices)
                }





         return resources.getString(R.string.all_devices)
    }


    override fun getCount(): Int {
        return 2
    }

    override fun getItem(position: Int): Fragment {

                when(position){
                    0->return EngDeviceListFragment.newInstance()
                    1-> return WipDeviceFragment.newInstance()
                }








        return EngDeviceListFragment.newInstance()
    }


}