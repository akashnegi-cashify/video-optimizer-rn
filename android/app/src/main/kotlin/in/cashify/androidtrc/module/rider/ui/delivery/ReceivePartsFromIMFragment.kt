package `in`.cashify.androidtrc.module.rider.ui.delivery

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentPartsFromImBinding

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
import android.widget.CheckBox
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import java.util.*


// TODO: Rename parameter arguments, choose names that match
// the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
private const val ARG_PARAM1 = "param1"
private const val ARG_PARAM2 = "param2"

/**
 * A simple [Fragment] subclass.
 * Use the [RiderDeliveryReceiveFragment.newInstance] factory method to
 * create an instance of this fragment.
 */
class RiderDeliveryReceiveFragment : BaseFragment() {

    private var binding: FragmentPartsFromImBinding? = null
    var activityViewModel: RiderActivityViewModel? = null
    var timer: Timer? = null

    var pageNo = 1
    var listNo = 10
    var br: String? = ""
    private val DELAY: Long = 500 // in ms


    private var selectedBarcode = ""

    private var adapter: RiderDeliveryReceiveAdapter? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)



    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment


        activityViewModel = getActivityViewModel(RiderActivityViewModel::class.java)


        binding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_parts_from_im,
            container,
            false
        )
        activityViewModel?.listReceivePartsFromIMResponse?.value =
          null
        activityViewModel?.partsRecieveFromIMLoading?.value = false


        binding?.checkboxUrgent?.setOnCheckedChangeListener { buttonView, isChecked ->
            pageNo = 1
            activityViewModel?.listReceivePartsFromIm(pageNo, listNo, br, isChecked)




        }

        activityViewModel?.partsRecieveFromIMLoading?.observe(
            viewLifecycleOwner,
            Observer {
                if (it) {
                    binding?.progressBar?.visibility = View.VISIBLE
                } else {
                    binding?.progressBar?.visibility = View.GONE
                }
            })

        activityViewModel?.recievePartFromIMResponse?.value = null

        activityViewModel?.recievePartFromIMResponse?.observe(viewLifecycleOwner, Observer {
            it?.let {

                showReceiveSuccessDialog()

            }
        })

        activityViewModel?.listReceivePartsFromIMResponse?.observe(viewLifecycleOwner, Observer {

            it?.let {


                if (pageNo >= activityViewModel?.listReceivePartsFromIMResponse?.value?.data?.totalPage ?: 0) {

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
                activityViewModel?.listReceivePartsFromIm(pageNo, listNo, br, binding?.checkboxUrgent?.isChecked?:false)

            }


        }



       binding?.tvNext?.setOnClickListener {

            if (pageNo >= activityViewModel?.listReceivePartsFromIMResponse?.value?.data?.totalPage ?: 0) {
                return@setOnClickListener
            }
            pageNo++
           activityViewModel?.listReceivePartsFromIm(pageNo, listNo, br, binding?.checkboxUrgent?.isChecked?:false)


       }

        adapter =
            RiderDeliveryReceiveAdapter(object : RiderDeliveryReceiveAdapter.OnPartClickListener {
                override fun partClick(list: IMPartListResponse.Data.PartList) {

                    selectedBarcode = list.partBarcode?:""
                    showReceivePartAlertDialog(list.partId)
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
        activityViewModel?.listReceivePartsFromIm(pageNo, listNo, br, binding?.checkboxUrgent?.isChecked?:false)
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment RiderDeliveryReceiveFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(param1: String, param2: String) =
            RiderDeliveryReceiveFragment().apply {
                arguments = Bundle().apply {
                    putString(ARG_PARAM1, param1)
                    putString(ARG_PARAM2, param2)
                }
            }
    }


    fun startTimerTask() {
        timer?.cancel()
        timer = Timer()
        timer?.schedule(object : TimerTask() {
            override fun run() {
                Handler(Looper.getMainLooper()).post {
                    activityViewModel?.listReceivePartsFromIm(pageNo, listNo, br, binding?.checkboxUrgent?.isChecked?:false)
                }

            }
        }, DELAY)
    }


    fun showReceivePartAlertDialog(partId: Int?) {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_rider, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val left = dialogView.findViewById(R.id.btn_left) as TextView
        val right = dialogView.findViewById(R.id.btn_right) as TextView
        val txt = dialogView.findViewById(R.id.tv) as TextView


        right.text = resources.getString(R.string.confirm)
        left.text = resources.getString(R.string.cancel)

        txt.text = String.format(resources.getString(R.string.click_on_confirm_to_receive))

        val alertDialog = builder.create()
        left.setOnClickListener {
            alertDialog.dismiss()
        }
        right.setOnClickListener {
            activityViewModel?.receivePartFromIM(partId)

            alertDialog.dismiss()


        }

        alertDialog.show()


    }
    fun showReceiveSuccessDialog() {


        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_rider, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val left = dialogView.findViewById(R.id.btn_left) as TextView
        val right = dialogView.findViewById(R.id.btn_right) as TextView
        val txt = dialogView.findViewById(R.id.tv) as TextView

        left.visibility = View.GONE


        right.text = resources.getString(R.string.ok)
//        left.text = resources.getString(R.string.cancel)

        txt.text = String.format(resources.getString(R.string.part_successfully_received) , selectedBarcode)

        val alertDialog = builder.create()
        left.setOnClickListener {
            alertDialog.dismiss()
        }
        right.setOnClickListener {
pageNo = 1
            activityViewModel?.listReceivePartsFromIm(pageNo, listNo, br, binding?.checkboxUrgent?.isChecked?:false)
            alertDialog.dismiss()


        }

        alertDialog.show()


    }





}