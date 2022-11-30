package `in`.cashify.androidtrc.module.inventory_manager.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentInventoryManagerSummaryBinding
import `in`.cashify.androidtrc.databinding.FragmentInventoryManagerTabBinding
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerSummaryViewModel
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerViewModel
import `in`.cashify.androidtrc.module.inventory_manager.adapter.IMPartDevicesStatusAdapter
import `in`.cashify.androidtrc.util.CommonConstant
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer


class InventoryManagerSummaryFragment : BaseFragment() {
    private  var binding: FragmentInventoryManagerSummaryBinding? = null
    private  var viewModel: InventoryManagerSummaryViewModel? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(layoutInflater, R.layout.fragment_inventory_manager_summary, container, false)
        viewModel =  getActivityViewModel(InventoryManagerSummaryViewModel::class.java)

        viewModel?.summaryProgress?.value = false
viewModel?.returnReceiveCountResponse?.observe(viewLifecycleOwner, Observer {
it?.let {
    binding?.tvReturnCount?.text = it.data?.receivedCount.toString()
    setPieChart()
}
})


        viewModel?.summaryProgress?.observe(viewLifecycleOwner, Observer {
            it?.let {
                if(it){
                    binding?.progressBar?.visibility = View.VISIBLE
                }

                else{
                    binding?.progressBar?.visibility = View.GONE
                }
            }
        })
viewModel?.partSummary()
        viewModel?.returnReceiveCount()

        viewModel?.partSummaryResponse?.observe(viewLifecycleOwner, Observer {
it?.let {
    binding?.tvAssignedCount?.text = it.data?.assignedCount.toString()
    binding?.tvPendingCount?.text = it.data?.pendingDeliveriCount.toString()
    setPieChart()
}


        })

        return binding?.root
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment InventoryManagerSummaryFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            InventoryManagerSummaryFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }


    private fun setPieChart(){
        binding?.pieChart?.setDataPoints(
            floatArrayOf(
               viewModel?.partSummaryResponse?.value?.data?.assignedCount?.toFloat()?:0f,
                viewModel?.partSummaryResponse?.value?.data?.pendingDeliveriCount?.toFloat()?:0f,
               viewModel?.returnReceiveCountResponse?.value?.data?.receivedCount?.toFloat()?:0f
            )
        )


        val colorArray = intArrayOf(
            R.color.color_assigned,
            R.color.color_pending_delivery,
            R.color.color_pending_return,

        )
        binding?.pieChart?.setSliceColor(
            colorArray
        )


    }
}