package `in`.cashify.androidtrc.module.rider.adapter

import `in`.cashify.androidtrc.module.qc.ui.QCHomeFragment
import `in`.cashify.androidtrc.module.qc.ui.QCPendingFragment
import `in`.cashify.androidtrc.module.rider.ui.delivery.RiderDeliveryDeliverFragment
import `in`.cashify.androidtrc.module.rider.ui.delivery.RiderDeliveryFragment
import `in`.cashify.androidtrc.module.rider.ui.pickup.RiderPickupFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.Lifecycle
import androidx.viewpager2.adapter.FragmentStateAdapter

class RiderViewpagerAdapter(fragmentManager: FragmentManager,
                            lifecycle: Lifecycle
) : FragmentStateAdapter(fragmentManager, lifecycle) {
    override fun getItemCount(): Int {
        return 2
    }

    override fun createFragment(position: Int): Fragment {
        when(position){
            0->{
                return RiderDeliveryFragment()
            }
            1-> return  RiderPickupFragment()
        }

        return QCHomeFragment()
    }
}