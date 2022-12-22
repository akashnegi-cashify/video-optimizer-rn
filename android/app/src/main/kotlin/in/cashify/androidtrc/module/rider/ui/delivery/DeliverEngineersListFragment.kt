package `in`.cashify.androidtrc.module.rider.ui.delivery

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentRiderDeliveryDeliverBinding
import `in`.cashify.androidtrc.module.rider.adapter.RiderDeliveryDeliverAdapter
import `in`.cashify.androidtrc.module.rider.data.RiderActivityViewModel
import `in`.cashify.androidtrc.module.rider.data.response.DeliverEngineerListResponse
import `in`.cashify.androidtrc.util.Validation
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.TextUtils
import android.text.TextWatcher
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.recyclerview.widget.LinearLayoutManager
import java.util.*
import kotlin.collections.ArrayList


// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [RiderDeliveryDeliverFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class RiderDeliveryDeliverFragment : BaseFragment() {
    private var binding: FragmentRiderDeliveryDeliverBinding? = null
    var activityViewModel: RiderActivityViewModel? = null
    var timer: Timer? = null

    var offset = 0


    var listSize = 10
    var lastIndex = listSize
    var br: String? = ""
    private val DELAY: Long = 500 // in ms

    private var adapter: RiderDeliveryDeliverAdapter? = null


//    private var dataList: MutableList<DeliverEngineerListResponse.Data>? = null
//    private var filteredList: List<DeliverEngineerListResponse.Data>? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {

        }
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)


    }


    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        activityViewModel = getActivityViewModel(RiderActivityViewModel::class.java)

        // Inflate the layout for this fragment
        binding = DataBindingUtil.inflate(
            inflater, R.layout.fragment_rider_delivery_deliver, container, false
        )




        binding?.checkboxUrgent?.setOnCheckedChangeListener { buttonView, isChecked ->

            activityViewModel?.deliverEngineersList(isChecked)




        }
        activityViewModel?.deliveryEngineerListResponse?.value =
            null
        activityViewModel?.deliverEngineerLoading?.value = false

        activityViewModel?.deliverEngineerLoading?.observe(
            viewLifecycleOwner,
            androidx.lifecycle.Observer {
                if (it) {
                    binding?.progressBar?.visibility = View.VISIBLE
                } else {
                    binding?.progressBar?.visibility = View.GONE
                }
            })

        activityViewModel?.deliveryEngineerListResponse?.observe(
            viewLifecycleOwner, androidx.lifecycle.Observer {

                it?.let {
                    br = ""
                    binding?.etSearch?.setText("")
                    setList(it?.data)
                }


            })





        binding?.tvPrevious?.setOnClickListener {
            if ((activityViewModel?.deliveryEngineerListResponse?.value?.data?.size ?: 0) > listSize) {
                if (offset > 0) {
                    lastIndex = offset
                    offset = offset - listSize

                    adapter?.setData(activityViewModel?.deliveryEngineerListResponse?.value?.data?.subList(offset, lastIndex))


                    if (offset == 0) {
                        binding?.tvNext?.setTextColor(resources.getColor(R.color.teal))
                        binding?.tvPrevious?.setTextColor(resources.getColor(R.color.lightGrey))
                    } else {
                        binding?.tvNext?.setTextColor(resources.getColor(R.color.teal))
                        binding?.tvPrevious?.setTextColor(resources.getColor(R.color.teal))
                    }


                }

            }


        }



        binding?.tvNext?.setOnClickListener {
            if ((activityViewModel?.deliveryEngineerListResponse?.value?.data?.size ?: 0) > listSize) {
                if (lastIndex < (activityViewModel?.deliveryEngineerListResponse?.value?.data?.size ?: 0)) {
                    offset = lastIndex

                    lastIndex = lastIndex + Math.min(
                        listSize,
                        Math.abs((activityViewModel?.deliveryEngineerListResponse?.value?.data?.size ?: 0) - listSize)
                    )


                    adapter?.setData(activityViewModel?.deliveryEngineerListResponse?.value?.data?.subList(
                        offset,
                        lastIndex
                    ))

                    if (lastIndex >= (activityViewModel?.deliveryEngineerListResponse?.value?.data?.size ?: 0)) {
                        binding?.tvNext?.setTextColor(resources.getColor(R.color.lightGrey))
                        binding?.tvPrevious?.setTextColor(resources.getColor(R.color.teal))
                    } else {
                        binding?.tvNext?.setTextColor(resources.getColor(R.color.teal))
                        binding?.tvPrevious?.setTextColor(resources.getColor(R.color.teal))
                    }


                }



            }





        }




        adapter =
            RiderDeliveryDeliverAdapter(object : RiderDeliveryDeliverAdapter.OnPartClickListener {
                override fun partClick(data: DeliverEngineerListResponse.Data) {


                    startActivity(
                        Intent(
                            activity,
                            PendingPartsDelivertoEngineerActivity::class.java
                        ).apply {
                            putExtra("id", data?.id)
                            putExtra("name", data?.name)
                            putExtra("loc", data?.location)
                        })

                }
//                override fun partClick(list: ListReceivePendingPartResponse.Data.PartList) {
//
//                    selectedBarcode = list.partBarcode?:""
//                    showReceivePartAlertDialog(list.partId)
//                }


            })
        binding?.recyclerView?.layoutManager = LinearLayoutManager(activity)
        binding?.recyclerView?.adapter = adapter



        binding?.etSearch?.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {

            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {

            }

            override fun afterTextChanged(s: Editable?) {
                offset = 0
                lastIndex = listSize

                br = ""
                s?.let {
                    br = s.toString()


                }
                startTimerTask()

            }
        })


//        deliveryPendingResponse
        activityViewModel?.deliverEngineersList(binding?.checkboxUrgent?.isChecked?:false)

        return binding?.root
    }


    fun startTimerTask() {
        timer?.cancel()
        timer = Timer()
        timer?.schedule(object : TimerTask() {
            override fun run() {
                Handler(Looper.getMainLooper()).post {
                    if (TextUtils.isEmpty(br)) {


                        setList(activityViewModel?.deliveryEngineerListResponse?.value?.data?: ArrayList())

                    } else {



                    setList(
                            activityViewModel?.deliveryEngineerListResponse?.value?.data?.filter {
                                it.name.toString().contains(br.toString().toLowerCase(), true)
                            } as ArrayList<DeliverEngineerListResponse.Data>)
                    }




                }
//
            }
        }, DELAY)
    }

    override fun onResume() {
        super.onResume()

    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment RiderDeliveryDeliverFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            RiderDeliveryDeliverFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }


    private fun setList( list:ArrayList<DeliverEngineerListResponse.Data>?) {
        offset = 0
        lastIndex = listSize


        if ((list?.size ?: 0) > 10) {
            //  if list size is greater than 10 than use pagination locally

            adapter?.setData(list?.subList(
                offset,
                lastIndex
            ))

//                        offset = offset+(dataList?.size?:0)+1

            binding?.tvNext?.setTextColor(resources.getColor(R.color.teal))

            binding?.tvPrevious?.setTextColor(resources.getColor(R.color.lightGrey))


        } else {

            //if list size from api call is less than or equal to 10 than load whole list at once
            adapter?.setData(list)
            binding?.tvNext?.setTextColor(resources.getColor(R.color.lightGrey))
            binding?.tvPrevious?.setTextColor(resources.getColor(R.color.lightGrey))


        }




    }
}