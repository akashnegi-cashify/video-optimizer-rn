package `in`.cashify.androidtrc.module.inventory_manager.fragment.pending

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentIMPendingDevicePartDetailsBinding
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerPendingPartViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import `in`.cashify.androidtrc.module.inventory_manager.api.response.CancelPartResponse
import android.app.Dialog
import android.os.Bundle
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import de.keyboardsurfer.android.widget.crouton.Style
import kotlinx.android.synthetic.main.fragment_detail_selection.*
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.*
import java.util.*


class IMPendingDevicePartDetailsFragment : BaseFragment(), View.OnClickListener {
    var binding: FragmentIMPendingDevicePartDetailsBinding? = null

    var pendingPartViewModel: InventoryManagerPendingPartViewModel? = null


    var timer: Timer? = null
    private val DELAY: Long = 15000 // in ms


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            layoutInflater,
            R.layout.fragment_i_m_pending_device_part_details,
            container,
            false
        )

        binding?.lifecycleOwner = this
        pendingPartViewModel =
            getActivityViewModel(InventoryManagerPendingPartViewModel::class.java)
        binding?.viewModel = pendingPartViewModel

        pendingPartViewModel?.btnGoBackVisibility?.value = false

        pendingPartViewModel?.btnQuantityVisibility?.value = true



        pendingPartViewModel?.pendingDevicePartResponse?.value = null
        pendingPartViewModel?.availableQuantityResponse?.value = null

        if (pendingPartViewModel?.partStatus == PartStatus.OTHER) {
            binding?.btnAssign?.isEnabled = false
            binding?.btnCancel?.isEnabled = false
            binding?.btnAlternatePart?.isEnabled = false
            binding?.btnDeadPart?.isEnabled = false
            binding?.btnAssign?.setBackground(resources.getDrawable(R.drawable.dark_grey_bg_round_corner))
            binding?.btnCancel?.setBackground(resources.getDrawable(R.drawable.dark_grey_bg_round_corner))
            binding?.btnAlternatePart?.setBackground(resources.getDrawable(R.drawable.dark_grey_bg_round_corner))
            binding?.btnDeadPart?.setBackground(resources.getDrawable(R.drawable.dark_grey_bg_round_corner))
            binding?.btnCancel?.setTextColor(resources.getColor(R.color.white))

            binding?.layAvailableQuantity?.visibility = View.VISIBLE


        } else if (pendingPartViewModel?.partStatus == PartStatus.AVAILABBLE) {


            binding?.btnAssign?.visibility = View.VISIBLE
            binding?.btnAlternatePart?.visibility = View.GONE
            binding?.btnDeadPart?.visibility = View.GONE
            binding?.layAvailableQuantity?.visibility = View.VISIBLE


        } else if (pendingPartViewModel?.partStatus == PartStatus.NOT_AVAILABLE) {
            binding?.btnAssign?.visibility = View.GONE
            binding?.btnAlternatePart?.visibility = View.VISIBLE
            binding?.btnDeadPart?.visibility = View.VISIBLE

            binding?.layAvailableQuantity?.visibility = View.GONE
        }







        pendingPartViewModel?.btnQuantityVisibility?.observe(viewLifecycleOwner, Observer {
            setQuantityBtnVisibility()
        })

        pendingPartViewModel?.pendindDeviceDetailResponse?.observe(viewLifecycleOwner, Observer {
            binding?.tvBarcode?.text = it?.data?.dbr
            binding?.tvDeviceName?.text = it?.data?.pt
            binding?.tvEngineerName?.text = it?.data?.en
            binding?.tvLocation?.text = it?.data?.lc

            pendingPartViewModel?.callRecommendedPartApi(pendingPartViewModel?.prid ?: 0)
        })


        pendingPartViewModel?.pendingPartLinkResponse?.value = null

        pendingPartViewModel?.pendingPartLinkResponse?.observe(viewLifecycleOwner, Observer {

            it?.let {
                if (it?.success ?: false) {
                    activity?.supportFragmentManager?.popBackStack()
                    showBarcodeAssignedDialog()

                    return@Observer
                }


            }


        })





        pendingPartViewModel?.pendingPartDetails?.observe(viewLifecycleOwner, Observer {
            pendingPartViewModel?.btnQuantityVisibility?.value = true

            binding?.tvRequestedQuantity?.text = it.data?.requestQuantity

            binding?.tvPartColor?.text = it.data?.partColor
            binding?.tvPartStatus?.text = it.data?.status


            binding?.tvPartSku?.text = it.data?.sku
            binding?.tvPartName?.text = it.data?.partName

//            isSyncBBtnEnable = true
//            if (isSyncBBtnEnable) {
//                binding?.btnSync?.setBackgroundColor(resources.getColor(R.color.teal))
//            } else {
//
//                binding?.btnSync?.setBackgroundColor(resources.getColor(R.color.lightGrey))
//            }


        })


        pendingPartViewModel?.availableQuantityResponse?.observe(viewLifecycleOwner, Observer {
            if (it != null) {

                pendingPartViewModel?.btnQuantityVisibility?.value = false
            }
        })

        pendingPartViewModel?.btnGoBackVisibility?.observe(viewLifecycleOwner, Observer {
            it?.let {
                if (it) {
                    binding?.btnGoBack?.visibility = View.VISIBLE
                    binding?.layBtn?.visibility = View.GONE
                } else {
                    binding?.btnGoBack?.visibility = View.GONE
                    binding?.layBtn?.visibility = View.VISIBLE
                }
                
            }
        })






        pendingPartViewModel?.btnQuantityVisibility?.observe(viewLifecycleOwner, Observer {
            it?.let {
                if (it) {
                    binding?.tvAvailableQuantity?.visibility = View.VISIBLE
                    binding?.tvQuantity?.visibility = View.GONE

                } else {
                    binding?.tvAvailableQuantity?.visibility = View.GONE
                    binding?.tvQuantity?.visibility = View.VISIBLE

                }


            }


        })


        pendingPartViewModel?.linkDeadPartResponse?.value = null
        pendingPartViewModel?.linkDeadPartResponse?.observe(viewLifecycleOwner, Observer {
            it?.let {

                mActivityHelper.addFragment(
                    requireActivity(),
                    IMPendingPartBarcodeAssignedFragment.newInstance(),
                    R.id.container,
                    true
                )


            }


        })

        pendingPartViewModel?.getPendingPartDetails(pendingPartViewModel?.prid ?: 0)


        binding?.btnAssign?.setOnClickListener(this)
        binding?.btnCancel?.setOnClickListener(this)
        binding?.btnSync?.setOnClickListener(this)
        binding?.tvAvailableQuantity?.setOnClickListener(this)
        binding?.btnAlternatePart?.setOnClickListener(this)
        binding?.btnDeadPart?.setOnClickListener(this)
        binding?.btnGoBack?.setOnClickListener(this)


        pendingPartViewModel?.recommendedPartId?.observe(viewLifecycleOwner, Observer {

            if(TextUtils.isEmpty(it)){
              return@Observer  
            }
            binding?.tvSuggestedBarcode?.text = it
            showPopup(it)

        })


        return binding?.root
    }


    private fun showPopup(barcode: String) {

        val dialog = Dialog(requireContext())

        dialog.setContentView(R.layout.dialog_recommended_barcode)
        dialog.window?.setLayout(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT)
        dialog.setCancelable(true)
        dialog.findViewById<TextView>(R.id.tv_barcode_rec).text = barcode
        dialog.show()
    }


    private fun setQuantityBtnVisibility() {
        if (pendingPartViewModel?.btnQuantityVisibility?.value ?: false) {
            binding?.tvAvailableQuantity?.visibility = View.VISIBLE
            binding?.tvQuantity?.visibility = View.GONE
        } else {
            binding?.tvAvailableQuantity?.visibility = View.GONE
            binding?.tvQuantity?.visibility = View.VISIBLE
            binding?.tvQuantity?.text =
                pendingPartViewModel?.availableQuantityResponse?.value?.data?.availabbleQuantity
        }

    }

    companion object {

        val TAG = "IMPendingDevicePartDetailsFragment"

        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMPendingDevicePartDetailsFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMPendingDevicePartDetailsFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }


    fun showCancelAlertDialog() {


        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel_part_request, null)


        val builder = AlertDialog.Builder(requireContext())

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
                pendingPartViewModel?.cancelPartRequest(pendingPartViewModel?.prid.toString(),
                    object : OnResult<CancelPartResponse> {
                        override fun onResultAvailable(data: CancelPartResponse) {

                            pendingPartViewModel?.getPendingPartDetails(pendingPartViewModel?.prid ?: 0)

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


    fun showBarcodeAssignedDialog() {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel_part_request, null)


        val builder = AlertDialog.Builder(requireActivity())

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.btn_no) as TextView
        cancel.visibility = View.GONE
        val yes = dialogView.findViewById(R.id.btn_yes) as TextView

        val txt = dialogView.findViewById(R.id.tv) as TextView
        yes.text = resources.getString(R.string.ok)

        txt.text = String.format(
            resources.getString(R.string.part_barcode_assign),
            pendingPartViewModel?.barcode
        )


        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        yes.setOnClickListener {
            mActivityHelper.addFragment(
                requireActivity(),
                IMPendingPartBarcodeAssignedFragment.newInstance(),
                R.id.container,
                true
            )
            alertDialog.dismiss()


        }

        cancel.setOnClickListener {
            alertDialog.dismiss()


        }

        alertDialog.show()


    }


    fun showDeadPartAlertDialog() {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel_part_request, null)


        val builder = AlertDialog.Builder(requireActivity())

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.btn_no) as TextView
        val yes = dialogView.findViewById(R.id.btn_yes) as TextView
        val txt = dialogView.findViewById(R.id.tv) as TextView

        txt.text = String.format(resources.getString(R.string.r_u_sure_u_want_to_link), "")
        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        yes.setOnClickListener {
            pendingPartViewModel?.prid?.let {


                pendingPartViewModel?.linkDeadParts(pendingPartViewModel?.prid.toString())
                    ?: mActivityHelper.showSnackBar(
                        activity,
                        resources.getString(R.string.prid_empty),
                        Style.ALERT,
                        null
                    )
            }
            alertDialog.dismiss()


        }

        cancel.setOnClickListener {
            alertDialog.dismiss()


        }

        alertDialog.show()


    }


    override fun onClick(v: View?) {
        when (v?.id) {
            binding?.btnAssign?.id -> {

                pendingPartViewModel?.prid?.let {


                    mActivityHelper.addFragment(
                        requireActivity(),
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
            }
            binding?.btnCancel?.id -> {
                showCancelAlertDialog()
            }


            binding?.btnSync?.id -> {

                pendingPartViewModel?.prid?.let {


                    pendingPartViewModel?.syncPendingPartRequest(it.toString())
                        ?: mActivityHelper.showSnackBar(
                            activity,
                            resources.getString(R.string.prid_empty),
                            Style.ALERT,
                            null
                        )

                }

            }

            binding?.tvAvailableQuantity?.id -> {


                pendingPartViewModel?.prid?.let {
                    pendingPartViewModel?.getAvailableQuantity(it.toString())
                        ?: mActivityHelper.showSnackBar(
                            activity,
                            resources.getString(R.string.prid_empty),
                            Style.ALERT,
                            null
                        )


                }
            }


            binding?.btnAlternatePart?.id -> {
                pendingPartViewModel?.isDeadPart = false
                pendingPartViewModel?.prid?.let {


                    mActivityHelper.addFragment(
                        requireActivity(),
                        IMPendingAlternatePartFragment.newInstance(),
                        R.id.container,
                        true
                    )


                } ?: mActivityHelper.showSnackBar(
                    activity,
                    resources.getString(R.string.prid_empty),
                    Style.ALERT,
                    null
                )
            }


            binding?.btnDeadPart?.id -> {
                pendingPartViewModel?.isDeadPart = true
                showDeadPartAlertDialog()

            }


            binding?.btnGoBack?.id -> {
                activity?.onBackPressed()


            }


        }
    }


    override fun onDestroyView() {
        super.onDestroyView()

    }


}