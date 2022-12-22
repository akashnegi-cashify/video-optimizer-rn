package `in`.cashify.androidtrc.module.inventory_manager.fragment.receive

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.ActivityQCPartBarcodeScanBinding
import `in`.cashify.androidtrc.databinding.FragmentIMReceiveScanBinding
import `in`.cashify.androidtrc.module.inventory_manager.IMReceiveScanActivityViewModel
import `in`.cashify.androidtrc.module.inventory_manager.api.response.ListReceivePendingPartResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.UpdateReceivePartResponse
import `in`.cashify.androidtrc.util.Validation
import android.content.DialogInterface
import android.content.Intent
import android.os.Bundle
import android.text.TextUtils
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import dagger.android.support.DaggerAppCompatActivity


/**
 * A simple [Fragment] subclass.
 * Use the [IMReceiveScanFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class IMReceiveScanFragment : BaseFragment(), BarcodeScannerFragment.BarcodeScannerListener {
    var binding: FragmentIMReceiveScanBinding? = null
    var viewModel: IMReceiveScanActivityViewModel? = null

    lateinit var scannerFragment: BarcodeScannerFragment


    var barcode: String? = ""

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding =
            DataBindingUtil.inflate(inflater, R.layout.fragment_i_m_receive_scan, container, false)

        viewModel = getActivityViewModel(IMReceiveScanActivityViewModel::class.java)

        binding?.btnSubmit?.setOnClickListener {
            binding?.etEnterPartCode?.text?.let {
                onBarcodeScanned(binding?.etEnterPartCode?.text?.toString() ?: "")

            }


        }

        showBarcodeFragment()




        return binding?.root
    }


    override fun onBarcodeScanned(barcode: String) {

        this.barcode = barcode


        if (!TextUtils.isEmpty(barcode)) {
            viewModel?.partBarcode = barcode

            viewModel?.receivePartList(object : OnResult<ListReceivePendingPartResponse?> {
                override fun onResultAvailable(data: ListReceivePendingPartResponse?) {
                    data?.let {
                        if (data?.data?.size == 0) {
                            showDialogBar(
                                "",
                                resources?.getString(R.string.ok),
                                resources?.getString(R.string.no_parts_present),
                                object : DialogInterface.OnClickListener {
                                    override fun onClick(dialog: DialogInterface?, which: Int) {
                                        dialog?.dismiss()
                                    }

                                })
                        } else if (data.data?.size == 1) {
                            viewModel?.partID = it.data?.get(0)?.prid
                            viewModel?.receivePart(object : OnResult<UpdateReceivePartResponse?> {


                                override fun onResultAvailable(data: UpdateReceivePartResponse?) {
                                    showDialogBar(
                                        "",
                                        resources?.getString(R.string.ok),
                                        String.format(
                                            resources.getString(R.string.barcode_successfully_received),
                                            viewModel?.partBarcode
                                        )
                                        ,
                                        object : DialogInterface.OnClickListener {
                                            override fun onClick(dialog: DialogInterface?, which: Int) {
                                                activity?.finish()
                                                dialog?.dismiss()
                                            }

                                        })

                                }

                            })


                        } else {
                            mActivityHelper.addFragment(
                                activity!!,
                                IMReceivePartListFragment.newInstance(),
                                R.id.container,
                                true
                            )


                        }
                    }
                }

            })



        }
    }

    override fun hideLayout(show: Boolean) {

    }

    private fun createScannerBarcode() {
        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        scannerFragment.setBarcodeScannerListener(this)
        val beginTransaction = childFragmentManager.beginTransaction()
        beginTransaction?.replace(
            binding?.container?.id!!,
            scannerFragment,
            BarcodeScannerFragment.TAG
        )
        beginTransaction?.commitAllowingStateLoss()


    }


    fun showBarcodeFragment() {
        resetBarcodeUI()

        createScannerBarcode()
    }


    private fun resetBarcodeUI() {


    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMReceiveScanFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMReceiveScanFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }



}