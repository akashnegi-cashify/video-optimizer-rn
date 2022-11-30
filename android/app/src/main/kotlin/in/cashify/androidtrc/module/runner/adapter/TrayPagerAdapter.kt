package `in`.cashify.androidtrc.module.runner.adapter

import `in`.cashify.androidtrc.module.runner.api.response.engineer_tray.TrayInfoAllocatedToEng
import `in`.cashify.androidtrc.module.runner.ui.fragment.TrayFragment
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter
import androidx.viewpager.widget.PagerAdapter


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class TrayPagerAdapter(
    fragmentManager: FragmentManager, internal var mNumOfTabs: Int = 0
) : FragmentStatePagerAdapter(fragmentManager, BEHAVIOR_SET_USER_VISIBLE_HINT) {

    var deviceList: ArrayList<TrayInfoAllocatedToEng>? = null

    fun changeDataSet(deviceList: ArrayList<TrayInfoAllocatedToEng>?) {
        this.deviceList = deviceList
        notifyDataSetChanged()
    }

    override fun getItem(position: Int): Fragment {
        when (position) {
            0 -> TrayFragment.newInstance(deviceList, false)
            1 -> TrayFragment.newInstance(deviceList, true)
        }


        return TrayFragment.newInstance(deviceList,false)
    }

    override fun getItemPosition(`object`: Any): Int {
        return PagerAdapter.POSITION_NONE
    }

    override fun getCount(): Int {
        return mNumOfTabs
    }
}