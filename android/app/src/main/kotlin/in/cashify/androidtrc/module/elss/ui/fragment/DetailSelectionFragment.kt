package `in`.cashify.androidtrc.module.elss.ui.fragment

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.common.OnResult
import `in`.cashify.androidtrc.databinding.FragmentDetailSelectionBinding
import `in`.cashify.androidtrc.module.elss.api.response.*
import `in`.cashify.androidtrc.module.elss.data.ElssViewModel
import `in`.cashify.androidtrc.module.elss.ui.activity.ElssPartSelectionActivity
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.AdapterView
import android.widget.ArrayAdapter
import android.widget.Toast
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProvider

class DetailSelectionFragment : BaseFragment(), AdapterView.OnItemClickListener,
    AdapterView.OnItemSelectedListener {

    companion object {
        private const val KEY_BARCODE = "key_barcode"
        fun newInstance(barcode: String) = DetailSelectionFragment().apply {
            arguments = Bundle().apply {
                putString(KEY_BARCODE, barcode)
            }
        }
    }

    private lateinit var brandAdapter: ArrayAdapter<BrandResponse>
    private lateinit var modelAdapter: ArrayAdapter<ModelResponse>
    private lateinit var colorAdapter: ArrayAdapter<String>
    private lateinit var viewModel: ElssViewModel
    private lateinit var binding: FragmentDetailSelectionBinding

    private var selectedBrand: BrandResponse? = null
    private var selectedModel: ModelResponse? = null
    private var selectedColor: String? = null


    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {

        this.binding = DataBindingUtil.inflate(
            layoutInflater,
            R.layout.fragment_detail_selection,
            container,
            false
        )
        return binding.root
    }


    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        viewModel = ViewModelProvider(requireActivity()).get(ElssViewModel::class.java)
        binding.barcode.text =
            viewModel.elssDeviceDetail.value?.elssDeviceDetail?.deviceBarcode
        binding.deviceName.text =
            viewModel.elssDeviceDetail.value?.elssDeviceDetail?.deviceName
        binding.deviceColor.text =
            viewModel.elssDeviceDetail.value?.elssDeviceDetail?.deviceColor
        brandAdapter = ArrayAdapter<BrandResponse>(
            requireContext(),
            android.R.layout.simple_list_item_1,
            mutableListOf()
        )


        modelAdapter = ArrayAdapter<ModelResponse>(
            requireContext(),
            android.R.layout.simple_list_item_1,
            mutableListOf()
        )


        colorAdapter = ArrayAdapter<String>(
            requireContext(),
            android.R.layout.simple_list_item_1,
            mutableListOf()
        )

        binding.brand.adapter = brandAdapter
        binding.model.adapter = modelAdapter
        binding.color.adapter = colorAdapter
        viewModel.getBrands(object : OnResult<BrandListResponse> {
            override fun onResultAvailable(data: BrandListResponse) {
                if (data.isSuccess) {
                    brandAdapter.clear()
                    data.list?.let {
                        try {
                            brandAdapter.addAll(it)
                        }
                        catch (e:Exception){
                            e.printStackTrace()
                        }

                    }

                } else {

                    if (activity is BaseActivity) {
                        (activity as BaseActivity).showError(data.errorMsg)
                    }

                }


            }

        },
            object : OnResult<Boolean> {
                override fun onResultAvailable(data: Boolean) {


                }

            })






        binding.brand.onItemSelectedListener = this
        binding.model.onItemSelectedListener = this
        binding.color.onItemSelectedListener = this
        binding.confirm.setOnClickListener {

            arguments?.getString(KEY_BARCODE)?.let { barCode ->


                if (selectedBrand == null) {

                    Toast.makeText(context, "Select Brand", Toast.LENGTH_SHORT).show()
                    return@setOnClickListener
                }
                if (selectedModel == null) {

                    Toast.makeText(context, "Select Product", Toast.LENGTH_SHORT).show()
                    return@setOnClickListener
                }

                submitDeviceDetail(barCode)


            }

        }
        binding.cancel.setOnClickListener {
            activity?.onBackPressed()
        }


    }

    private fun submitDeviceDetail(barCode: String) {


        val request = DeviceSubmitRequest()
        request.brandId = selectedBrand?.id
        request.color = selectedColor
        request.productId = selectedModel?.productId
        request.deviceBarcode = barCode

        viewModel.submitDeviceDetail(request,
            object : OnResult<DeviceDetailSubmitResponse> {
                override fun onResultAvailable(data: DeviceDetailSubmitResponse) {
                    if (data.success) {

                        onDeviceSubmitSuccess(barCode)

                    } else {

                        if (activity is BaseActivity) {
                            (activity as BaseActivity).showError(data.errorMsg)
                        }

                    }


                }

            },
            object : OnResult<Boolean> {
                override fun onResultAvailable(data: Boolean) {


                }

            })
    }


    private fun onDeviceSubmitSuccess(barcode: String) {
        viewModel.getElssDevice(barcode, object : OnResult<ElssDeviceResponse> {
            override fun onResultAvailable(data: ElssDeviceResponse) {
                if (data.isSuccess) {
                    val intent = Intent(
                        activity,
                        ElssPartSelectionActivity::class.java
                    )
                    intent.putExtra(ElssPartSelectionActivity.KEY_DETAIL, data)
                    intent.putExtra(ElssPartSelectionActivity.DEVICE_BARCODE, barcode)
                    startActivity(intent)
                } else {
                    if (activity is BaseActivity) {
                        (activity as BaseActivity).showError(data.errorMsg)
                    }

                }
            }
        }, object : OnResult<Boolean> {
            override fun onResultAvailable(data: Boolean) {

            }
        })
    }


    override fun onItemClick(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {


    }

    override fun onNothingSelected(parent: AdapterView<*>?) {


    }

    override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {

        when (parent?.id) {
            binding.brand.id -> {

                onBrandSelection(position)


            }
            binding.model.id -> {
                onModelSelection(position)


            }
            binding.color.id -> {

                onColorSelection(position)
            }
        }

    }

    private fun onColorSelection(position: Int) {
        selectedColor = colorAdapter.getItem(position)
    }

    private fun onModelSelection(position: Int) {


        val item = modelAdapter.getItem(position)
        selectedModel = item
        selectedColor = null

        viewModel.getColorList(
            item?.productId,
            object : OnResult<ColorListResponse> {
                override fun onResultAvailable(data: ColorListResponse) {
                    if (data.isSuccess) {
                        data.list?.let {
                            colorAdapter = ArrayAdapter<String>(
                                context!!,
                                android.R.layout.simple_list_item_1,
                                it
                            )
                            binding.color.set_isDirty(false)
                            binding.color.adapter = colorAdapter
                        }


                    } else {

                        if (activity is BaseActivity) {
                            (activity as BaseActivity).showError(data.errorMsg)
                        }

                    }


                }

            },
            object : OnResult<Boolean> {
                override fun onResultAvailable(data: Boolean) {


                }

            })

    }

    private fun onBrandSelection(position: Int) {


        val item = brandAdapter.getItem(position)
        selectedBrand = item
        selectedModel = null
        selectedColor = null
        viewModel.getModels(
            item?.id,
            object : OnResult<ModelListResponse> {
                override fun onResultAvailable(data: ModelListResponse) {
                    if (data.isSuccess) {
                        data.list?.let {
                            modelAdapter = ArrayAdapter<ModelResponse>(
                                context!!,
                                android.R.layout.simple_list_item_1,
                                it
                            )
                            binding.model.set_isDirty(false)
                            binding.model.adapter = modelAdapter
                        }


                    } else {

                        if (activity is BaseActivity) {
                            (activity as BaseActivity).showError(data.errorMsg)
                        }

                    }


                }

            },
            object : OnResult<Boolean> {
                override fun onResultAvailable(data: Boolean) {


                }

            })

    }


}