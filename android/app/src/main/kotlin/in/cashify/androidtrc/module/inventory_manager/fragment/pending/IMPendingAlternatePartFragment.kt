package `in`.cashify.androidtrc.module.inventory_manager.fragment.pending

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentIMPendingAlternatePartBinding
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerPendingPartViewModel
import `in`.cashify.androidtrc.module.inventory_manager.adapter.PendingAlternatePartAvailableAdapter
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import de.keyboardsurfer.android.widget.crouton.Style
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.*


class IMPendingAlternatePartFragment : BaseFragment() {


    var binding:FragmentIMPendingAlternatePartBinding?=null
    var pendingPartViewModel:InventoryManagerPendingPartViewModel?=null
    var adapter: PendingAlternatePartAvailableAdapter?=null



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = DataBindingUtil.inflate(
            layoutInflater,
            R.layout.fragment_i_m_pending_alternate_part,
            container,
            false
        )
        binding?.lifecycleOwner = this


        pendingPartViewModel = getActivityViewModel(InventoryManagerPendingPartViewModel::class.java)
        binding?.viewModel = pendingPartViewModel
        pendingPartViewModel?.pendindDeviceDetailResponse?.observe(viewLifecycleOwner, Observer {
            binding?.tvBarcode?.text = it?.data?.dbr
            binding?.tvDeviceName?.text = it?.data?.pt
            binding?.tvEngineerName?.text = it?.data?.en
            binding?.tvLocation?.text = it?.data?.lc
        })

        adapter = PendingAlternatePartAvailableAdapter(object : PendingAlternatePartAvailableAdapter.OnAlternatePartClickListener {
            override fun alternatePartClick(sku: String, partName:String) {
showrequestPartAlertDialog(sku , partName)
            }

        })


        binding?.recyclerView?.layoutManager = LinearLayoutManager(activity)
        binding?.recyclerView?.adapter = adapter

        pendingPartViewModel?.listAlternateParts(pendingPartViewModel?.prid?:0)

        pendingPartViewModel?.pendingPartDetails?.observe(viewLifecycleOwner, Observer {

            binding?.tvPartSku?.text = it.data?.sku
            binding?.tvPartName?.text = it.data?.partName


        })


        pendingPartViewModel?.initiatePartResponse?.value = null
        pendingPartViewModel?.initiatePartResponse?.observe(viewLifecycleOwner, Observer {
            it?.let {
pendingPartViewModel?.alternatePrid = it.data?.prid

                pendingPartViewModel?.alternatePrid?.let {


                    mActivityHelper.addFragment(
                        activity!!,
                        IMPendingPartBarcodeScannedFragment.newInstance(),
                        R.id.container,
                        true
                    )
                } ?: mActivityHelper.showSnackBar(
                    activity,
                    resources.getString(R.string.prid_empty),
                    Style.ALERT,
                    null
                )



//                pendingPartViewModel?.isShowAlternatePartDetails?.value = true
//                pendingPartViewModel?.btnSyncVisibility?.value = false
//                pendingPartViewModel?.btnQuantityVisibility?.value = false
//                activity?.supportFragmentManager?.popBackStack()


            }
        })
        return binding?.root
    }


    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMPendingAlternatePartFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMPendingAlternatePartFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }

    fun showrequestPartAlertDialog(sku: String , partName:String) {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel_part_request, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.btn_no) as TextView
        val yes = dialogView.findViewById(R.id.btn_yes) as TextView
        val txt = dialogView.findViewById(R.id.tv) as TextView

        txt.text =String.format(resources.getString(R.string.r_u_sure_u_want_to_request), sku)

        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        yes.setOnClickListener {
              pendingPartViewModel?.initiateAlternatePartRequest(pendingPartViewModel?.deviceId?:"" , pendingPartViewModel?.prid?:0, sku,partName)

//            mActivityHelper.addFragment(
//                activity!!,
//                IMPendingPartBarcodeAssignedFragment.newInstance("",prid?:""),
//                R.id.container,
//                true
//            )

            alertDialog.dismiss()


        }

        cancel.setOnClickListener {
            alertDialog.dismiss()
            alertDialog.dismiss()


        }

        alertDialog.show()


    }


}