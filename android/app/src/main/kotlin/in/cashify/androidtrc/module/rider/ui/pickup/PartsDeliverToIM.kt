package `in`.cashify.androidtrc.module.rider.ui.pickup

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentPartsFromImBinding
import `in`.cashify.androidtrc.databinding.PartsDeliverToImBinding
import `in`.cashify.androidtrc.module.rider.adapter.DeliverInventoryManagerPartAdapter
import `in`.cashify.androidtrc.module.rider.adapter.RiderDeliveryReceiveAdapter
import `in`.cashify.androidtrc.module.rider.data.RiderActivityViewModel
import `in`.cashify.androidtrc.module.rider.data.response.IMPartListResponse
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import java.util.*


// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [RiderPickupDeliverFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class PartsDeliverToIM  : BaseFragment() {

    private var binding: PartsDeliverToImBinding? = null
    var activityViewModel: RiderActivityViewModel? = null
    var timer: Timer? = null

    var pageNo = 1
    var listNo = 10
    var br: String? = ""
    private val DELAY: Long = 500 // in ms


    private var selectedBarcode = ""

    private var adapter: DeliverInventoryManagerPartAdapter? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {

        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        activityViewModel = getActivityViewModel(RiderActivityViewModel::class.java)

        // Inflate the layout for this fragment
        binding = DataBindingUtil.inflate(
            inflater,R.layout.parts_deliver_to_im, container, false)


        activityViewModel?.partsListDeliverToIMResponse?.value =
         null
        activityViewModel?.partsListDeliverToIMLoading?.value = false


        activityViewModel?.partsListDeliverToIMLoading?.observe(viewLifecycleOwner, androidx.lifecycle.Observer {
            if (it) {
                binding?.progressBar?.visibility = View.VISIBLE
            } else {
                binding?.progressBar?.visibility = View.GONE
            }

        })


        activityViewModel?.partsListDeliverToIMResponse?.observe(viewLifecycleOwner, androidx.lifecycle.Observer {

            it?.let {


                if (pageNo >= activityViewModel?.partsListDeliverToIMResponse?.value?.data?.totalPage ?: 0) {

                    binding?.tvNext?.setTextColor(resources.getColor(R.color.lightGrey))
                } else {
                    binding?.tvNext?.setTextColor(resources.getColor(R.color.teal))
                }


                if (pageNo == 1) {
                    binding?.tvPrevious?.setTextColor(resources.getColor(R.color.lightGrey))

                } else {
                    binding?.tvPrevious?.setTextColor(resources.getColor(R.color.teal))
                }





                adapter?.setData(it.data?.partList)
            }

        })


        binding?.tvPrevious?.setOnClickListener {
            if (pageNo > 1) {
                pageNo--
                activityViewModel?.partsDeliverToIM(pageNo, listNo, br)
            }


        }



        binding?.tvNext?.setOnClickListener {

            if (pageNo >= activityViewModel?.partsListDeliverToIMResponse?.value?.data?.totalPage ?: 0) {
                return@setOnClickListener
            }
            pageNo++
            activityViewModel?.partsDeliverToIM(pageNo, listNo, br)


        }



        adapter =
            DeliverInventoryManagerPartAdapter(object : DeliverInventoryManagerPartAdapter.OnPartClickListener {
                override fun partClick(list: IMPartListResponse.Data.PartList) {

                    selectedBarcode = list.partBarcode?:""

                }


            })
        binding?.recyclerView?.layoutManager = LinearLayoutManager(activity)
        binding?.recyclerView?.adapter = adapter

        binding?.etSearch?.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {

            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {

            }

            override fun afterTextChanged(s: Editable?) {
                pageNo = 1
                br = ""
                s?.let {
                    br = s.toString()


                }
                startTimerTask()

            }
        })

        return binding?.root

    }


    override fun onResume() {
        super.onResume()
        activityViewModel?.partsDeliverToIM(pageNo, listNo, br)
    }
    fun startTimerTask() {
        timer?.cancel()
        timer = Timer()
        timer?.schedule(object : TimerTask() {
            override fun run() {
                Handler(Looper.getMainLooper()).post {
                    activityViewModel?.partsDeliverToIM(pageNo, listNo, br)
                }

            }
        }, DELAY)
    }


    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment RiderPickupDeliverFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            PartsDeliverToIM().apply {
                arguments = Bundle().apply {

                }
            }
    }
}