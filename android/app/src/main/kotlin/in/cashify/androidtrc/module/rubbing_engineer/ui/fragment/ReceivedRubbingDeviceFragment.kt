package `in`.cashify.androidtrc.module.rubbing_engineer.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentRubbingDevicesBinding
import `in`.cashify.androidtrc.module.rubbing_engineer.adapter.OnHasMoreListener
import `in`.cashify.androidtrc.module.rubbing_engineer.adapter.RubbingDevicesAdapter
import `in`.cashify.androidtrc.module.rubbing_engineer.api.response.RubbingDoneResponse
import `in`.cashify.androidtrc.module.rubbing_engineer.data.RubbingViewModel
import `in`.cashify.androidtrc.module.rubbing_engineer.ui.activity.RubbingActivity
import android.app.AlertDialog
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import java.util.*


class ReceivedRubbingDeviceFragment : BaseFragment() ,OnHasMoreListener{

    private lateinit var  activityViewModel:RubbingViewModel

    private var searchKey = ""
    private var offsetCreated = 0
    private var pageSize = 10

    var timer: Timer? = null

    private val DELAY: Long = 500 // in ms

    private var adapter: RubbingDevicesAdapter? = null

    lateinit var binding: FragmentRubbingDevicesBinding


    companion object {
        private const val BARCODE = "barcode"


        fun newInstance(
            barcode: String
        ): ReceivedRubbingDeviceFragment {
            val args = Bundle()
            args.putString(BARCODE, barcode)
            val fragment = ReceivedRubbingDeviceFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_rubbing_devices, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
         activityViewModel = getActivityViewModel(RubbingViewModel::class.java)!!
        binding.viewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner

        searchKey = arguments?.getString(BARCODE)?:""
        binding.etSearch.setText(arguments?.getString(BARCODE)?:"")
        this.offsetCreated=0
        activityViewModel.getRubbingDevicesList(offsetCreated,pageSize,searchKey)

        activityViewModel.dataLoading.observe(
            viewLifecycleOwner,
            androidx.lifecycle.Observer {
                if (it) {
                    binding?.progressBar?.visibility = View.VISIBLE
                } else {
                    binding?.progressBar?.visibility = View.GONE
                }
            })

        activityViewModel.rubbingDeviceReceiveResponse.observe(
            viewLifecycleOwner, androidx.lifecycle.Observer {

                if (offsetCreated == 0) {
                    adapter?.addData(it.dt?.dataList ?: ArrayList(), true)
                    binding.tvNoData.visibility=if(it.dt?.dataList.isNullOrEmpty()){View.VISIBLE}else{ View.GONE}
                } else {
                    adapter?.addData(it.dt?.dataList ?: ArrayList(), false)
                }

            })


        binding.etSearch.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {

            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {

            }

            override fun afterTextChanged(s: Editable?) {
                if (s.isNullOrEmpty()) {
                    searchKey = ""
                } else {
                    searchKey = s.toString()
                }
                startTimerTask()
            }
        })


        adapter = RubbingDevicesAdapter(this) {itemData,flagRubbingDone->

            val builder = AlertDialog.Builder(requireContext())
            builder.setTitle("Alert")
            if(flagRubbingDone){
                builder.setMessage(getString(R.string.rubbing_complete_alert) +"  ${itemData?.deviceBarcode?:""}.")
            }else{
                builder.setMessage(getString(R.string.rubbing_remove_alert) +"  ${itemData?.deviceBarcode?:""}.")
            }

            builder.setPositiveButton(getString(R.string.yes)) { dialog, which ->
                rubbingAction(itemData?.deviceBarcode?:"",flagRubbingDone)
            }
            builder.setNegativeButton(getString(R.string.no)) { dialog, which ->
                dialog.dismiss()
            }
            builder.show()
        }

        binding.recyclerView.layoutManager = LinearLayoutManager(activity)
        binding.recyclerView.adapter = adapter

    }

    fun startTimerTask() {

        timer?.cancel()
        timer = Timer()
        timer?.schedule(object : TimerTask() {
            override fun run() {
                Handler(Looper.getMainLooper()).post {
                    offsetCreated=0
                    activityViewModel.getRubbingDevicesList(offsetCreated,pageSize,searchKey)

                }
            }
        }, DELAY)
    }

    override fun hasMore(offset: Int) {
        if (offset <= 0) {
            return
        }
        this.offsetCreated++
        activityViewModel.getRubbingDevicesList(offset,pageSize,searchKey)
    }

    fun rubbingAction(barcode: String,flagRubbingDone:Boolean) {
        activityViewModel.doRubbingAction(barcode, flagRubbingDone,object : OnResult<RubbingDoneResponse> {
            override fun onResultAvailable(data: RubbingDoneResponse) {

                if (data.isSuccess) {
                    if(flagRubbingDone)
                       Toast.makeText(requireContext(),getString(R.string.rubbing_done_msg),Toast.LENGTH_LONG).show()
                    else
                        Toast.makeText(requireContext(),getString(R.string.rubbing_remove_msg),Toast.LENGTH_LONG).show()

                    Handler(Looper.getMainLooper()).postDelayed({
                        searchKey = ""
                        offsetCreated=0
                        activityViewModel.getRubbingDevicesList(offsetCreated,pageSize,searchKey)
                    }, 500)

                } else {
                    if(activity is BaseActivity) {
                        (activity as BaseActivity).showError(data.errorMsg)
                    }
                }
            }
        }, object : OnResult<Boolean> {
            override fun onResultAvailable(data: Boolean) {
            }
        })
    }

}