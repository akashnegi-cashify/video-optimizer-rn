package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.common.BaseFragment
import `in`.cashify.androidtrc.databinding.FragmentInventoryManagerTabBinding
import `in`.cashify.androidtrc.module.inventory_manager.adapter.IMPartDevicesStatusAdapter
import `in`.cashify.androidtrc.util.CommonConstant
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.databinding.DataBindingUtil


class InventoryManagerTabFragment : BaseFragment() {

    private var binding: FragmentInventoryManagerTabBinding? = null
    private var viewModel: InventoryManagerReturnViewModel? = null
    private var adapter: IMPartDevicesStatusAdapter? = null
    private var enumType: Int? = null
    override fun onCreateView(
        inflater: LayoutInflater, container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        binding = DataBindingUtil.inflate(
            layoutInflater,
            R.layout.fragment_inventory_manager_tab,
            container,
            false
        )
        viewModel = getActivityViewModel(InventoryManagerReturnViewModel::class.java)

        enumType = arguments?.getInt(CommonConstant.Inventory_MANAGER_ENUM)


        binding?.tabLayout?.setupWithViewPager(binding?.viewPager)
        binding?.viewPager?.adapter = IMPartDevicesStatusAdapter(
            childFragmentManager,
            enumType ?: InventoryManagerEnum.DELIVERY.value
        )


        return binding?.root
    }


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


    }

    companion object {

        @JvmStatic
        fun newInstance(enumType: Int) =
            InventoryManagerTabFragment().apply {
                arguments = Bundle().apply {

                    putInt(CommonConstant.Inventory_MANAGER_ENUM, enumType)
                }
            }
    }
}