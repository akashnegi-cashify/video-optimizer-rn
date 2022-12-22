package `in`.cashify.androidtrc.module.runner.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentL4PendingBinding
import `in`.cashify.androidtrc.module.runner.adapter.L4PendingAdapter
import `in`.cashify.androidtrc.module.runner.api.response.l4.MarkedL4PendingDeviceInfo
import `in`.cashify.androidtrc.module.runner.data.L4ViewModel
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
class MarkedL4PendingFragment : BaseFragment(), L4PendingAdapter.OnItemClick {


    override fun onItemClick(info: MarkedL4PendingDeviceInfo?) {

    }

    private var mPendingList: ArrayList<MarkedL4PendingDeviceInfo>? = null
    lateinit var binding: FragmentL4PendingBinding

    companion object {
        private const val KEY_DEVICE_INFO_LIST = "key_device_list"

        fun newInstance(deviceList: ArrayList<MarkedL4PendingDeviceInfo>?): MarkedL4PendingFragment {
            val args = Bundle()
            args.putParcelableArrayList(KEY_DEVICE_INFO_LIST, deviceList)
            val fragment = MarkedL4PendingFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mPendingList = arguments?.getParcelableArrayList(KEY_DEVICE_INFO_LIST)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_l4_pending, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val activityViewModel = getActivityViewModel(L4ViewModel::class.java)
        binding.l4ViewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        activityViewModel?.createPendingAdapter()
        binding.rvDevices.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false)
        activityViewModel?.pendingAdapter?.onItemClick = this
        binding.rvDevices.adapter = activityViewModel?.pendingAdapter
        activityViewModel?.pendingAdapter?.changeDataSet(mPendingList)

    }

}