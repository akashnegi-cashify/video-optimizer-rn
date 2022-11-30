package `in`.cashify.androidtrc.module.qc.ui

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentQCHomeBinding
import `in`.cashify.androidtrc.databinding.FragmentQCPendingBinding
import `in`.cashify.androidtrc.module.qc.QCActivityViewModel
import `in`.cashify.androidtrc.module.qc.QCPartBarcodeScanActivity
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import `in`.cashify.androidtrc.util.UIHelper
import android.app.Activity
import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import de.keyboardsurfer.android.widget.crouton.Style


class QCHomeFragment  : BaseFragment() {
    private val REQUEST_CODE_SCAN  = 101
    private var activityViewModel: QCActivityViewModel? = null
    private var binding: FragmentQCHomeBinding?=null

    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {

        }
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        activityViewModel = getActivityViewModel(QCActivityViewModel::class.java)


        binding?.lifecycleOwner = viewLifecycleOwner



   binding?.btnScanAgain?.setOnClickListener {
       startScanning()
   }


    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_q_c_home, container, false)
        return binding?.root
    }
    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment QCHomeFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            QCHomeFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if(requestCode == REQUEST_CODE_SCAN && resultCode == Activity.RESULT_OK){

            activityViewModel?.getPendingPartList(data?.getStringExtra("barcode")?:"", object :
                OnResult<QCPendingListResponse> {
                override fun onResultAvailable(data: QCPendingListResponse) {
                    if(data.data == null || data?.data?.size == 0 ){
                        UIHelper.showSnackBar(activity , resources.getString(R.string.no_parts_available), Style.ALERT, null)

                    }

                 else  if(data.data?.size == 1){
                       startActivity(Intent(activity, QCPendingPartDetailsActivity::class.java).apply {
                           putExtra("data", data?.data?.get(0))

                       })
                   }

                    else if(data.data?.size?:0 >1){
                       startActivity(Intent(activity, QCPendingPartByBarcodeActivity::class.java).apply {
                           putExtra("data", data?.data)

                       })




                    }
                }

            })



        }
    }

    private fun startScanning(){
        startActivityForResult(Intent(activity, QCPartBarcodeScanActivity::class.java).apply {  }, REQUEST_CODE_SCAN)
    }
}