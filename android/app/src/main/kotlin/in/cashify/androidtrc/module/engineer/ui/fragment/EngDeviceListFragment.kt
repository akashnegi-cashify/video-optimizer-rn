package `in`.cashify.androidtrc.module.engineer.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment

import `in`.cashify.androidtrc.databinding.FragmentEngDeviceListBinding
import `in`.cashify.androidtrc.databinding.FragmentEngPartBinding
import `in`.cashify.androidtrc.module.engineer.adapter.EngDevListAdapter
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerDeviceInfo

import `in`.cashify.androidtrc.module.engineer.data.EngPartsViewModel
import `in`.cashify.androidtrc.module.engineer.data.EngineerMyDevicesTabViewModel
import `in`.cashify.androidtrc.module.engineer.ui.activity.EngineerDevicePartAssignedListActivity
import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


class EngDeviceListFragment : BaseFragment() , EngDevListAdapter.OnDeviceClick,
    View.OnClickListener {
    lateinit var binding: FragmentEngDeviceListBinding



    var mInfo: EngineerDeviceInfo? = null
    var activityViewModel:EngineerMyDevicesTabViewModel? = null


    var adapter: EngDevListAdapter = EngDevListAdapter()

    override fun onClick(v: View?) {
        activityViewModel?.sendToInProgress(mInfo?.deviceBarcode)
    }


    override fun onDeviceClick(info: EngineerDeviceInfo?) {
        binding.btnStatusAction.visibility = View.VISIBLE
//        binding.btnStatusAction.text = "Send to " + info?.status
        binding.btnStatusAction.text = getString(R.string.send_to_in_progress)
        mInfo = info

    }
    override fun onCardClick(info: EngineerDeviceInfo?) {

        startActivity(Intent(activity , EngineerDevicePartAssignedListActivity::class.java).apply {
            putExtra("did", info?.deviceId)
            putExtra("barcode", info?.deviceBarcode)
            putExtra("status", info?.status)
            putExtra("title", info?.productTitle)
        })


    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_eng_device_list, container, false)
        return binding.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)

         activityViewModel = getActivityViewModel(EngineerMyDevicesTabViewModel::class.java)

        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner

        binding.rvDevices.layoutManager = LinearLayoutManager(activity, RecyclerView.VERTICAL, false)


    adapter.onDeviceClick = this
        binding.rvDevices.adapter =adapter
        binding.btnStatusAction.setOnClickListener(this)


        activityViewModel?.engineerDeviceListResponse?.observe(viewLifecycleOwner, Observer {
            adapter?.changeDataSet(it.deviceList)
        })


        activityViewModel?.  engDeviceListScreenLoading?.observe(viewLifecycleOwner, Observer {
            if(it){
                binding.pbProgress.visibility = View.VISIBLE
            }

            else{
                binding.pbProgress.visibility = View.GONE
            }

        })


    }

    override fun onResume() {
        super.onResume()

        activityViewModel?.engineerDeviceList()

    }


    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment EngDeviceListFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            EngDeviceListFragment().apply {

            }
    }
}