package `in`.cashify.androidtrc.module.elss.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.FragmentScanFragmentBinding
import `in`.cashify.androidtrc.module.elss.api.response.ElssDeviceResponse
import `in`.cashify.androidtrc.module.elss.api.response.ElssOptionResponse
import `in`.cashify.androidtrc.module.elss.data.ElssViewModel
import `in`.cashify.androidtrc.module.elss.ui.activity.ElssPartSelectionActivity
import `in`.cashify.androidtrc.util.AppUtils
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider

class ScanElssBarcodeFragment : BaseFragment(),BarcodeScannerFragment.BarcodeScannerListener,
View.OnClickListener {

    companion object {
        fun newInstance() = ScanElssBarcodeFragment()
    }



    private lateinit var viewModel: ElssViewModel
    private lateinit var binding: FragmentScanFragmentBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        this.binding = DataBindingUtil.inflate(
            layoutInflater,
            R.layout.fragment_scan_fragment,
            container,
            false
        )
        viewModel = ViewModelProvider(requireActivity()).get(ElssViewModel::class.java)
        return binding.root
    }

    private lateinit var scannerFragment: BarcodeScannerFragment
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val beginTransaction = childFragmentManager.beginTransaction()
        scannerFragment = BarcodeScannerFragment.newInstance(true, false)
        scannerFragment.setBarcodeScannerListener(this)
        binding.btnSubmitBarcode.setOnClickListener(this)
        beginTransaction.replace(
            binding.fmContainer.id,
            scannerFragment,
            BarcodeScannerFragment.TAG
        )
        beginTransaction.commitAllowingStateLoss()
        setupUI(view)

    }


    override fun onBarcodeScanned(barcode: String) {

        scannerFragment.pauseScanner()
        viewModel.getElssDevice(barcode, object : OnResult<ElssDeviceResponse> {
            override fun onResultAvailable(data: ElssDeviceResponse) {

                if (data.isSuccess) {
                    viewModel.elssDeviceDetail.value=data
                    data.elssDeviceDetail?.let {
                        if (it.isDetailsPresent) {
                            val intent = Intent(
                                activity,
                                ElssPartSelectionActivity::class.java
                            )
                            intent.putExtra(ElssPartSelectionActivity.KEY_DETAIL, data)
                            intent.putExtra(ElssPartSelectionActivity.DEVICE_BARCODE, barcode)
                            startActivity(intent)
                            Handler().postDelayed({ scannerFragment.resumeScanner() }, 500)
                        } else {
                            val beginTransaction = activity?.supportFragmentManager?.beginTransaction()
                            beginTransaction?.replace(
                                R.id.fm_container,
                                DetailSelectionFragment.newInstance(barcode),
                                "DetailSelectionFragment"
                            )
                            beginTransaction?.addToBackStack("DetailSelectionFragment")
                            beginTransaction?.commitAllowingStateLoss()
                        }
                    }
                } else {
                    if(activity is BaseActivity) {
                        (activity as BaseActivity).showError(data.errorMsg)
                    }
                    scannerFragment.resumeScanner()
                }
            }
        }, object : OnResult<Boolean> {
            override fun onResultAvailable(data: Boolean) {
                scannerFragment.resumeScanner()
            }
        })
    }

    override fun hideLayout(show: Boolean) {


    }

    override fun onClick(v: View?) {
        val trim = binding.etBarcode.text?.toString()?.trim()
        if (TextUtils.isEmpty(trim) || trim == null) {
            return
        }
        onBarcodeScanned(trim)
        return
    }


    override fun onPause() {
        super.onPause()

    }

    override fun onStart() {
        super.onStart()
        scannerFragment.resumeScanner()
    }

    override fun onStop() {
        super.onStop()
        scannerFragment.pauseScanner()

    }

}