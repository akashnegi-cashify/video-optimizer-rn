package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentIMPartReturnBinding
import `in`.cashify.androidtrc.module.inventory_manager.adapter.IMReturnedPartsAdapter

import `in`.cashify.androidtrc.module.inventory_manager.fragment.return_parts.IMPartReturnDetailActivity
import android.content.Intent
import android.graphics.Color
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.TextWatcher
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ProgressBar
import android.widget.TextView
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import java.util.*


class IMPartListReturnFragment : BaseFragment() , SwipeRefreshLayout.OnRefreshListener{
    private var timer: Timer? = null
    var viewModel: InventoryManagerReturnViewModel? = null
    var binding: FragmentIMPartReturnBinding? = null

    var etSearch: TextView? = null
    var recycler: RecyclerView? = null
    var previous: TextView? = null
    var next: TextView? = null
    var progressBar: ProgressBar? = null

    var pageNo = 1
    var listNo = 10
    var br: String? = ""
    var tvCount: TextView? = null
    private var adapter: IMReturnedPartsAdapter? = null
    override fun onRefresh() {
        pageNo = 1
        binding?.swipeLayout?.setRefreshing(false)
        viewModel?.returnedPartList(pageNo, listNo, br)

    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        viewModel =
            getActivityViewModel(InventoryManagerReturnViewModel::class.java)

     binding = DataBindingUtil.inflate(inflater , R.layout.fragment_i_m_part_return, container, false)

        tvCount = binding?.tvCount


        viewModel?.returnedPartListResponse?.value = null
        viewModel?.returnedPartListResponseLoading?.value = false


      binding?.swipeLayout?.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
    binding?.swipeLayout?.setOnRefreshListener(this)

        viewModel?.returnedPartListResponseLoading?.observe(viewLifecycleOwner, Observer {
            if (it) {
                binding?.progressBar?.visibility = View.VISIBLE
            } else {
                binding?.progressBar?.visibility = View.GONE
            }
        })
setCount()
        viewModel?.returnedPartListResponse?.observe(viewLifecycleOwner, Observer {
            setCount()
            it?.let {



            if (pageNo >= it.data?.totalPage ?: 0) {

                binding?.tvNext?.setTextColor(resources.getColor(R.color.lightGrey))
            } else {
                binding?.tvNext?.setTextColor(resources.getColor(R.color.teal))
            }


            if (pageNo == 1) {
               binding?.tvPrevious?.setTextColor(resources.getColor(R.color.lightGrey))

            } else {
                binding?.tvPrevious?.setTextColor(resources.getColor(R.color.teal))
            }





            adapter?.setData(it.data?.partList)}

        })



        binding?.tvPrevious?.setOnClickListener {
            if(viewModel?.returnedPartListResponseLoading?.value?:false){
                return@setOnClickListener
            }
            if (pageNo > 1) {
                pageNo--
                viewModel?.returnedPartList(pageNo, listNo, br)
            }


        }



        binding?.tvNext?.setOnClickListener {
            if(viewModel?.returnedPartListResponseLoading?.value?:false){
                return@setOnClickListener
            }

            if (pageNo >= viewModel?.returnedPartListResponse?.value?.data?.totalPage ?: 0) {
                return@setOnClickListener
            }
            pageNo++
            viewModel?.returnedPartList(pageNo, listNo, br)


        }

        adapter = IMReturnedPartsAdapter {

            startActivity(Intent(activity, IMPartReturnDetailActivity::class.java).apply {

                putExtra("name" , it?.partName)
                putExtra("sku" , it?.sku)
                putExtra("barcode" , it?.partBarcode)
                putExtra("color" , it?.partColor)
                putExtra("prid", it?.prid)
            })


        }
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

                startTimerTask(pageNo , listNo , br?:"")


            }
        })






        return binding?.root
    }


    override fun onResume() {
        super.onResume()
        viewModel?.returnedPartList(pageNo, listNo, br)
    }



    fun startTimerTask(pno: Int, ln: Int, searchQuery: String) {
        timer?.cancel()
        timer = Timer()
        timer?.schedule(object : TimerTask() {
            override fun run() {
                Handler(Looper.getMainLooper()).post {
                    viewModel?.returnedPartList(pageNo, listNo, br)
                }

            }
        }, viewModel?.DELAY?:0L)
    }
    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMPartReturnFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMPartListReturnFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }





    var totalCount = 0
    var lastCount = 0
    var startingCount = 0

    private fun setCount() {

        totalCount = viewModel?.returnedPartListResponse?.value?.data?.totalRecord ?: 0
        if (totalCount == 0) {
            tvCount?.text = String.format(resources.getString(R.string.no_of_req), 0, 0, 0)
        }




        viewModel?.returnedPartListResponse?.value?.data?.let {
            if (it.partList == null || it.partList?.size == 0) {

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
            (startingCount + (viewModel?.returnedPartListResponse?.value?.data?.partList?.size ?: 0))-1
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
}