package `in`.cashify.androidtrc.module.inventory_manager.fragment.pending

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentIMPendingPartBarcodeAssignedBinding
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerPendingPartViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import `in`.cashify.androidtrc.module.inventory_manager.api.response.CancelPartResponse
import `in`.cashify.androidtrc.util.Validation
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.fragment.app.FragmentManager
import androidx.lifecycle.Observer
import de.keyboardsurfer.android.widget.crouton.Style
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.*


/**
 * Part Available
 * use prid , dont shaow alternate part details , shpw unlink option
 *
 * Part Not Available  - Dead Part , Alternate part
 * if Dead part - use prid , dont show alternate part details , do not show unlink option
 * If alternate Part - use alternatePartId , show alternatePartDetails, show unlink option
 */
class IMPendingPartBarcodeAssignedFragment : BaseFragment(), View.OnClickListener {

    private var pendingPartViewModel: InventoryManagerPendingPartViewModel? = null


    private var binding: FragmentIMPendingPartBarcodeAssignedBinding? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            layoutInflater,
            R.layout.fragment_i_m_pending_part_barcode_assigned,
            container,
            false
        )
        pendingPartViewModel =
            getActivityViewModel(InventoryManagerPendingPartViewModel::class.java)

        binding?.viewModel = pendingPartViewModel

        if (pendingPartViewModel?.partStatus != PartStatus.AVAILABBLE && pendingPartViewModel?.isDeadPart ?: false) {
            binding?.cardBarCode?.visibility = View.GONE
            binding?.btnCancel?.visibility = View.GONE
        } else {
            binding?.cardBarCode?.visibility = View.VISIBLE
            binding?.btnCancel?.visibility = View.VISIBLE
        }


        if (pendingPartViewModel?.partStatus == PartStatus.AVAILABBLE) {
            binding?.layAvailableQuantity?.visibility = View.VISIBLE
        } else if (pendingPartViewModel?.partStatus == PartStatus.NOT_AVAILABLE) {
            binding?.layAvailableQuantity?.visibility = View.GONE
        }




        pendingPartViewModel?.pendindDeviceDetailResponse?.observe(viewLifecycleOwner, Observer {
            binding?.tvBarcode?.text = it?.data?.dbr
            binding?.tvDeviceName?.text = it?.data?.pt
            binding?.tvEngineerName?.text = it?.data?.en
            binding?.tvLocation?.text = it?.data?.lc
        })


        binding?.imgUnlink?.setOnClickListener(this)
        binding?.btnGoBack?.setOnClickListener(this)
        binding?.btnCancel?.setOnClickListener(this)
//        binding?.tvPartBarcode?.text = viewModel?.barcode

        pendingPartViewModel?.pendingPartDetails?.observe(viewLifecycleOwner, Observer {

            binding?.tvRequestedQuantity?.text = it.data?.requestQuantity

            binding?.tvPartColor?.text = it.data?.partColor
            binding?.tvPartStatus?.text = it.data?.status


            binding?.tvPartSku?.text = it.data?.sku
            binding?.tvPartName?.text = it.data?.partName
            binding?.tvAlternatePartSku?.text = it.data?.asku

            binding?.tvAlternatePartStatus?.text = it.data?.ast
            binding?.tvAlternatePartColor?.text = it.data?.apc


        })


        binding?.tvAvailableQuantity?.text =
            pendingPartViewModel?.availableQuantityResponse?.value?.data?.availabbleQuantity
        binding?.tvPartBarcode?.text = pendingPartViewModel?.barcode



        getPendingPartDetails()




        pendingPartViewModel?.pendingPartUnLinkResponse?.value = null
        pendingPartViewModel?.pendingPartUnLinkResponse?.observe(viewLifecycleOwner, Observer {
            it?.let {
                activity?.supportFragmentManager?.popBackStack()
            }
        })
        return binding?.root
    }

    companion object {

        @JvmStatic
        fun newInstance() =
            IMPendingPartBarcodeAssignedFragment().apply {
                arguments = Bundle().apply {
                }
            }
    }


    private fun getPendingPartDetails() {
        if (!(pendingPartViewModel?.partStatus == PartStatus.AVAILABBLE) && !(pendingPartViewModel?.isDeadPart
                ?: true)
        ) {
            // alternate part
            pendingPartViewModel?.getPendingPartDetails(pendingPartViewModel?.alternatePrid ?: 0)
            binding?.layAlternateParts?.visibility = View.VISIBLE
        } else {
            pendingPartViewModel?.getPendingPartDetails(pendingPartViewModel?.prid ?: 0)
            binding?.layAlternateParts?.visibility = View.GONE
        }

    }

    override fun onClick(v: View?) {
        when (v?.id) {
            binding?.imgUnlink?.id -> {

                showUnlinkAlertDialog()


            }


            binding?.btnGoBack?.id -> {
                activity?.supportFragmentManager?.popBackStack(IMPendingDevicePartDetailsFragment.TAG,FragmentManager.POP_BACK_STACK_INCLUSIVE)

//                activity?.onBackPressed()
            }


            binding?.btnCancel?.id -> {


                showCancelAlertDialog()


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
                            activity?.supportFragmentManager?.popBackStack()

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

            activity?.supportFragmentManager?.popBackStack(IMPendingDevicePartDetailsFragment.TAG,FragmentManager.POP_BACK_STACK_INCLUSIVE)


        return true
    }


}