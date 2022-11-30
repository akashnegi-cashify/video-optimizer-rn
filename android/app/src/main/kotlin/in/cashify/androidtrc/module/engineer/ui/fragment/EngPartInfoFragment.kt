package `in`.cashify.androidtrc.module.engineer.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentEngPartBinding
import `in`.cashify.androidtrc.module.engineer.adapter.EngPartInfoAdapter
import `in`.cashify.androidtrc.module.engineer.api.response.CancelPartResponse
import `in`.cashify.androidtrc.module.engineer.api.response.EngineerPartInfo
import `in`.cashify.androidtrc.module.engineer.data.EngPartsViewModel
import `in`.cashify.androidtrc.util.CommonConstant
import android.content.DialogInterface
import android.os.Bundle
import android.text.TextUtils
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.ImageView
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
class EngPartInfoFragment : BaseFragment() , EngPartInfoAdapter.CancelLitener{

    private var mPartList: ArrayList<EngineerPartInfo>? = null
    private var status: String? = null
    lateinit var binding: FragmentEngPartBinding
    var partInfoAdapter: EngPartInfoAdapter? = null

    companion object {
        private const val KEY_PART_INFO_LIST = "key_part_list"
        private const val KEY_STATUS = "key_status"

        fun newInstance(
            deviceList: ArrayList<EngineerPartInfo>?,
            status: String
        ): EngPartInfoFragment {
            val args = Bundle()
            args.putParcelableArrayList(KEY_PART_INFO_LIST, deviceList)
            args.putString(KEY_STATUS, status)
            val fragment = EngPartInfoFragment()
            fragment.arguments = args
            return fragment
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        mPartList = arguments?.getParcelableArrayList(KEY_PART_INFO_LIST)
        status = arguments?.getString(KEY_STATUS)
//        mIsPending = arguments?.getBoolean(DeviceAllocatedFragment.KEY_IS_PENDING)
    }

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(inflater, R.layout.fragment_eng_part, container, false)
        return binding.root
    }

    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        val activityViewModel = getActivityViewModel(EngPartsViewModel::class.java)
        binding.partInfoViewModel = activityViewModel
        activityViewModel?.activityListener = activityListener
        binding.lifecycleOwner = viewLifecycleOwner
        


        if (!TextUtils.isEmpty(status) && status.equals(
                CommonConstant.ENGINEER_REQUESTED_PARTS, true
            )
        ) {

            partInfoAdapter = EngPartInfoAdapter(activityViewModel!!, true, status!!, this)


        } else {
            partInfoAdapter = EngPartInfoAdapter(activityViewModel!!, false, status.toString(), this)
        }



        binding.rvDevices.layoutManager = LinearLayoutManager(context, RecyclerView.VERTICAL, false)
        binding.rvDevices.adapter = partInfoAdapter
        partInfoAdapter?.changeDataSet(mPartList)

    }


    fun showCancelConfirmDialog(info: EngineerPartInfo
    ) {


        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.cancel) as ImageView
        val message = dialogView.findViewById(R.id.tv_message) as TextView
        val confirm = dialogView.findViewById(R.id.confirm) as Button
        val alertDialog = builder.create()
        cancel.setOnClickListener {
            alertDialog.dismiss()
        }
        confirm.setOnClickListener {
            alertDialog.dismiss()
            alertDialog.dismiss()

                        binding.partInfoViewModel!!.cancelPart(
                            object : OnResult<CancelPartResponse> {
                                override fun onResultAvailable(data: CancelPartResponse) {
                                        if (data.success)
                                        {

                                            binding.partInfoViewModel?.getEngPartInfoList(status.toString())
                                      cancelSuccessDialog(info)
                                        }
                                        else
                                        {
                                            binding.partInfoViewModel?.activityListener!!.showError(data.errorMsg)
                                        }


                                }
                            }, info?.prid.toString()
                        )



        }

        message.text = resources.getString(R.string.click_on_confirm_to_cancel)
        confirm.text = resources.getString(R.string.confirm)

        alertDialog.show()


    }


    fun cancelSuccessDialog(info: EngineerPartInfo) {
        var inflater = this.layoutInflater
        val dialogView = inflater.inflate(R.layout.dialog_cancel, null)


        val builder = AlertDialog.Builder(activity!!)

            .setView(dialogView)
            .setCancelable(false)


        val cancel = dialogView.findViewById(R.id.cancel) as ImageView
        val message = dialogView.findViewById(R.id.tv_message) as TextView
        val confirm = dialogView.findViewById(R.id.confirm) as Button
        val tv1 = dialogView.findViewById(R.id.tv1) as TextView
        val tv2 = dialogView.findViewById(R.id.tv2) as TextView
        tv1.visibility = View.VISIBLE
        tv2.visibility = View.VISIBLE

        message.text = "Part request for part name"
          tv1.text = info?.partName.toString()
        tv2.text = "is successfully cancelled"

        cancel.visibility = View.INVISIBLE
        val alertDialog = builder.create()
        cancel.setOnClickListener {

        }
        confirm.setOnClickListener {
            alertDialog.dismiss()
        }


        confirm.text = resources.getString(R.string.ok)

        alertDialog.show()
    }

    override fun cancel(info: EngineerPartInfo) {
       showCancelConfirmDialog(info)
    }

}