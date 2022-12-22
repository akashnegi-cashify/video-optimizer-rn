package `in`.cashify.androidtrc.module.rider.ui.pickup

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentRiderDeliveryBinding
import `in`.cashify.androidtrc.databinding.FragmentRiderPickupBinding
import `in`.cashify.androidtrc.module.rider.adapter.RiderDeliveryReceiveViewpagerAdapter
import `in`.cashify.androidtrc.module.rider.adapter.RiderPickupViewpagerAdapter
import `in`.cashify.androidtrc.module.rider.data.RiderActivityViewModel
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import com.google.android.material.tabs.TabLayout
import com.google.android.material.tabs.TabLayoutMediator


// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [RiderPickupFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class RiderPickupFragment  : BaseFragment() {
    private var activityViewModel: RiderActivityViewModel? = null
    private var binding: FragmentRiderPickupBinding? = null


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)


    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {


        activityViewModel = getActivityViewModel(RiderActivityViewModel::class.java)


        // Inflate the layout for this fragment
        binding = DataBindingUtil.inflate(inflater,R.layout.fragment_rider_pickup, container, false)

        binding?.viewPager?.setAdapter(RiderPickupViewpagerAdapter(childFragmentManager, lifecycle))
        TabLayoutMediator(binding!!.tabLayout, binding!!.viewPager, object : TabLayoutMediator.TabConfigurationStrategy
        {
            override fun onConfigureTab(tab: TabLayout.Tab, position: Int) {
                if(position == 0) {
                    tab.text = resources.getString(R.string.receive)
                }

                if(position == 1){
                    tab.text =resources.getString(R.string.deliver)
                }
            }

        }).attach()
        return binding?.root
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment RiderPickupFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            RiderPickupFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }
}