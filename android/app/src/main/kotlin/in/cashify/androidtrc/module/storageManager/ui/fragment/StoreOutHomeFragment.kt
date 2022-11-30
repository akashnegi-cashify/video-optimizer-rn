package `in`.cashify.androidtrc.module.storageManager.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentEngPartBinding
import `in`.cashify.androidtrc.databinding.FragmentStoreOutHomeBinding
import `in`.cashify.androidtrc.generated.callback.OnClickListener
import `in`.cashify.androidtrc.module.engineer.api.response.DeviceStorageDetailResponse
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.data.EngPartsViewModel
import `in`.cashify.androidtrc.module.storageManager.data.StorageOutActivityListener
import `in`.cashify.androidtrc.module.storageManager.data.StoreOutViewMadel
import `in`.cashify.androidtrc.module.storageManager.ui.activity.StoreOutActivity
import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class StoreOutHomeFragment : BaseFragment() ,View.OnClickListener {

    private var mPartList: ArrayList<EngineerPartInfo>? = null
    lateinit var binding: FragmentStoreOutHomeBinding
    var storeOutActivityListener: StorageOutActivityListener? = null


    companion object {
        private const val KEY_PART_INFO_LIST = "key_part_list"
        private const val KEY_STATUS = "key_status"

        fun newInstance(): StoreOutHomeFragment {
            val args = Bundle()
            val fragment = StoreOutHomeFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mPartList = arguments?.getParcelableArrayList(KEY_PART_INFO_LIST)
     }

    override fun onCreateView(inflater: LayoutInflater, container: ViewGroup?, savedInstanceState: Bundle?): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_store_out_home, container, false)
         return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activityViewModel = getActivityViewModel(StoreOutViewMadel::class.java)
        binding.storeOutViewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner

        storeOutActivityListener = binding.storeOutViewModel!!.storeOutActivityListener


        binding.btnSubmitBarcode.setOnClickListener(this)
        binding.nextButton.setOnClickListener(this)



        if(binding.storeOutViewModel?.deviceDetailsModel == null)
        {
           // binding.rlDevice.visibility = View.GONE
        }
        else
        {
            updateDeviceDetails(binding.storeOutViewModel?.deviceDetailsModel!!)
            binding.rlDevice.visibility = View.VISIBLE

        }


    }

    override fun onClick(v: View?)
    {
             when (v?.id) {
                binding.btnSubmitBarcode.id ->
                {
                    binding.storeOutViewModel?.getDeviceStorageDetails(binding.etBarcode.text.toString(), object :
                        OnResult<DeviceStorageDetailResponse> {
                        override fun onResultAvailable(data: DeviceStorageDetailResponse) {
                            if (data.isSuccess!!)
                            {
                                updateDeviceDetails(data)
                                binding.nextButton.isEnabled = true
                              }
                            else
                            {
                                activityListener?.showError(data.errorMsg)
                            }
                        }
                    })

                }
                binding.nextButton.id ->
                    binding.storeOutViewModel?.storeOutActivityListener?.showStoreOutFragment()




        }
     }

    private fun updateDeviceDetails(data: DeviceStorageDetailResponse)
    {
        binding.rlDevice.visibility = View.VISIBLE

        binding.deviceName.text = "Device Name: " + data?.dt?.pt
        binding.deviceBarcode.text = "Device Barcode: " + data?.dt?.dbr
        binding.locationBarcode.text = "Location Barcode: " + data?.dt?.tbr



    }

    override fun onResume()
    {
        super.onResume()

        storeOutActivityListener!!.hideButtonLayout(true)

    }
}