package `in`.cashify.androidtrc.module.inventory_manager.fragment.pending

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerPendingPartViewModel
import `in`.cashify.androidtrc.module.inventory_manager.adapter.PendingDevicePartAdapter
import `in`.cashify.androidtrc.module.inventory_manager.api.PartStatus
import android.content.DialogInterface
import android.graphics.Color
import android.os.Bundle
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.MotionEvent
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.*
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_barcode
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_engineer_name
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_location
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_assigned_grade
import kotlinx.android.synthetic.main.fragment_i_m_pending_device_details.view.tv_assigned_repair_type
import kotlinx.android.synthetic.main.row_assign_device.view.*


/**
 * A simple [Fragment] subclass.
 * Use the [IMPendingDevicePartDetails.newInstance] factory method to
 * create an instance of this fragment.
 */
class IMPendingDeviceDetailsFragment : BaseFragment() , SwipeRefreshLayout.OnRefreshListener{


    var pendingPartViewModel: InventoryManagerPendingPartViewModel? = null
    var adapter: PendingDevicePartAdapter? = null
    var swipeRefreshLayout:SwipeRefreshLayout? = null
    var recyclerView:RecyclerView? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


    }

    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        val v = inflater.inflate(R.layout.fragment_i_m_pending_device_details, container, false)
        pendingPartViewModel =
            getActivityViewModel(InventoryManagerPendingPartViewModel::class.java)

        pendingPartViewModel?.pendindDeviceDetailResponse?.value = null
        pendingPartViewModel?.pendingDevicePartResponse?.value = null

        pendingPartViewModel?.pendimgPartLoadingFail?.value = null


        pendingPartViewModel?.pendimgPartLoadingFail?.observe(viewLifecycleOwner, Observer {
            it?.let {
                showDialogBar(
                    "",
                    resources?.getString(R.string.ok),
                    (activity as BaseActivity).getErrorMsg(it),
                    object : DialogInterface.OnClickListener {
                        override fun onClick(dialog: DialogInterface?, which: Int) {
                            dialog?.dismiss()
                            activity?.finish()
                        }

                    })
            }

        })

        pendingPartViewModel?.pendindDeviceDetailResponse?.observe(viewLifecycleOwner, Observer {
            v.tv_barcode?.text = it?.data?.dbr
            v.tv_device_name?.text = it?.data?.pt
            v?.tv_location?.text = it?.data?.lc
            v?.tv_engineer_name?.text = it?.data?.en

            v?.tv_assigned_repair_type?.text = it?.data?.repairType
            v?.tv_assigned_grade?.text = it?.data?.grade

        })
        adapter = PendingDevicePartAdapter(object :
            PendingDevicePartAdapter.OnPartClickListener {
            override fun partClick(prid: Int, partStatus: PartStatus) {
                pendingPartViewModel?.prid = prid
                pendingPartViewModel?.partStatus = partStatus



                mActivityHelper.replaceFragmentWithTag(
                    activity!!,
                    IMPendingDevicePartDetailsFragment.newInstance(),
                    R.id.container,
                    true, IMPendingDevicePartDetailsFragment.TAG

                )

            }

        })

        recyclerView = v.findViewById(R.id.recyclerView)
        recyclerView?.layoutManager = LinearLayoutManager(activity)
        recyclerView?.adapter = adapter


        swipeRefreshLayout = v.findViewById(R.id.swipe_layout)
        swipeRefreshLayout?.setColorSchemeColors(Color.RED, Color.GREEN, Color.BLUE, Color.YELLOW)
        swipeRefreshLayout?.setOnRefreshListener(this)

        recyclerView?.setOnTouchListener(object : View.OnTouchListener {
            override fun onTouch(v: View?, event: MotionEvent?): Boolean {

                when (event?.getAction()) {
                    MotionEvent.ACTION_MOVE -> swipeRefreshLayout?.setEnabled(false)
                    MotionEvent.ACTION_UP, MotionEvent.ACTION_CANCEL -> swipeRefreshLayout?.setEnabled(true)
                }

                return false
            }

        })

        pendingPartViewModel?.pendingDevicePartResponse?.observe(viewLifecycleOwner, Observer {
            it?.let {
                if(it?.data == null || it?.data?.size == 0){
                    showDialogBar(
                        "",
                        resources?.getString(R.string.ok),
                        resources?.getString(R.string.no_parts_present),
                        object : DialogInterface.OnClickListener {
                            override fun onClick(dialog: DialogInterface?, which: Int) {
                                dialog?.dismiss()
                                activity?.finish()
                            }

                        })
                }

                else {
                    adapter?.setData(it.data)
                }
            }


        })
        pendingPartViewModel?.getPendingDeviceDetail()

        return v;
    }


    override fun onResume() {
        super.onResume()
        pendingPartViewModel?.getPendingDevicePartList(true)




    }

    companion object {
        /**
         * Use this factory method to create a new instance of
         * this fragment using the provided parameters.
         *
         * @param param1 Parameter 1.
         * @param param2 Parameter 2.
         * @return A new instance of fragment IMPendingDevicePartDetails.
         */
        // TODO: Rename and change types and number of parameters
        @JvmStatic
        fun newInstance(did: String) =
            IMPendingDeviceDetailsFragment().apply {
                arguments = Bundle().apply {
                    putString("did", did)
                }
            }
    }

    override fun onRefresh() {
        swipeRefreshLayout?.setRefreshing(false)
        pendingPartViewModel?.getPendingDevicePartList(true)

    }


}