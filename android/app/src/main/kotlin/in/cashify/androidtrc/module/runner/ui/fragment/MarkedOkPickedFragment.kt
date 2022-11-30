package `in`.cashify.androidtrc.module.runner.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentMarkOkPickedBinding
import `in`.cashify.androidtrc.module.runner.data.MarkOkViewModel
import `in`.cashify.androidtrc.module.runner.ui.activity.MoveMarkOkDeviceActivity
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
class MarkedOkPickedFragment : BaseFragment(), View.OnClickListener {
    override fun onClick(v: View?) {
        val intent = Intent(context, MoveMarkOkDeviceActivity::class.java)
        intent.putExtra(MoveMarkOkDeviceActivity.KEY_TRAY_BARCODE, "")
        startActivity(intent)
    }

    private var viewModel: MarkOkViewModel? = null
    private var mPickedList: ArrayList<String>? = null
    lateinit var binding: FragmentMarkOkPickedBinding

    companion object {
        private const val KEY_DEVICE_INFO_LIST = "key_device_list"

        fun newInstance(deviceList: ArrayList<String>?): MarkedOkPickedFragment {
            val args = Bundle()
            args.putStringArrayList(KEY_DEVICE_INFO_LIST, deviceList)
            val fragment = MarkedOkPickedFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mPickedList = arguments?.getStringArrayList(KEY_DEVICE_INFO_LIST)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_mark_ok_picked, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        viewModel = getActivityViewModel(MarkOkViewModel::class.java)
        binding.markOkViewModel = viewModel
        viewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        viewModel?.createPickedAdapter()
        binding.rvDevices.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false)
        binding.rvDevices.adapter = viewModel?.pickedAdapter
        viewModel?.pickedAdapter?.changeDataSet(mPickedList)
        binding.bottomButton.setOnClickListener(this)
    }

}