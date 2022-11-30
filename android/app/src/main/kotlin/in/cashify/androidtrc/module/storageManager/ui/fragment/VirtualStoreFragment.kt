package `in`.cashify.androidtrc.module.storageManager.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentStoreOutScanBinding
import `in`.cashify.androidtrc.databinding.FragmentVirtualStoreScanBinding
import `in`.cashify.androidtrc.module.engineer.api.response.DeviceStorageDetailResponse
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.FetchStorageDetailsResponse
import `in`.cashify.androidtrc.module.storageManager.api.response.VirtualStoreResponse
import `in`.cashify.androidtrc.module.storageManager.data.StorageOutActivityListener
import `in`.cashify.androidtrc.module.storageManager.data.StoreOutViewMadel
import `in`.cashify.androidtrc.module.storageManager.data.VirtualStoreViewModel
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
class VirtualStoreFragment : BaseFragment()   {

    private var listener: StorageOutActivityListener? = null
    private var mPartList: ArrayList<EngineerPartInfo>? = null
    lateinit var binding: FragmentVirtualStoreScanBinding
    var storeOutActivityListener: StorageOutActivityListener? = null


    companion object
    {

        fun newInstance(): VirtualStoreFragment {
            val args = Bundle()
            val fragment = VirtualStoreFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
      }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_virtual_store_scan, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activityViewModel = getActivityViewModel(VirtualStoreViewModel::class.java)
        binding.virtualStoreViewModel = activityViewModel
         activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner

        storeOutActivityListener = binding.virtualStoreViewModel!!.storeOutActivityListener


        showDialog(
            "Virtual stored in",
                   binding.virtualStoreViewModel!!.barcode!!,
            "Ok",
            object : DialogInterface.OnClickListener
            {
                override fun onClick(dialog: DialogInterface?, which: Int)
                {
                    saveStoreOutDevice(binding.virtualStoreViewModel!!.barcode!!, null)

                }
            },
            "Cancel",
            DialogInterface.OnClickListener { dialog, _ -> dialog?.dismiss() })



    }

    private fun saveStoreOutDevice( barcode: String, nothing: Nothing?) {
        binding.virtualStoreViewModel!!.saveVirtualStoreIn(barcode, object :
            OnResult<VirtualStoreResponse> {
            override fun onResultAvailable(data: VirtualStoreResponse) {
                if (data.isSuccess!!)
                {
                    getVirtualStoreOut(barcode)

                } else {
                    activityListener!!.showError(data.errorMsg)
                }
            }
        })
    }

    private fun getVirtualStoreOut( barcode: String) {
        binding.virtualStoreViewModel!!.getVirtualStoreOut(barcode, object :
            OnResult<VirtualStoreResponse> {
            override fun onResultAvailable(data: VirtualStoreResponse) {
                if (data.isSuccess!!) {

                    showDialog(
                        "Device Successfully Virtual store In and Out",
                        binding.virtualStoreViewModel!!.barcode!!,
                        "Ok",
                        object : DialogInterface.OnClickListener {
                            override fun onClick(dialog: DialogInterface?, which: Int)
                            {
                                storeOutActivityListener!!.reLaunchActivity()
                            }
                        },
                        null,
                        null
                    )


                } else {
                    activityListener!!.showError(data.errorMsg)
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




