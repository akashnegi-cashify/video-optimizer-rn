package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.module.runner.api.response.l4.MarkedL4PendingDeviceInfo
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedL4PendingFragment
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedL4PickedFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter
import androidx.viewpager.widget.PagerAdapter


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class L4PagerAdapter(
    fragmentManager: FragmentManager, internal var mNumOfTabs: Int = 0
) : FragmentStatePagerAdapter(fragmentManager, BEHAVIOR_SET_USER_VISIBLE_HINT) {

    var l4PendingList: ArrayList<MarkedL4PendingDeviceInfo>? = null
    var l4PickedUpList: ArrayList<String>? = null

    fun changePendingDataSet(deviceList: ArrayList<MarkedL4PendingDeviceInfo>?) {
        this.l4PendingList = deviceList
        notifyDataSetChanged()
    }

    fun changePickedDataSet(deviceList: ArrayList<String>?) {
        this.l4PickedUpList = deviceList
        notifyDataSetChanged()
    }

    override fun getItem(position: Int): Fragment {
        when (position) {
            0 -> return MarkedL4PendingFragment.newInstance(l4PendingList)
            1 -> return MarkedL4PickedFragment.newInstance(l4PickedUpList)
        }
        return MarkedL4PendingFragment.newInstance(l4PendingList)
    }

    override fun getItemPosition(`object`: Any): Int {
        return PagerAdapter.POSITION_NONE
    }

    override fun getCount(): Int {
        return mNumOfTabs
    }
}