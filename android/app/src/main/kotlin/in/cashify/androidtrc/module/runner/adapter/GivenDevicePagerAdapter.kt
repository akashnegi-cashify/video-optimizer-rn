package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.module.runner.api.response.device_list.DeviceInfoAllocatedToEng
import `in`.cashify.androidtrc.module.runner.ui.fragment.DeviceAllocatedFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter
import androidx.viewpager.widget.PagerAdapter


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class GivenDevicePagerAdapter(
    fragmentManager: FragmentManager, internal var mNumOfTabs: Int = 0
) : FragmentStatePagerAdapter(fragmentManager, BEHAVIOR_SET_USER_VISIBLE_HINT) {

    var deviceList: ArrayList<DeviceInfoAllocatedToEng>? = null

    fun changeDataSet(deviceList: ArrayList<DeviceInfoAllocatedToEng>?) {
        this.deviceList = deviceList
        notifyDataSetChanged()
    }

    override fun getItemPosition(`object`: Any): Int {
        return PagerAdapter.POSITION_NONE
    }

    override fun getItem(position: Int): Fragment {
        when (position) {
            0 -> return DeviceAllocatedFragment.newInstance(deviceList,true)
            1 -> return DeviceAllocatedFragment.newInstance(deviceList,false)
        }
        return DeviceAllocatedFragment.newInstance(deviceList,true)
    }

    override fun getCount(): Int {
        return mNumOfTabs
    }
}