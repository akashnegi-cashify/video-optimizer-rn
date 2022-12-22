package `in`.cashify.androidtrc.module.inventory_manager.fragment.assigned

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerAssignedPartViewModel
import `in`.cashify.androidtrc.module.inventory_manager.adapter.AssignedDevicePartAdapter

import `in`.cashify.androidtrc.module.inventory_manager.api.response.PendingPartListResponse

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.*
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_barcode
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_engineer_name
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_location
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_assigned_grade
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_assigned_repair_type
import kotlinx.android.synthetic.main.row_assign_device.view.*


// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [IMAssignedDeviceDetailsFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class IMAssignedDeviceDetailsFragment : BaseFragment() {


    var viewModel: InventoryManagerAssignedPartViewModel? = null
    var adapter: AssignedDevicePartAdapter? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }






    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val v = inflater.inflate(R.layout.fragment_i_m_assigned_device_details, container, false)
        viewModel =
            getActivityViewModel(InventoryManagerAssignedPartViewModel::class.java)

        viewModel?.pendindDeviceDetailResponse?.value = null
//        viewModel?.pendingDevicePartResponse?.value = null

        viewModel?.pendindDeviceDetailResponse?.observe(viewLifecycleOwner, Observer {
            v.tv_barcode?.text = it?.data?.dbr
            v.tv_device_name?.text = it?.data?.pt
            v?.tv_location?.text = it?.data?.lc
            v?.tv_engineer_name?.text = it?.data?.en

            v?.tv_assigned_repair_type?.text = it?.data?.repairType
            v?.tv_assigned_grade?.text = it?.data?.grade

        })



        adapter = AssignedDevicePartAdapter(object :
            AssignedDevicePartAdapter.OnPartClickListener {
            override fun partClick(data: PendingPartListResponse.Data?) {
                viewModel?.prid = data?.prid
                mActivityHelper.addFragment(
                    activity!!,
                    IMAssignedPartDetailsFragment.newInstance(),
                    R.id.container,
                    true

                )
            }


        })
        v.recyclerView.layoutManager = LinearLayoutManager(activity)
        v.recyclerView.adapter = adapter

        viewModel?.pendingDevicePartResponse?.observe(viewLifecycleOwner, Observer {
            it?.let {
                adapter?.setData(it.data)
            }


        })
        viewModel?.getDevicePartList(true)
        viewModel?.getPendingDeviceDetail()


        return v;
    }


    override fun onResume() {
        super.onResume()



    }
    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMAssignedDeviceDetailsFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMAssignedDeviceDetailsFragment().apply {

            }
    }
}