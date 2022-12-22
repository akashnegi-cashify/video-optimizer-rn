package `in`.cashify.androidtrc.module.inventory_manager.fragment.pending

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.FragmentIMPendingPartBarcodeScannedBinding
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerPendingPartViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
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


class IMPendingPartBarcodeScannedFragment : BaseFragment(),
    BarcodeScannerFragment.BarcodeScannerListener {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null

    private lateinit var scannerFragment: BarcodeScannerFragment

    var binding: FragmentIMPendingPartBarcodeScannedBinding? = null
    var pendingPartViewModel: InventoryManagerPendingPartViewModel? = null

    var barcode: String? = ""


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {

        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            layoutInflater,
            R.layout.fragment_i_m_pending_part_barcode_scanned,
            container,
            false
        )


        pendingPartViewModel =
            getActivityViewModel(InventoryManagerPendingPartViewModel::class.java)
        showBarcodeFragment("scanner_tray")

        pendingPartViewModel?.pendingPartDetails?.observe(viewLifecycleOwner, Observer {
            binding?.tvPartName?.text = it.data?.partName
            binding?.tvPartSku?.text = it.data?.sku
            binding?.tvPartColor?.text = it.data?.partColor
        })


        binding?.btnSubmit?.setOnClickListener {
//onBarcodeScanned(binding.etEnterPartCode.text?:"")

            binding?.etEnterPartCode?.text?.let {

                onBarcodeScanned(it.toString())

            }


            // error


            // successful
        }

        return binding?.root
    }


    private fun showBarcodeScanMsg(isSuccess: Boolean) {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel_part_request, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.btn_no) as TextView
        val yes = dialogView.findViewById(R.id.btn_yes) as TextView
        val txt = dialogView.findViewById(R.id.tv) as TextView

        if (isSuccess) {
            txt.text = String.format(resources.getString(R.string.part_barcode_assigned), barcode)
        }


        if (!isSuccess) {
            txt.text =
                String.format(resources.getString(R.string.part_barcode_not_assigned), barcode)
        }

        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        yes.setOnClickListener {

            alertDialog.dismiss()


        }

        cancel.setOnClickListener {
            alertDialog.dismiss()
            alertDialog.dismiss()


        }

        alertDialog.show()


    }


    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMPendingPartBarcodeScannedFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMPendingPartBarcodeScannedFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }

    override fun onBarcodeScanned(barcode: String) {

        this.barcode = barcode


        if (!TextUtils.isEmpty(barcode)) {
            var id: Int? = null
            if (pendingPartViewModel?.partStatus == PartStatus.AVAILABBLE) {
                id = pendingPartViewModel?.prid

            } else {
                id = pendingPartViewModel?.alternatePrid
            }
            id?.let {

                pendingPartViewModel?.linkPendingPartBarcode(it.toString(), barcode)
            } ?: mActivityHelper.showSnackBar(
                activity,
                resources.getString(R.string.prid_empty),
                Style.ALERT,
                null
            )


        }
    }

    override fun hideLayout(show: Boolean) {

    }


    private fun createScannerBarcode(tag: String) {
        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        scannerFragment.setBarcodeScannerListener(this)
        val beginTransaction = childFragmentManager.beginTransaction()
        beginTransaction?.replace(
            binding?.container?.id!!,
            scannerFragment,
            BarcodeScannerFragment.TAG
        )
        beginTransaction?.commitAllowingStateLoss()
//        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
//        mActivityHelper.addFragment(activity!!, scannerFragment,binding?.container?.id!! , true ,tag)
//
//        scannerFragment.setBarcodeScannerListener(this)

    }


    fun showBarcodeFragment(tag: String) {
        resetBarcodeUI()

        createScannerBarcode(tag)
    }


    private fun resetBarcodeUI() {
//        binding.etBarcode.setText("")

    }
}