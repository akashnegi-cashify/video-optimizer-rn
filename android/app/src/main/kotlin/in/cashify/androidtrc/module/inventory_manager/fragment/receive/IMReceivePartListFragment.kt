package `in`.cashify.androidtrc.module.inventory_manager.fragment.receive

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentIMReceivePartListBinding
import `in`.cashify.androidtrc.module.inventory_manager.IMReceiveScanActivityViewModel
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerPendingPartViewModel
import `in`.cashify.androidtrc.module.inventory_manager.adapter.IMReceivePartListAdaoter
import `in`.cashify.androidtrc.module.inventory_manager.api.response.ListReceivePendingPartResponse
import `in`.cashify.androidtrc.module.inventory_manager.api.response.UpdateReceivePartResponse
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager


class IMReceivePartListFragment : BaseFragment() {
    // TODO: Rename and change types of parameters
    private var param1: String? = null
    private var param2: String? = null
    var binding: FragmentIMReceivePartListBinding? = null
    var viewModel: IMReceiveScanActivityViewModel? = null
    var adapter: IMReceivePartListAdaoter? = null
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        arguments?.let {

        }
    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Inflate the layout for this fragment
        binding = DataBindingUtil.inflate(
            inflater,
            R.layout.fragment_i_m_receive_part_list,
            container,
            false
        )


        viewModel = getActivityViewModel(IMReceiveScanActivityViewModel::class.java)

        binding?.recyclerView?.layoutManager = LinearLayoutManager(activity)
        adapter = IMReceivePartListAdaoter(this::receiveClick)
        binding?.recyclerView?.adapter = adapter
  adapter?.setData(viewModel?.receivePArtListResponse?.data)
        binding?.back?.setOnClickListener {
            activity?.supportFragmentManager?.popBackStack()
        }



        return binding?.root
    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMReceivePartListFragment.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance() =
            IMReceivePartListFragment().apply {

            }
    }


    fun receiveClick(data: ListReceivePendingPartResponse.Data?) {
        data?.let {

            viewModel?.partID = it?.prid
            viewModel?.receivePart(object : OnResult<UpdateReceivePartResponse?> {


                override fun onResultAvailable(data: UpdateReceivePartResponse?) {
                    receiveSuccessfulDialog()
                }

            })

        }
    }


    private fun receiveSuccessfulDialog() {

        val inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_im_receive, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val right = dialogView.findViewById(R.id.btn_right) as Button
        val left = dialogView.findViewById(R.id.btn_left) as Button
        right.visibility = View.GONE
        val tv = dialogView.findViewById(R.id.tv) as TextView

        left.text = resources.getString(R.string.ok)

        tv.text = String.format(
            resources.getString(R.string.barcode_successfully_received),
            viewModel?.partBarcode
        )


        val alertDialog = builder.create()

        left.setOnClickListener {

            viewModel?.receivePartList(object : OnResult<ListReceivePendingPartResponse?> {
                override fun onResultAvailable(data: ListReceivePendingPartResponse?) {
                    data?.let {
                        adapter?.setData(it?.data)


                    }
                }

            })
            alertDialog.dismiss()


        }



        alertDialog.show()
    }
}