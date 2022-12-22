package `in`.cashify.androidtrc.module.inventory_manager.fragment.pending

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerActivity
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerViewModel
import `in`.cashify.androidtrc.module.inventory_manager.InventoryRequestsActivity
import `in`.cashify.androidtrc.module.inventory_manager.adapter.EngineersAdapter
import android.annotation.SuppressLint
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import android.widget.ProgressBar
import android.widget.TextView
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import java.util.*

class IMPendingEngineersFragment : BaseFragment(), SwipeRefreshLayout.OnRefreshListener {
    var viewModel: InventoryManagerViewModel? = null
    var recycler: RecyclerView? = null
    var previous: TextView? = null
    var next: TextView? = null
    var progressBar: ProgressBar? = null
    var tvCount: TextView? = null
    var swipeLayout: SwipeRefreshLayout? = null
    var pageNo = 1
    var listNo = 10
    var br: String? = ""
    private var engineeerAdapter: EngineersAdapter? = null


    override fun onRefresh() {
        pageNo = 1
        swipeLayout?.isRefreshing = false
        viewModel?.engineerList(pageNo, listNo)
    }

    @SuppressLint("ClickableViewAccessibility")
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        viewModel = getActivityViewModel(InventoryManagerViewModel::class.java)
        val v = inflater.inflate(R.layout.fragment_i_m_pending_engineers, container, false)
        swipeLayout = v.findViewById(R.id.swipe_layout)
        recycler = v.findViewById(R.id.recyclerView)
        previous = v.findViewById(R.id.tv_previous)
        next = v.findViewById(R.id.tv_next)
        progressBar = v.findViewById(R.id.progress_bar)
        tvCount = v.findViewById(R.id.tv_count)
        swipeLayout?.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        swipeLayout?.setOnRefreshListener(this)
        setCount()
        viewModel?.engineerListResponse?.observe(viewLifecycleOwner, {
            setCount()

            if (pageNo >= viewModel?.engineerListResponse?.value?.data?.totalPage ?: 0) {

                next?.setTextColor(resources.getColor(R.color.lightGrey))
            } else {
                next?.setTextColor(resources.getColor(R.color.teal))
            }


            if (pageNo == 1) {
                previous?.setTextColor(resources.getColor(R.color.lightGrey))

            } else {
                previous?.setTextColor(resources.getColor(R.color.teal))
            }

            engineeerAdapter?.startingCount = startingCount
            engineeerAdapter?.setData(it.data?.dataList)

        })
        viewModel?.pendingEngineerShowLoading?.observe(
            viewLifecycleOwner,
            {
                if (it) {
                    progressBar?.visibility = View.VISIBLE
                } else {
                    progressBar?.visibility = View.GONE
                }
            })


        previous?.setOnClickListener {
            if (pageNo > 1) {
                pageNo--
                viewModel?.engineerList(pageNo, listNo)
            }
        }

        next?.setOnClickListener {
            if (pageNo >= viewModel?.engineerListResponse?.value?.data?.totalPage ?: 0) {
                return@setOnClickListener
            }
            pageNo++
            viewModel?.engineerList(pageNo, listNo)
        }

        engineeerAdapter = EngineersAdapter(object : EngineersAdapter.OnEngineerClickListener {
            override fun engineerClick(id: Int) {
                val i = Intent(activity, InventoryRequestsActivity::class.java)
                i.putExtra(IMPendingPartDeliveryFragment.ENG_ID, id)
                startActivity(i)
            }
        })

        recycler?.layoutManager = LinearLayoutManager(activity)
        recycler?.adapter = engineeerAdapter
        viewModel?.engineerList(pageNo, listNo)
        v.findViewById<LinearLayout>(R.id.lay_edit).setOnClickListener {
            if (activity != null && activity is InventoryManagerActivity) {
                (requireActivity() as InventoryManagerActivity).groupListDialog {
                    pageNo = 1
                    viewModel?.engineerList(pageNo, listNo)
                }
            }
        }
        return v;
    }


    companion object {
        @JvmStatic
        fun newInstance() =
            IMPendingEngineersFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }

    var totalCount = 0
    var lastCount = 0
    var startingCount = 0

    private fun setCount() {
        totalCount = viewModel?.engineerListResponse?.value?.data?.totalRecord ?: 0
        if (totalCount == 0) {
            tvCount?.text = String.format(resources.getString(R.string.no_of_req), 0, 0, 0)
        }




        viewModel?.engineerListResponse?.value?.data?.let {
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
            (startingCount + (viewModel?.engineerListResponse?.value?.data?.dataList?.size
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

}