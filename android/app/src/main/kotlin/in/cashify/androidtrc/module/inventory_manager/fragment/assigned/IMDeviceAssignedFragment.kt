package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.module.inventory_manager.adapter.AssignDeviceListAdapter
import `in`.cashify.androidtrc.module.inventory_manager.adapter.RiderAdapter
import `in`.cashify.androidtrc.module.inventory_manager.api.response.AssignedDeviceListResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.RiderAssignResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.RiderListResponse
import `in`.cashify.androidtrc.module.inventory_manager.fragment.assigned.IMDeviceAssignedActivity
import android.annotation.SuppressLint
import android.app.Activity
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.CheckBox
import android.widget.ProgressBar
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.core.content.res.ResourcesCompat
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import de.keyboardsurfer.android.widget.crouton.Style
import java.util.*


class IMDeviceAssignedFragment : BaseFragment(), SwipeRefreshLayout.OnRefreshListener {

    var viewModel: InventoryManagerViewModel? = null
//    var binding: FragmentIMPendingPartDeliveryBinding? = null
private val START_ACTIVITY_REQUEST = 102
    private val SCAN_BARCODE_REQUEST = 101
    var etSearch: TextView? = null
    var recycler: RecyclerView? = null
    var previous: TextView? = null
    var next: TextView? = null
    var progressBar: ProgressBar? = null
    var assignRider: Button? = null
    var swipeLayout :SwipeRefreshLayout? = null
    var pageNo = 1
    var listNo = 10
    var br: String? = ""
    var timer: Timer? = null
    val DELAY: Long = 500 // in ms
    private var adapter: AssignDeviceListAdapter? = null
    var tvCount: TextView? = null
    private var scannerBarcode = ""
    private var isScan = false
    private var scannerPageNo = 1
    var checkboxUrgent : CheckBox? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }



    override fun onRefresh() {
        pageNo = 1
        swipeLayout?.setRefreshing(false)
        viewModel?.getAssignedDeviceList(pageNo, listNo, br , checkboxUrgent?.isChecked?:false, checkboxUrgent?.isChecked?:false)



    }

    @SuppressLint("ClickableViewAccessibility")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        viewModel =
            getActivityViewModel(InventoryManagerViewModel::class.java)

        val v = inflater.inflate(R.layout.fragment_i_m_device_assigned, container, false)
        etSearch = v.findViewById(R.id.et_search)
        tvCount = v.findViewById(R.id.tv_count)

        recycler = v.findViewById(R.id.recyclerView)
        previous = v.findViewById(R.id.tv_previous)
        next = v.findViewById(R.id.tv_next)
        progressBar = v.findViewById(R.id.progress_bar)
        assignRider = v.findViewById(R.id.btn_assign_rider)

        swipeLayout = v.findViewById(R.id.swipe_layout)
        swipeLayout?.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        swipeLayout?.setOnRefreshListener(this)
        viewModel?.assignedDeviceListResponse?.value = AssignedDeviceListResponse()
        viewModel?.assignedDeviceShowLoading?.value = false
        checkboxUrgent = v.findViewById(R.id.checkbox_urgent)
        checkboxUrgent?.setOnCheckedChangeListener { buttonView, isChecked ->
            pageNo = 1
            viewModel?.getAssignedDeviceList(pageNo, listNo, br , isChecked, checkboxUrgent?.isChecked?:false)





        }
