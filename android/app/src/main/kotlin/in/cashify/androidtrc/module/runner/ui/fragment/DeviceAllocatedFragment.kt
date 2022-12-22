package `in`.cashify.androidtrc.module.runner.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentDeviceAllocatedBinding
import `in`.cashify.androidtrc.module.runner.adapter.AllocatedDeviceAdapter
import `in`.cashify.androidtrc.module.runner.api.response.device_list.DeviceInfoAllocatedToEng
import `in`.cashify.androidtrc.module.runner.data.DeviceAllocatedViewModel
import `in`.cashify.androidtrc.module.runner.ui.activity.TrayListActivity
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class DeviceAllocatedFragment : BaseFragment(), AllocatedDeviceAdapter.OnItemClick {
    override fun onItemClick(deviceInfo: DeviceInfoAllocatedToEng?) {
        if (mIsPending!!) {
            val intent = Intent(context, TrayListActivity::class.java)
            intent.putExtra(TrayListActivity.KEY_DEVICE_INFO, deviceInfo)
            startActivity(intent)
        }

    }

    private var mIsPending: Boolean? = false
    lateinit var binding: FragmentDeviceAllocatedBinding
    var mDeviceList: ArrayList<DeviceInfoAllocatedToEng>? = null

    companion object {
        private const val KEY_DEVICE_INFO_LIST = "key_device_list"
        private const val KEY_IS_PENDING = "key_is_pending"

        fun newInstance(deviceList: ArrayList<DeviceInfoAllocatedToEng>?, isPending: Boolean): DeviceAllocatedFragment {
            val args: Bundle = Bundle()
            args.putParcelableArrayList(KEY_DEVICE_INFO_LIST, deviceList)
            args.putBoolean(KEY_IS_PENDING, isPending)
            val fragment = DeviceAllocatedFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mDeviceList = arguments?.getParcelableArrayList(KEY_DEVICE_INFO_LIST)
        mIsPending = arguments?.getBoolean(KEY_IS_PENDING)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_device_allocated, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activityViewModel = getActivityViewModel(DeviceAllocatedViewModel::class.java)
        binding.deviceAllocatedViewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        activityViewModel?.createAllocatedDeviceAdapter()
        binding.rvDevices.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false)
        activityViewModel?.allocatedDeviceAdapter?.onItemClick = this
        binding.rvDevices.adapter = activityViewModel?.allocatedDeviceAdapter
//        activityViewModel?.l4PendingList?.value = mDeviceList
        activityViewModel?.allocatedDeviceAdapter?.changeDataSet(mDeviceList)

    }

}