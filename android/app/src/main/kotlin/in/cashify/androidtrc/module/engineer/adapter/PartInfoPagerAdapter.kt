package `in`.cashify.androidtrc.module.engineer.adapter

import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.ui.fragment.EngPartInfoFragment
import `in`.cashify.androidtrc.util.CommonConstant
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter
import androidx.viewpager.widget.PagerAdapter


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class PartInfoPagerAdapter(
    fragmentManager: FragmentManager, internal var mNumOfTabs: Int = 0
) : FragmentStatePagerAdapter(fragmentManager, BEHAVIOR_SET_USER_VISIBLE_HINT) {

    var deviceList: ArrayList<EngineerPartInfo>? = null

    fun changeDataSet(deviceList: ArrayList<EngineerPartInfo>?) {
        if (deviceList == null) {
            this.deviceList = ArrayList()
            notifyDataSetChanged()
            return
        }
        this.deviceList = deviceList
        notifyDataSetChanged()
    }

    override fun getItemPosition(`object`: Any): Int {
        return PagerAdapter.POSITION_NONE
    }

    override fun getItem(position: Int): Fragment {
        var status = ""
        when (position) {
            0 -> status = CommonConstant.ENGINEER_RECEIVED_PARTS
            1 -> status = CommonConstant.ENGINEER_CONSUMED_PARTS
            2 -> status = CommonConstant.ENGINEER_REQUESTED_PARTS
            3 -> status = CommonConstant.ENGINEER_ALLOWED_PARTS
        }
        return EngPartInfoFragment.newInstance(deviceList, status)
    }

    override fun getCount(): Int {
        return mNumOfTabs
    }
}