viewModel?.refreshAssignDevice?.observe(viewLifecycleOwner, Observer {
    if(it) {
        viewModel?.getAssignedDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked?:false)
    }
})

        viewModel?.assignedDeviceShowLoading?.observe(viewLifecycleOwner, Observer {
            if (it) {
                progressBar?.visibility = View.VISIBLE
            } else {
                progressBar?.visibility = View.GONE
            }
        })
        setCount()
        viewModel?.assignedDeviceListResponse?.observe(viewLifecycleOwner, Observer {
            if(isScan){
                // called on first time when barcode is scanned

                isScan = false
                if(it.data!!.dataList == null || it.data?.dataList!!.size<=0){
                    return@Observer
                }

                else{
                    pageNo =  scannerPageNo
                    br = scannerBarcode
                    etSearch?.removeTextChangedListener(textWatcher)
                    etSearch?.setText(br)
                    etSearch?.addTextChangedListener(textWatcher)
                }
            }

            setCount()
            if (pageNo >= viewModel?.assignedDeviceListResponse?.value?.data?.totalPage ?: 0) {

                next?.setTextColor(resources.getColor(R.color.lightGrey))
            } else {
                next?.setTextColor(resources.getColor(R.color.teal))
            }


            if (pageNo == 1) {
                previous?.setTextColor(resources.getColor(R.color.lightGrey))

            } else {
                previous?.setTextColor(resources.getColor(R.color.teal))
            }





            adapter?.setData(it.data?.dataList)

        })



        previous?.setOnClickListener {
            if (pageNo > 1) {
                pageNo--
                viewModel?.getAssignedDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked?:false)
            }


        }



        next?.setOnClickListener {

            if (pageNo >= viewModel?.assignedDeviceListResponse?.value?.data?.totalPage ?: 0) {
                return@setOnClickListener
            }
            pageNo++
            viewModel?.getAssignedDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked?:false)


        }


        assignRider?.setOnClickListener {
            viewModel?.getListOfRiders(object : OnResult<RiderListResponse> {
                override fun onResultAvailable(data: RiderListResponse) {
                    showAssignRiderDialog(data)


                }

            }, "")

        }

        adapter = AssignDeviceListAdapter( ::assignRider , ::deviceClick)
        recycler?.layoutManager = LinearLayoutManager(activity)
        recycler?.adapter = adapter



        etSearch?.addTextChangedListener(textWatcher)
        etSearch?.setOnTouchListener { view, event ->
            if (event.getAction() == MotionEvent.ACTION_UP) {
                if (event.getRawX() >= ((etSearch?.getRight()
                        ?: 0) - (etSearch!!.getCompoundDrawables()[2].getBounds().width()))
                ) {
                    startActivityForResult(
                        Intent(
                            activity,
                            InventoryManagerScannerActivity::class.java
                        ), SCAN_BARCODE_REQUEST
                    )

                    return@setOnTouchListener true
                }
            }
            return@setOnTouchListener false

        }
        viewModel?.getAssignedDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked?:false)
        return v;


    }



    private val textWatcher = object : TextWatcher {
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

                timer?.cancel()
                timer = Timer()
                timer?.schedule(object : TimerTask() {
                    override fun run() {
                        Handler(Looper.getMainLooper()).post {
                            viewModel?.getAssignedDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked?:false)
                        }

                    }
                }, DELAY)



            }}

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMPartAssignedFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMDeviceAssignedFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }

    fun deviceClick(did: String) {
        val i = Intent(activity, IMDeviceAssignedActivity::class.java)
        i.putExtra("did", did)
        startActivity(i)


    }

    fun assignRider(isAssignRider: Boolean) {
        if (isAssignRider) {
            assignRider?.background = ResourcesCompat.getDrawable(
                resources,
                R.drawable.teal_bg_round_corner,
                null
            )
            assignRider?.isEnabled = true
        } else {
            assignRider?.background = ResourcesCompat.getDrawable(
                resources,
                R.drawable.dark_grey_bg_round_corner,
                null
            )
            assignRider?.isEnabled = false
        }
    }

    private fun showAssignRiderDialog(data: RiderListResponse) {

        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_assign_rider, null)
        var selectedRider: RiderListResponse.Data? = null
        var timer: Timer? = null



        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(true)


        val recyclerView = dialogView.findViewById(R.id.recyclerView) as RecyclerView
        val search = dialogView.findViewById(R.id.et_search) as TextView
        val assign = dialogView.findViewById(R.id.btn_assign_rider) as Button

        recyclerView.layoutManager = LinearLayoutManager(activity)
        val adapter = RiderAdapter(object : RiderAdapter.OnDeviceClickListener {
            override fun riderClick(data: RiderListResponse.Data?) {
                selectedRider = data
            }

        })

        adapter.setData(data.data)

        recyclerView.adapter = adapter


        val alertDialog = builder.create()
        assign.setOnClickListener {
            selectedRider?.let {
                viewModel?.assignRider(it.riderId, this.adapter?.selectedItemPos,
                    object : OnResult<RiderAssignResponse> {
                        override fun onResultAvailable(d: RiderAssignResponse) {

                            showRiderAssignSuccessDialog(selectedRider?.riderName ?: "")
                            alertDialog.dismiss()

                        }

                    })
            }?:mActivityHelper.showSnackBar(activity, resources.getString(R.string.plz_assign_rider), Style.ALERT, null)

        }


        search.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {

            }

            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) {

            }

            override fun afterTextChanged(s: Editable?) {
                timer?.cancel()
                s?.let {
                    selectedRider = null
                    timer = Timer()
                    timer?.schedule(object : TimerTask() {
                        override fun run() {
                            Handler(Looper.getMainLooper()).post {
                           val filterList =      data.data?.filter {

                                    it.riderName.toString().contains(s.toString(), true)

                                }
                                adapter.setData(filterList)
                            }



                        }
                    }, DELAY)

                }?:adapter.setData(data.data)



            }
        })


        alertDialog.show()
    }


    private fun showRiderAssignSuccessDialog(name: String) {

        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel_part_request, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.btn_no) as Button
        val yes = dialogView.findViewById(R.id.btn_yes) as Button
        val tv = dialogView.findViewById(R.id.tv) as TextView
        cancel.visibility = View.GONE
        yes.text = resources.getString(R.string.ok)

        tv.text = String.format(resources.getString(R.string.rider_assign_successfully), name)


        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        yes.setOnClickListener {
            viewModel?.getAssignedDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked?:false)
            alertDialog.dismiss()


        }



        alertDialog.show()
    }


    var totalCount = 0
    var lastCount = 0
    var startingCount = 0

    private fun setCount() {

        totalCount = viewModel?.assignedDeviceListResponse?.value?.data?.totalRecord ?: 0
        if (totalCount == 0) {
            tvCount?.text = String.format(resources.getString(R.string.no_of_req), 0, 0, 0)
        }




        viewModel?.assignedDeviceListResponse?.value?.data?.let {
            if (it.dataList == null || it.dataList?.size == 0) {

                if (pageNo == 1) {
                    startingCount = 0
                } else {
                    startingCount = ((pageNo - 1) * listNo) + 1


                }


            } else {
                startingCount = ((pageNo - 1) * listNo) + 1
            }

        }


        lastCount =
            (startingCount + (viewModel?.assignedDeviceListResponse?.value?.data?.dataList?.size ?: 0))-1
        if(lastCount<0){
            lastCount = 0
        }
        tvCount?.text = String.format(
            resources.getString(R.string.no_of_req),
            startingCount,
            lastCount,
            totalCount
        )


    }



    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == SCAN_BARCODE_REQUEST && resultCode == Activity.RESULT_OK) {
            scannerBarcode = data?.getStringExtra("barcode") ?: ""
            isScan = true
            scannerPageNo = 1
            viewModel?.getAssignedDeviceList(scannerPageNo, listNo, scannerBarcode, isScan, checkboxUrgent?.isChecked?:false)


        }


        else if(requestCode == START_ACTIVITY_REQUEST){
            viewModel?.getAssignedDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked?:false)

        }
    }


    override fun onResume() {
        super.onResume()
    }
}