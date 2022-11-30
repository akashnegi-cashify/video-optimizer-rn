package `in`.cashify.androidtrc.module.engineer.ui.activity

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.ActivityOrderPartBinding
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartList
import `in`.cashify.androidtrc.module.engineer.api.response.OrderDevicePartResponse
import `in`.cashify.androidtrc.module.engineer.data.OrderPartActivityModel
import android.content.DialogInterface
import android.os.Bundle
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.widget.LinearLayout
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import java.util.*


/**
 * Created by Avaneesh Maurya on 21,August,2019
 */
class OrderPartActivity : BaseActivity(), View.OnClickListener {

    override fun onClick(v: View?) {
        when (v?.id) {
            binding.btnRequest.id ->{
                val partForOrder = binding.viewModel?.orderDevicePartAdapter?.getPartForOrder()
                if (!partForOrder.isNullOrEmpty()) {
                    val devicePartList = DevicePartList()
                    devicePartList.partInfoList = partForOrder
                    viewModel.orderDevicePart(
                        barcode,
                        devicePartList,
                        object : OnResult<OrderDevicePartResponse> {
                            override fun onResultAvailable(data: OrderDevicePartResponse) {
                                if (data.isSuccess) {
                                    showAlertDialog(
                                        "You have successfully ordered your part.",
                                        getString(R.string.ok),
                                        DialogInterface.OnClickListener { _, _ -> finish() },
                                        null,
                                        null
                                    )
                                }

                            }
                        })
                } else {
                    Toast.makeText(this, "Select part", Toast.LENGTH_SHORT).show()
                }
            }

            binding.ivClear.id -> clearFilter()


        }



    }

    override fun getLayoutResId(): Int {
        return R.layout.activity_order_part
    }

    companion object {
        val KEY_BARCODE: String = "key_barcode"
    }

    private lateinit var viewModel: OrderPartActivityModel
    private lateinit var binding: ActivityOrderPartBinding
    private var barcode: String? = null

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(OrderPartActivityModel::class.java)
        binding.lifecycleOwner = this
        binding.viewModel = viewModel
        viewModel.activityListener = this
        barcode = intent.getStringExtra(KEY_BARCODE)
        viewModel.createAdapter()
        setTitle("Order Part")
        binding.rvDevices.layoutManager = LinearLayoutManager(this, RecyclerView.VERTICAL, false)
        binding.rvDevices.adapter = viewModel.orderDevicePartAdapter
        viewModel.getDevicePartList(barcode)
        binding.btnRequest.setOnClickListener(this)
        binding.ivClear.setOnClickListener(this)
                binding.etSearchView.addTextChangedListener(textWatcher)

        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_ORDER_PART, null, null, true)

        viewModel.deviceList.observe(this, androidx.lifecycle.Observer {

          viewModel.orderDevicePartAdapter?.changeDataSet(it)
        })
    }


    private fun clearFilter()
    {
        binding.etSearchView.setText("")
    }



    private fun filterList(searchQuery: String) {
        if (viewModel?.deviceList.value == null) {
            return
        }
        if (searchQuery.isEmpty()) {
            viewModel.searchList.value = viewModel.deviceList.value
        } else {
            viewModel.searchList.value = ArrayList()


            for (part in viewModel.deviceList.value!!) {
                if (part.partName != null) {

                    if (part.partName!!.toLowerCase(Locale.getDefault()).contains(
                            searchQuery.toLowerCase(
                                Locale.getDefault()
                            ).trim()
                        )
                    ) {
                        viewModel.searchList.value?.add(part)
                        continue
                    }
                }

                if (part.partSku != null) {

                    if (part.partSku!!.toLowerCase(Locale.getDefault()).contains(
                            searchQuery.toLowerCase(
                                Locale.getDefault()
                            ).trim()
                        )
                    ) {
                        viewModel.searchList.value?.add(part)
                        continue
                    }
                }

            }
        }
        viewModel.orderDevicePartAdapter?.changeDataSet(viewModel.searchList.value)
        binding.etSearchView?.clearFocus()
//        viewModel?.orderDevicePartAdapter?.elssRequest?.repairPartList = partList
    }


    private var textWatcher: TextWatcher = object : TextWatcher {
        override fun afterTextChanged(s: Editable) {
            filterList(s.toString())
        }

        override fun beforeTextChanged(
            s: CharSequence,
            start: Int,
            count: Int,
            after: Int
        ) {
        }

        override fun onTextChanged(
            s: CharSequence,
            start: Int,
            before: Int,
            count: Int
        ) {
        }
    }

}