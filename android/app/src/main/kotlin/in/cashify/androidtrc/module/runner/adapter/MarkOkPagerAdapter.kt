package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.MarkedOkPendingDeviceInfo
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedOkPendingFragment
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedOkPickedFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter
import androidx.viewpager.widget.PagerAdapter


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class MarkOkPagerAdapter(
    fragmentManager: FragmentManager, internal var mNumOfTabs: Int = 0
) : FragmentStatePagerAdapter(fragmentManager, BEHAVIOR_SET_USER_VISIBLE_HINT) {

    var markOkPendingList: ArrayList<MarkedOkPendingDeviceInfo>? = null
    var markOkPickedUpList: ArrayList<String>? = null

    fun changePendingDataSet(deviceList: ArrayList<MarkedOkPendingDeviceInfo>?) {
        this.markOkPendingList = deviceList
        notifyDataSetChanged()
    }

    fun changePickedDataSet(deviceList: ArrayList<String>?) {
        this.markOkPickedUpList = deviceList
        notifyDataSetChanged()
    }

    override fun getItem(position: Int): Fragment {
        when (position) {
            0 ->return MarkedOkPendingFragment.newInstance(markOkPendingList)
            1 ->return MarkedOkPickedFragment.newInstance(markOkPickedUpList)
        }
        return MarkedOkPendingFragment.newInstance(markOkPendingList)
    }

    override fun getItemPosition(`object`: Any): Int {
        return PagerAdapter.POSITION_NONE
    }

    override fun getCount(): Int {
        return mNumOfTabs
    }
}