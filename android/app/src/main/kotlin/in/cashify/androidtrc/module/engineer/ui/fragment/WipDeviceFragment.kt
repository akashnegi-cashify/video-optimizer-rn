package `in`.cashify.androidtrc.module.engineer.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentWipDeviceBinding
import `in`.cashify.androidtrc.module.engineer.adapter.WipDeviceAdapter

import `in`.cashify.androidtrc.module.engineer.api.response.EngineerDeviceInfo
import `in`.cashify.androidtrc.module.engineer.data.EngineerMyDevicesTabViewModel

import `in`.cashify.androidtrc.module.engineer.ui.activity.WipOptionActivity
import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class WipDeviceFragment : BaseFragment(), WipDeviceAdapter.OnItemClick , SwipeRefreshLayout.OnRefreshListener {
    override fun onRefresh() {
        binding.swipeLayout.setRefreshing(false)

        activityViewModel?.engineerWIPDeviceList()
    }

    var activityViewModel: EngineerMyDevicesTabViewModel? = null
    var wipPagerAdapter = WipDeviceAdapter()


    override fun onItemClick(deviceInfo: EngineerDeviceInfo?)


    {
        val intent = Intent(context, WipOptionActivity::class.java)
        intent.putExtra(WipOptionActivity.KEY_DEVICE_INFO, deviceInfo)
     startActivityForResult(intent, WIP_OPTION_REQUEST_CODE)
    }

    //    private var mIsPending: Boolean? = false
    lateinit var binding: FragmentWipDeviceBinding


    companion object {
        private const val KEY_DEVICE_INFO_LIST = "key_device_list"
        const val WIP_OPTION_REQUEST_CODE = 2342

        fun newInstance(): WipDeviceFragment {
            val args = Bundle()

            val fragment = WipDeviceFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        mDeviceList = arguments?.getParcelableArrayList(KEY_DEVICE_INFO_LIST)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_wip_device, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
//        val activityViewModel = getActivityViewModel(WipActivityViewModel::class.java)


        activityViewModel = getActivityViewModel(EngineerMyDevicesTabViewModel::class.java)

        binding.viewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner

        binding.rvDevices.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false)

        binding.rvDevices.adapter = wipPagerAdapter
//        activityViewModel?.l4PendingList?.value = mDeviceList
//        wipPagerAdapter?.changeDataSet(mDeviceList)



        binding.swipeLayout.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        binding.swipeLayout.setOnRefreshListener(this)
wipPagerAdapter.onItemClick = this

        activityViewModel?.engWipDeviceListResponse?.observe(viewLifecycleOwner, Observer {
            wipPagerAdapter?.changeDataSet(it.deviceList)
        })




        activityViewModel?.engWIPDeviceListScreenLoading?.observe(viewLifecycleOwner, Observer {
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
        activityViewModel?.engineerWIPDeviceList()
    }



    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == WIP_OPTION_REQUEST_CODE && resultCode == Activity.RESULT_OK) {
            activityViewModel?.engineerWIPDeviceList()
        }
    }
}