package `in`.cashify.androidtrc.module.inventory_manager.fragment.assigned

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentIMAssignedPartDetailsBinding
import `in`.cashify.androidtrc.databinding.FragmentIMPendingPartBarcodeAssignedBinding
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerAssignedPartViewModel

import `in`.cashify.androidtrc.module.inventory_manager.api.response.CancelPartResponse

import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import de.keyboardsurfer.android.widget.crouton.Style


// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [IMAssignedPartDetailsFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class IMAssignedPartDetailsFragment : BaseFragment(), View.OnClickListener {

    private var pendingPartViewModel: InventoryManagerAssignedPartViewModel? = null


    private var binding: FragmentIMAssignedPartDetailsBinding? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            layoutInflater,
            R.layout.fragment_i_m_assigned_part_details,
            container,
            false
        )
        pendingPartViewModel =
            getActivityViewModel(InventoryManagerAssignedPartViewModel::class.java)

        binding?.viewModel = pendingPartViewModel



        binding?.tvAvailableQuantity?.visibility = View.VISIBLE
        binding?.tvQuantity?.visibility = View.GONE


        pendingPartViewModel?.pendindDeviceDetailResponse?.observe(viewLifecycleOwner, Observer {
            binding?.tvBarcode?.text = it?.data?.dbr
            binding?.tvDeviceName?.text = it?.data?.pt
            binding?.tvEngineerName?.text = it?.data?.en
            binding?.tvLocation?.text = it?.data?.lc
        })


        binding?.imgUnlink?.setOnClickListener(this)
        binding?.btnGoBack?.setOnClickListener(this)
        binding?.btnCancel?.setOnClickListener(this)
        binding?.tvAvailableQuantity?.setOnClickListener(this)


        pendingPartViewModel?.pendingPartDetails?.observe(viewLifecycleOwner, Observer {

            binding?.tvRequestedQuantity?.text = it.data?.requestQuantity

            binding?.tvPartColor?.text = it.data?.partColor
            binding?.tvPartStatus?.text = it.data?.status


            binding?.tvPartSku?.text = it.data?.sku
            binding?.tvPartName?.text = it.data?.partName
            binding?.tvAlternatePartSku?.text = it.data?.asku

            binding?.tvAlternatePartStatus?.text = it.data?.ast
            binding?.tvAlternatePartColor?.text = it.data?.apc
            binding?.tvPartBarcode?.text = it.data?.pbr


        })

        pendingPartViewModel?.availableQuantityResponse?.observe(viewLifecycleOwner, Observer {

            it?.let {


                binding?.tvAvailableQuantity?.visibility = View.GONE
                binding?.tvQuantity?.visibility = View.VISIBLE
                binding?.tvQuantity?.text =
                    pendingPartViewModel?.availableQuantityResponse?.value?.data?.availabbleQuantity
            }
        })


//        binding?.tvPartBarcode?.text = pendingPartViewModel?.barcode


        getPendingPartDetails()




        pendingPartViewModel?.pendingPartUnLinkResponse?.value = null
        pendingPartViewModel?.pendingPartUnLinkResponse?.observe(viewLifecycleOwner, Observer {
            it?.let {

                activity?.finish()
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
         * @return A new instance of fragment IMAssignedPartDetailsFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMAssignedPartDetailsFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }


    private fun getPendingPartDetails() {
        pendingPartViewModel?.prid?.let {
            pendingPartViewModel?.getPendingPartDetails(pendingPartViewModel?.prid ?: 0)
        } ?: mActivityHelper.showSnackBar(
            activity,
            resources.getString(R.string.prid_empty),
            Style.ALERT,
            null
        )
        binding?.layAlternateParts?.visibility = View.GONE


    }

    override fun onClick(v: View?) {
        when (v?.id) {
            binding?.imgUnlink?.id -> {

                showUnlinkAlertDialog()


            }


            binding?.btnGoBack?.id -> {
                if (binding?.btnCancel?.visibility == View.VISIBLE) {
                    activity?.supportFragmentManager?.popBackStack()

                } else {
                    activity?.finish()
                }
//
            }


            binding?.btnCancel?.id -> {


                showCancelAlertDialog()


            }

            binding?.tvAvailableQuantity?.id -> {
                pendingPartViewModel?.getAvailableQuantity(pendingPartViewModel?.prid.toString())
            }
        }
    }


    fun showUnlinkAlertDialog() {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel_part_request, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.btn_no) as TextView
        val yes = dialogView.findViewById(R.id.btn_yes) as TextView
        val txt = dialogView.findViewById(R.id.tv) as TextView

        txt.text = String.format(resources.getString(R.string.r_u_sure_u_want_to_unlink), "")

        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        yes.setOnClickListener {
            pendingPartViewModel?.unlinkPendingPartBarcode(pendingPartViewModel?.prid ?: 0)
            alertDialog.dismiss()


        }

        cancel.setOnClickListener {

            alertDialog.dismiss()


        }

        alertDialog.show()


    }


    fun showCancelAlertDialog() {


        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel_part_request, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.btn_no) as TextView
        val yes = dialogView.findViewById(R.id.btn_yes) as TextView


        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        yes.setOnClickListener {
            pendingPartViewModel?.prid?.let {
                pendingPartViewModel?.cancelPartRequest(it.toString(),
                    object : OnResult<CancelPartResponse> {
                        override fun onResultAvailable(data: CancelPartResponse) {
                            getPendingPartDetails()
                            binding?.btnCancel?.visibility = View.GONE
                            binding?.cardBarCode?.visibility = View.GONE

                        }

                    })
            } ?: mActivityHelper.showSnackBar(
                activity,
                resources.getString(R.string.prid_empty),
                Style.ALERT,
                null
            )

            alertDialog.dismiss()


        }

        cancel.setOnClickListener {
            alertDialog.dismiss()


        }

        alertDialog.show()


    }

    override fun onBackPressed(): Boolean {
        if (binding?.btnGoBack?.visibility == View.VISIBLE) {
            activity?.finish()

        } else {
            activity?.supportFragmentManager?.popBackStack()

        }
        return true
    }


}