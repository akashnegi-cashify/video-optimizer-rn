package `in`.cashify.androidtrc.module.runner.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentL4PickedBinding
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
class MarkedL4PickedFragment : BaseFragment(), View.OnClickListener {
    override fun onClick(v: View?) {

    }

    private var mPickedList: ArrayList<String>? = null
    lateinit var binding: FragmentL4PickedBinding

    companion object {
        private const val KEY_DEVICE_INFO_LIST = "key_device_list"

        fun newInstance(deviceList: ArrayList<String>?): MarkedL4PickedFragment {
            val args = Bundle()
            args.putStringArrayList(KEY_DEVICE_INFO_LIST, deviceList)
            val fragment = MarkedL4PickedFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mPickedList = arguments?.getStringArrayList(KEY_DEVICE_INFO_LIST)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_l4_picked, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val activityViewModel = getActivityViewModel(L4ViewModel::class.java)
        binding.l4ViewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        activityViewModel?.createPickedAdapter()
        binding.rvDevices.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false)
        binding.rvDevices.adapter = activityViewModel?.pickedAdapter
        activityViewModel?.pickedAdapter?.changeDataSet(mPickedList)
        binding.bottomButton.setOnClickListener(this)
    }

}