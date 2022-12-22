package `in`.cashify.androidtrc.module.qc.ui

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentQCPendingBinding
import `in`.cashify.androidtrc.module.login.data.LoginViewModelV2
import `in`.cashify.androidtrc.module.qc.QCActivityViewModel
import `in`.cashify.androidtrc.module.qc.adapter.QCPendingAdapter
import `in`.cashify.androidtrc.module.qc.data.response.QCPendingListResponse
import android.content.Intent
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager


class QCPendingFragment : BaseFragment() {
    private var activityViewModel: QCActivityViewModel? = null
    private var binding: FragmentQCPendingBinding? = null
    var adapter: QCPendingAdapter? = null
    var response:QCPendingListResponse?=null

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
        binding?.viewModel = activityViewModel

        binding?.lifecycleOwner = viewLifecycleOwner
        adapter = QCPendingAdapter(object :
         QCPendingAdapter.PendingPartClickListener {
            override fun pendingPartClick(pos: Int) {
                startActivity(Intent(activity, QCPendingPartDetailsActivity::class.java).apply {
                    putExtra("data", response?.data?.get(pos))

                })
            }

        })
        binding?.recyclerView?.layoutManager = LinearLayoutManager(activity)
        binding?.recyclerView?.adapter = adapter

activityViewModel?.pendingPartLoading?.observe(viewLifecycleOwner , Observer {
    if(it){
        binding?.progressBar?.visibility = View.VISIBLE
    }

    else{
        binding?.progressBar?.visibility = View.GONE
    }


})


    }


    override fun onResume() {
        super.onResume()
        activityViewModel?.getPendingPartList("", object :
            OnResult<QCPendingListResponse> {
            override fun onResultAvailable(data: QCPendingListResponse) {
                adapter?.setData(data?.data ?: ArrayList())
                response = data
            }

        })
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_q_c_pending, container, false)
        return binding?.root
    }

    companion object {

        @JvmStatic
        fun newInstance() =
            QCPendingFragment().apply {
                arguments = Bundle().apply {

                }
            }
    }
}