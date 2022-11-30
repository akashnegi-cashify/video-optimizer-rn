package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.module.runner.HomeActivity
import `in`.cashify.androidtrc.module.runner.adapter.RoleAdapter
import androidx.lifecycle.MutableLiveData
import javax.inject.Inject


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class HomeViewModel @Inject constructor() : BaseViewModel() {

    var role: String? = null
    val adapter = RoleAdapter()
    var roleList = MutableLiveData<List<RoleData>>()

    init {
        roleList.value = emptyList()
    }


    fun isInventoryManagerRole():Boolean{
        val userDetailResponse = AppInfoProvider.getInstance().getUserDetailResponse()
        if(userDetailResponse?.roles?.contains(RoleAdapter.ROLE_INVENTORY_MANAGER)?:false&& userDetailResponse?.roles?.size==1){
            return true
        }

        return false
    }



    fun isQCRole():Boolean{
        val userDetailResponse = AppInfoProvider.getInstance().getUserDetailResponse()
        if(userDetailResponse?.roles?.contains(RoleAdapter.ROLE_QC)?:false&& userDetailResponse?.roles?.size==1){
            return true
        }

        return false
    }



    fun isRiderRole():Boolean{
        val userDetailResponse = AppInfoProvider.getInstance().getUserDetailResponse()
        if(userDetailResponse?.roles?.contains(RoleAdapter.ROLE_RIDER)?:false&& userDetailResponse?.roles?.size==1){
            return true
        }

        return false
    }

    private fun addRoleData(): List<RoleData> {
        val userDetailResponse = AppInfoProvider.getInstance().getUserDetailResponse()
        val list: ArrayList<RoleData> = ArrayList()
        if (userDetailResponse?.roles?.contains(RoleAdapter.ROLE_RUNNER)!!) {
            val element1 = RoleData()
            element1.roleName = RoleAdapter.ENGINEER
            element1.roleId = RoleAdapter.ENGINEER
            val element2 = RoleData()
            element2.roleName = RoleAdapter.MARK_OK
            element2.roleId = RoleAdapter.MARK_OK
            val element3 = RoleData()
            element3.roleName = RoleAdapter.L4
            element3.roleId = RoleAdapter.L4
            list.add(element1)
            list.add(element2)
            list.add(element3)
            role = RoleAdapter.ROLE_RUNNER

        }
        if (userDetailResponse.roles?.contains(RoleAdapter.ROLE_ENGINEER)!!) {
            val element1 = RoleData()
            element1.roleName = RoleAdapter.RECEIVED_DEVICES
            element1.roleId = RoleAdapter.RECEIVED_DEVICES

            val element3 = RoleData()
            element3.roleName = RoleAdapter.MY_DEVICES
            element3.roleId = RoleAdapter.MY_DEVICES
            val element4 = RoleData()
            element4.roleName = RoleAdapter.MANAGE_PARTS
            element4.roleId = RoleAdapter.MANAGE_PARTS


            val element5 = RoleData()
            element5.roleName = RoleAdapter.VIEW_REPORT
            element5.roleId = RoleAdapter.VIEW_REPORT
            list.add(element1)
             list.add(element3)
            list.add(element4)
            list.add(element5)
            role = RoleAdapter.ROLE_ENGINEER

        }

        if (userDetailResponse.roles?.contains(RoleAdapter.ROLE_L4)!!) {
            val element1 = RoleData()
            element1.roleName = RoleAdapter.RECEIVED_DEVICES
            element1.roleId = RoleAdapter.RECEIVED_DEVICES

            val element3 = RoleData()
            element3.roleName = RoleAdapter.MY_DEVICES
            element3.roleId = RoleAdapter.MY_DEVICES
            val element4 = RoleData()
            element4.roleName = RoleAdapter.MANAGE_PARTS
            element4.roleId = RoleAdapter.MANAGE_PARTS
            list.add(element1)
             list.add(element3)
            list.add(element4)
            role = RoleAdapter.ROLE_L4

        }

        if (userDetailResponse.roles?.contains(RoleAdapter.ROLE_STORAGE_MANAGER)!!)
        {

            val element1 = RoleData()
            element1.roleName = RoleAdapter.STORE_IN
            element1.roleId = RoleAdapter.STORE_IN

            val element2 = RoleData()
            element2.roleName = RoleAdapter.STORE_OUT
            element2.roleId = RoleAdapter.STORE_OUT
            list.add(element1)
            list.add(element2)

            role = RoleAdapter.ROLE_STORAGE_MANAGER
        }


        if (userDetailResponse.roles?.contains(RoleAdapter.ROLE_ELSS)!!) {
            val element1 = RoleData()
            element1.roleName = RoleAdapter.SCAN_BARCODE
            element1.roleId = RoleAdapter.SCAN_BARCODE
            list.add(element1)
            role = RoleAdapter.ROLE_RUNNER

        }

        if (userDetailResponse.roles?.contains(RoleAdapter.ROLE_RUBBING)!!) {
            val element1 = RoleData()
            element1.roleName = RoleAdapter.SCAN_BARCODE_RUBBING
            element1.roleId = RoleAdapter.SCAN_BARCODE_RUBBING

            val element2 = RoleData()
            element2.roleName = RoleAdapter.RECEIVED_DEVICES_RUBBING
            element2.roleId = RoleAdapter.RECEIVED_DEVICES_RUBBING

            list.add(element1)
            list.add(element2)
            role = RoleAdapter.ROLE_RUBBING

        }


        if (userDetailResponse.roles?.contains(RoleAdapter.ROLE_INVENTORY_MANAGER)!!) {
            val element1 = RoleData()
            element1.roleName = RoleAdapter.ROLE_INVENTORY_MANAGER
            element1.roleId = RoleAdapter.ROLE_INVENTORY_MANAGER
            list.add(element1)
            role = RoleAdapter.ROLE_INVENTORY_MANAGER

        }


        return list
    }

    fun loadRoles() {
        roleList.value = addRoleData()
    }

}