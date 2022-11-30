package `in`.cashify.androidtrc.module.runner.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentTrayBinding
import `in`.cashify.androidtrc.module.runner.adapter.TrayAdapter
import `in`.cashify.androidtrc.module.runner.api.response.engineer_tray.TrayInfoAllocatedToEng
import `in`.cashify.androidtrc.module.runner.data.TrayActivityViewModel
import `in`.cashify.androidtrc.module.runner.ui.activity.EngineerTrayScanActivity
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
class TrayFragment : BaseFragment(), TrayAdapter.OnItemClick {

    override fun onItemClick(trayInfo: TrayInfoAllocatedToEng?) {
        val intent = Intent(context, EngineerTrayScanActivity::class.java)
        intent.putExtra(EngineerTrayScanActivity.KEY_TRAY_BARCODE, trayInfo?.trayBarcode)
        startActivity(intent)
    }

    private var mTrayList: ArrayList<TrayInfoAllocatedToEng>? = null
    lateinit var binding: FragmentTrayBinding
    var isScanned: Boolean? = false

    companion object {
        private const val KEY_DEVICE_INFO_LIST = "key_device_list"
        private const val KEY_IS_SCANNED = "key_is_scanned"

        fun newInstance(deviceList: ArrayList<TrayInfoAllocatedToEng>?, isScanned: Boolean): TrayFragment {
            val args = Bundle()
            args.putParcelableArrayList(KEY_DEVICE_INFO_LIST, deviceList)
            args.putBoolean(KEY_IS_SCANNED, isScanned)
            val fragment = TrayFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mTrayList = arguments?.getParcelableArrayList(KEY_DEVICE_INFO_LIST)
        isScanned = arguments?.getBoolean(KEY_IS_SCANNED)
    }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_tray, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        val activityViewModel = getActivityViewModel(TrayActivityViewModel::class.java)
        binding.trayViewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        activityViewModel?.createTrayAdapter()
        binding.rvDevices.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false)
        activityViewModel?.trayAdapter?.onItemClick = this
        binding.rvDevices.adapter = activityViewModel?.trayAdapter
        activityViewModel?.trayAdapter?.changeDataSet(mTrayList)

    }

}