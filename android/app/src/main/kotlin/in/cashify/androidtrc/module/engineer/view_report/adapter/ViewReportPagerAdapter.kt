package `in`.cashify.androidtrc.module.engineer.view_report.adapter

import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.ui.fragment.EngPartInfoFragment
import `in`.cashify.androidtrc.module.engineer.view_report.ui.fragment.ViewDeviceReportFragment
import `in`.cashify.androidtrc.module.engineer.view_report.ui.fragment.ViewPartReportFragment

import `in`.cashify.androidtrc.util.CommonConstant
import androidx.fragment.app.Fragment
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.FragmentStatePagerAdapter
import androidx.viewpager.widget.PagerAdapter

/**
 * Created by Rishika on 04/12/20.
 */
class ViewReportPagerAdapter (fragmentManager: FragmentManager, internal var mNumOfTabs: Int = 0
) : FragmentStatePagerAdapter(fragmentManager, BEHAVIOR_SET_USER_VISIBLE_HINT) {




    override fun getItemPosition(`object`: Any): Int {
        return PagerAdapter.POSITION_NONE
    }

    override fun getItem(position: Int): Fragment {
        var category = ""
        when(position){
            0-> return ViewDeviceReportFragment.newInstance()
            1-> return ViewPartReportFragment.newInstance()

        }
    return ViewDeviceReportFragment.newInstance()
    }

    override fun getCount(): Int {
        return mNumOfTabs
    }
}