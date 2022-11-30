package `in`.cashify.androidtrc.module.rubbing_engineer.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.databinding.FragmentScanFragmentBinding
import `in`.cashify.androidtrc.databinding.FragmentScanRubingBinding
import `in`.cashify.androidtrc.module.elss.api.response.ElssDeviceResponse
import `in`.cashify.androidtrc.module.elss.api.response.ElssOptionResponse
import `in`.cashify.androidtrc.module.elss.data.ElssViewModel
import `in`.cashify.androidtrc.module.elss.ui.activity.ElssPartSelectionActivity
import `in`.cashify.androidtrc.module.elss.ui.fragment.DetailSelectionFragment
import `in`.cashify.androidtrc.module.rubbing_engineer.api.response.RubbingDeviceReceiveResponse
import `in`.cashify.androidtrc.module.rubbing_engineer.data.RubbingViewModel
import `in`.cashify.androidtrc.module.rubbing_engineer.ui.activity.RubbingActivity
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

class ScanRubbingBarcodeFragment : BaseFragment(),BarcodeScannerFragment.BarcodeScannerListener,
View.OnClickListener {

    companion object {
        fun newInstance() = ScanRubbingBarcodeFragment()
    }

    private lateinit var viewModel: RubbingViewModel
    private lateinit var binding: FragmentScanRubingBinding
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        this.binding = DataBindingUtil.inflate(
            layoutInflater,
            R.layout.fragment_scan_rubing,
            container,
            false
        )
        viewModel = ViewModelProvider(activity!!).get(RubbingViewModel::class.java)
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
        viewModel.receiveDeviceToRub(barcode, object : OnResult<RubbingDeviceReceiveResponse> {
            override fun onResultAvailable(data: RubbingDeviceReceiveResponse) {

                if (data.isSuccess) {
                    (activity as RubbingActivity).openDevicesFragment(barcode)
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
}