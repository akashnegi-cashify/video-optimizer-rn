package `in`.cashify.androidtrc.module.storageManager.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentStoreOutScanBinding
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.FetchStorageDetailsResponse
import `in`.cashify.androidtrc.module.storageManager.data.StorageOutActivityListener
import `in`.cashify.androidtrc.module.storageManager.data.StoreOutViewMadel
import `in`.cashify.androidtrc.module.storageManager.ui.activity.StoreOutActivity
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class StoreOutScanFragment : BaseFragment()   {

    private var storeOutActivityListener: StorageOutActivityListener? = null
    private var listener: StorageOutActivityListener? = null
    private var mPartList: ArrayList<EngineerPartInfo>? = null
    lateinit var binding: FragmentStoreOutScanBinding
    var fragmentInstance : BaseFragment? = null

    companion object {
        private const val KEY_PART_INFO_LIST = "key_part_list"
        private const val KEY_STATUS = "key_status"

        fun newInstance(): StoreOutScanFragment {
            val args = Bundle()
            val fragment = StoreOutScanFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
      }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_store_out_scan, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activityViewModel = getActivityViewModel(StoreOutViewMadel::class.java)
        binding.storeOutViewModel = activityViewModel
        listener = binding.storeOutViewModel!!.storeOutActivityListener
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        fragmentInstance = this

        storeOutActivityListener = binding.storeOutViewModel!!.storeOutActivityListener


        showDialog(
            "Are you sure?",
            "Device Barcode :"+binding.storeOutViewModel!!.barcode!!,
            "Ok",
            object : DialogInterface.OnClickListener
            {
                override fun onClick(dialog: DialogInterface?, which: Int)
                {
                    saveStoreOutDevice(binding.storeOutViewModel!!.deviceDetailsModel!!.dt!!.tbr,binding.storeOutViewModel!!.barcode!!)
                }
            },
            "Cancel",
            DialogInterface.OnClickListener { dialog, _ -> fragmentInstance }
        )

    }

    private fun saveStoreOutDevice(tbr: String?, barcode: String) {
        binding.storeOutViewModel!!.saveStoreOutDevice(tbr,barcode, object :
            OnResult<FetchStorageDetailsResponse>
        {
            override fun onResultAvailable(data: FetchStorageDetailsResponse)
            {
                if (data.isSuccess!!)
                {
                    showDialog(
                        "Device Successfully stored out",
                        null,
                        "Ok",
                        object : DialogInterface.OnClickListener
                        {
                            override fun onClick(dialog: DialogInterface?, which: Int) {
                                listener!!.reLaunchActivity()
                            }
                        },
                        "",
                        null
                    )
                }
            }
        })
    }

    override fun onResume()
    {
        super.onResume()

        storeOutActivityListener!!.hideButtonLayout(true)

    }


}




