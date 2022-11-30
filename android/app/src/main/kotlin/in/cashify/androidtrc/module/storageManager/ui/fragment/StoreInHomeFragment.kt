package `in`.cashify.androidtrc.module.storageManager.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentStoreInHomeBinding
import `in`.cashify.androidtrc.module.engineer.api.response.DeviceStorageDetailResponse
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.api.response.FetchStorageDetailsResponse
import `in`.cashify.androidtrc.module.storageManager.data.StoreInActivityListener
import `in`.cashify.androidtrc.module.storageManager.data.StoreInViewModel
import android.content.Context
import android.content.DialogInterface
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.FragmentManager
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class StoreInHomeFragment : BaseFragment() ,View.OnClickListener {

    private var mPartList: ArrayList<EngineerPartInfo>? = null
    lateinit var binding: FragmentStoreInHomeBinding
    var storeInActivityListener: StoreInActivityListener? = null

    companion object {

        fun newInstance(): StoreInHomeFragment {
            val args = Bundle()
            val fragment = StoreInHomeFragment()
            fragment.arguments = args
            return fragment
        }
    }



    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding =
            DataBindingUtil.inflate(inflater, R.layout.fragment_store_in_home, container, false)
        Log.e("Cashify_Temp", "onCreateView_StoreInHomeFragment")

        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activityViewModel = getActivityViewModel(StoreInViewModel::class.java)
        binding.viewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        storeInActivityListener = binding.viewModel!!.storeInActivityListener


        binding.lifecycleOwner = viewLifecycleOwner

        binding.addPartContainer.setOnClickListener(this)

        updateData()
        inflateRecyclerView()


        if (binding.viewModel!!.isDeviceBarcode!!)
            handlePopUp()


    }


    private fun handlePopUp()
    {
        if(binding.viewModel!!.deviceBarcode != null)
        showDialog(
            "Store In?",
            "Device Barcode :"+binding.viewModel!!.deviceBarcode!!,
            "Ok",
            object : DialogInterface.OnClickListener
            {
                override fun onClick(dialog: DialogInterface?, which: Int) {
                    saveStoreinDevice()
                }
            },
            "Cancel",
            DialogInterface.OnClickListener { dialog, _ -> dialog?.dismiss() }
        )

    }

    private fun saveStoreinDevice()
    {
        binding.viewModel!!.saveStoreinDevice( object : OnResult<FetchStorageDetailsResponse>
        {
            override fun onResultAvailable(data: FetchStorageDetailsResponse)
            {
                if (data.isSuccess!!)
                {
                    binding.viewModel!!.fetchStorageDetailResponse = data!!
                    showDialog(
                        "Device Successfully stored in",
                        "",
                        "Ok",
                        object : DialogInterface.OnClickListener
                        {
                            override fun onClick(dialog: DialogInterface?, which: Int)
                            {
                                binding.viewModel!!.getDeviceStorageDetails( object : OnResult<DeviceStorageDetailResponse> {
                                    override fun onResultAvailable(data: DeviceStorageDetailResponse) {
                                        if (data.isSuccess!!)
                                        {
                                            dialog?.dismiss()
                                            binding.viewModel!!.deviceDetailsList.deviceDetailsList!!.add(data.dt!!)
                                            binding.viewModel!!.isDeviceBarcode = false
                                            binding.viewModel!!.barcodeHeading = "Tray Barcode"


                                            storeInActivityListener!!.popOutFragments()
                                        }
                                        else
                                        {
                                            activityListener!!.showError(data.errorMsg)
                                        }
                                    }
                                })
                            }
                        },
                        "",
                        null
                    )
                }
                else
                {
                    storeInActivityListener!!.popOutFragments()
                    activityListener!!.showError(data.errorMsg)
                }
            }
        })
    }




    /**
     * on click listener callback
     */
    override fun onClick(v: View?)
    {
        when (v?.id)
        {

            binding.addPartContainer.id ->
            {
                handleAddDevice()
            }


        }

    }

    override fun onResume()
    {
        super.onResume()

        Log.e("Cashify_Temp", "onResume_StoreInHomeFragment")


        updateData()
        binding.viewModel!!.adapter?.changeDataSet(binding.viewModel!!.deviceDetailsList)

        if(binding.viewModel?.fetchStorageDetailResponse!!.storageDetails!!.allowCapacity!!.equals(0))
        {
            binding.addPartContainer.visibility = View.GONE
        }
        else
        {
            binding.addPartContainer.visibility = View.VISIBLE

        }
        storeInActivityListener!!.hideButtonLayout(true)

    }

    private fun updateData()
    {
        //bind data with view...
        binding.locationBarcode.text = "Location Barcode: " + binding.viewModel?.fetchStorageDetailResponse!!.storageDetails!!.barcode
        binding.totalCapacity.text = "Total Capacity: " + binding.viewModel?.fetchStorageDetailResponse!!.storageDetails!!.capacity
        binding.capacityLeft.text = "Capacity Left: " + binding.viewModel?.fetchStorageDetailResponse!!.storageDetails!!.allowCapacity

    }

    private fun inflateRecyclerView()
    {
        binding.rvParts.layoutManager = LinearLayoutManager(this.context, RecyclerView.VERTICAL, false) as RecyclerView.LayoutManager?

        //create Adapter instance and attach listener...
        binding.viewModel!!.createAdapter()

        //pass adapter to recycler view...
        binding.rvParts.adapter = binding.viewModel!!.adapter
        binding.viewModel!!.adapter?.changeDataSet(binding.viewModel!!.deviceDetailsList)
    }

    private fun handleAddDevice()
    {
        binding.viewModel!!.isDeviceBarcode = true
        binding.viewModel!!.barcodeHeading = "Device Barcode"

        storeInActivityListener!!.showBarcode()
    }




    override  fun onStart()
    {
        super.onStart()

        Log.e("Cashify_Temp", "onStart_StoreInHomeFragment")


    }


    override fun onStop()
    {
        super.onStop()

        storeInActivityListener!!.hideButtonLayout(false)


        Log.e("Cashify_Temp", "onStop_StoreInHomeFragment")


    }

    override fun onDestroyView()
    {
        super.onDestroyView()

        Log.e("Cashify_Temp", "onDestroyView_StoreInHomeFragment")


    }

    override fun onDestroy()
    {
        super.onDestroy()

        Log.e("Cashify_Temp", "onDestroy_StoreInHomeFragment")


    }

    override fun onDetach()
    {
        super.onDetach()

        Log.e("Cashify_Temp", "onDetach_StoreInHomeFragment")


    }


    override fun onAttach(context: Context) {
        super.onAttach(context)
        Log.e("Cashify_Temp", "onAttach_StoreInHomeFragment")

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        Log.e("Cashify_Temp", "onCreate_StoreInHomeFragment")

    }


}












