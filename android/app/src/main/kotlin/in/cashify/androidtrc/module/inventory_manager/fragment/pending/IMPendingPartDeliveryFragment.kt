package `in`.cashify.androidtrc.module.inventory_manager.fragment.pending


import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerActivity
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerScannerActivity
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerViewModel
import `in`.cashify.androidtrc.module.inventory_manager.adapter.PendingDeviceAdapter
import `in`.cashify.androidtrc.module.inventory_manager.api.response.PendingDeviceListResponse
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
import android.widget.*
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import kotlinx.android.synthetic.main.fragment_detail_selection.*
import kotlinx.android.synthetic.main.fragment_i_m_pending_part_delivery.*
import java.util.*


class IMPendingPartDeliveryFragment : BaseFragment(), SwipeRefreshLayout.OnRefreshListener {

    private val START_ACTIVITY_REQUEST = 102
    private val SCAN_BARCODE_REQUEST = 101
    private var timer: Timer? = null
    var viewModel: InventoryManagerViewModel? = null
    var etSearch: TextView? = null
    var recycler: RecyclerView? = null
    var previous: TextView? = null
    var next: TextView? = null
    var progressBar: ProgressBar? = null
    var tvCount: TextView? = null
    var checkboxUrgent: CheckBox? = null
    var swipeLayout: SwipeRefreshLayout? = null
    var pageNo = 1
    var listNo = 10
    var br: String? = ""
    private var scannerBarcode = ""
    private var isScan = false
    private var scannerPageNo = 1
    private var adapter: PendingDeviceAdapter? = null
    private var eng_id: Int? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        eng_id = arguments?.getInt(ENG_ID)
    }


    override fun onRefresh() {
        pageNo = 1
        swipeLayout?.setRefreshing(false)
        viewModel?.getPendingDeviceList(
            pageNo,
            listNo,
            br,
            checkboxUrgent?.isChecked ?: false,
            e_id = eng_id
        )


    }

    @SuppressLint("ClickableViewAccessibility")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        viewModel =
            getActivityViewModel(InventoryManagerViewModel::class.java)

        val v = inflater.inflate(R.layout.fragment_i_m_pending_part_delivery, container, false)
        etSearch = v.findViewById(R.id.et_search)
        swipeLayout = v.findViewById(R.id.swipe_layout)

        recycler = v.findViewById(R.id.recyclerView)
        previous = v.findViewById(R.id.tv_previous)
        next = v.findViewById(R.id.tv_next)
        progressBar = v.findViewById(R.id.progress_bar)
        tvCount = v.findViewById(R.id.tv_count)
        swipeLayout?.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        swipeLayout?.setOnRefreshListener(this)



        viewModel?.pendindDeviceListResponse?.value = PendingDeviceListResponse()
        viewModel?.pendingDeviceShowLoading?.value = false
        checkboxUrgent = v.findViewById(R.id.checkbox_urgent)
        checkboxUrgent?.setOnCheckedChangeListener { buttonView, isChecked ->
            pageNo = 1
            viewModel?.getPendingDeviceList(pageNo, listNo, br, isChecked,e_id = eng_id)


        }

        viewModel?.pendingDeviceShowLoading?.observe(viewLifecycleOwner, Observer {
            if (it) {
                progressBar?.visibility = View.VISIBLE
            } else {
                progressBar?.visibility = View.GONE
            }
        })


        setCount()

        viewModel?.pendindDeviceListResponse?.observe(viewLifecycleOwner, Observer {

            if (isScan) {
                // called on first time when barcode is scanned

                isScan = false
                if (it.data!!.dataList == null || it.data?.dataList!!.size <= 0) {
                    return@Observer
                } else {
                    pageNo = scannerPageNo
                    br = scannerBarcode
                    etSearch?.removeTextChangedListener(textWatcher)
                    etSearch?.setText(br)
                    etSearch?.addTextChangedListener(textWatcher)
                }
            }

            setCount()




            if (pageNo >= viewModel?.pendindDeviceListResponse?.value?.data?.totalPage ?: 0) {

                next?.setTextColor(resources.getColor(R.color.lightGrey))
            } else {
                next?.setTextColor(resources.getColor(R.color.teal))
            }


            if (pageNo == 1) {
                previous?.setTextColor(resources.getColor(R.color.lightGrey))

            } else {
                previous?.setTextColor(resources.getColor(R.color.teal))
            }




            adapter?.startingCount = startingCount
            adapter?.setData(it.data?.dataList)

        })



        previous?.setOnClickListener {
            if (pageNo > 1) {
                pageNo--
                viewModel?.getPendingDeviceList(
                    pageNo,
                    listNo,
                    br,
                    checkboxUrgent?.isChecked ?: false,e_id = eng_id
                )
            }


        }



        next?.setOnClickListener {

            if (pageNo >= viewModel?.pendindDeviceListResponse?.value?.data?.totalPage ?: 0) {
                return@setOnClickListener
            }
            pageNo++
            viewModel?.getPendingDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked ?: false,e_id = eng_id)


        }

        adapter = PendingDeviceAdapter(object : PendingDeviceAdapter.OnDeviceClickListener {
            override fun deviceClick(did: String) {
                val i = Intent(activity, InventoryManagerPendingPartActivity::class.java)
                i.putExtra("did", did)
                startActivityForResult(i, START_ACTIVITY_REQUEST)


            }

        })
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


        viewModel?.getPendingDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked ?: false,e_id = eng_id)


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
            startTimerTask(pageNo, listNo, br ?: "")
        }
    }


    fun startTimerTask(pno: Int, ln: Int, searchQuery: String) {
        timer?.cancel()
        timer = Timer()
        timer?.schedule(object : TimerTask() {
            override fun run() {
                Handler(Looper.getMainLooper()).post {
                    viewModel?.getPendingDeviceList(
                        pno,
                        ln,
                        searchQuery,
                        checkboxUrgent?.isChecked ?: false,e_id = eng_id
                    )
                }

            }
        }, viewModel?.DELAY ?: 0L)
    }

    override fun onResume() {
        super.onResume()

    }

    companion object {
        const val ENG_ID = "eng_id"

        @JvmStatic
        fun newInstance(
            intExtra: Int
        ): IMPendingPartDeliveryFragment {
            val args = Bundle()
            args.putInt(ENG_ID, intExtra)
            val fragment = IMPendingPartDeliveryFragment()
            fragment.arguments = args
            return fragment
        }
    }

    var totalCount = 0
    var lastCount = 0
    var startingCount = 0

    private fun setCount() {

        totalCount = viewModel?.pendindDeviceListResponse?.value?.data?.totalRecord ?: 0
        if (totalCount == 0) {
            tvCount?.text = String.format(resources.getString(R.string.no_of_req), 0, 0, 0)
        }




        viewModel?.pendindDeviceListResponse?.value?.data?.let {
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
            (startingCount + (viewModel?.pendindDeviceListResponse?.value?.data?.dataList?.size
                ?: 0)) - 1
        if (lastCount < 0) {
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
            viewModel?.getPendingDeviceList(
                scannerPageNo,
                listNo,
                scannerBarcode,
                checkboxUrgent?.isChecked ?: false,
                isScan,e_id = eng_id
            )


        } else if (requestCode == START_ACTIVITY_REQUEST) {
            viewModel?.getPendingDeviceList(pageNo, listNo, br, checkboxUrgent?.isChecked ?: false,e_id = eng_id)
            viewModel?.refreshAssignDevice?.value = true
        }
    }
}