package `in`.cashify.androidtrc.module.runner.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentMarkOkPendingBinding
import `in`.cashify.androidtrc.module.runner.adapter.MarkedOkPendingAdapter
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.MarkedOkPendingDeviceInfo
import `in`.cashify.androidtrc.module.runner.data.MarkOkViewModel
import `in`.cashify.androidtrc.module.runner.ui.activity.MoveMarkOkDeviceActivity
import `in`.cashify.androidtrc.module.runner.ui.activity.PickMarkOkDeviceActivity
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 23,July,2019
 */
class MarkedOkPendingFragment : BaseFragment(), MarkedOkPendingAdapter.OnItemClick {


    override fun onItemClick(trayInfo: MarkedOkPendingDeviceInfo?) {
        val intent = Intent(context, PickMarkOkDeviceActivity::class.java)
        intent.putExtra(PickMarkOkDeviceActivity.KEY_TRAY_BARCODE, "")
        intent.putExtra(PickMarkOkDeviceActivity.KEY_ENGINEER_ID, trayInfo?.engineerId)
        startActivity(intent)
    }

    private var mPendingList: ArrayList<MarkedOkPendingDeviceInfo>? = null
    lateinit var binding: FragmentMarkOkPendingBinding

    companion object {
        private const val KEY_DEVICE_INFO_LIST = "key_device_list"

        fun newInstance(deviceList: ArrayList<MarkedOkPendingDeviceInfo>?): MarkedOkPendingFragment {
            val args: Bundle = Bundle()
            args.putParcelableArrayList(KEY_DEVICE_INFO_LIST, deviceList)
            val fragment = MarkedOkPendingFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mPendingList = arguments?.getParcelableArrayList(KEY_DEVICE_INFO_LIST)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_mark_ok_pending, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val activityViewModel = getActivityViewModel(MarkOkViewModel::class.java)
        binding.markOkViewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        activityViewModel?.createPendingAdapter()
        binding.rvDevices.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false)
        activityViewModel?.pendingAdapter?.onItemClick = this
        binding.rvDevices.adapter = activityViewModel?.pendingAdapter
        activityViewModel?.pendingAdapter?.changeDataSet(mPendingList)

    }

}