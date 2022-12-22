package `in`.cashify.androidtrc.module.rider.adapter

import `in`.cashify.androidtrc.module.qc.ui.QCHomeFragment
import `in`.cashify.androidtrc.module.qc.ui.QCPendingFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.Lifecycle
import androidx.viewpager2.adapter.FragmentStateAdapter

class RiderPickupReceiveViewpagerAdapter(fragmentManager: FragmentManager,
                                         lifecycle: Lifecycle
) : FragmentStateAdapter(fragmentManager, lifecycle) {
    override fun getItemCount(): Int {
        return 2
    }

    override fun createFragment(position: Int): Fragment {
        when(position){
            0->{
                return QCHomeFragment()
            }
            1-> return  QCPendingFragment()
        }

        return QCHomeFragment()
    }
}