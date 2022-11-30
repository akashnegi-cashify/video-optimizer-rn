package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityInventoryManagerBinding
import `in`.cashify.androidtrc.module.inventory_manager.adapter.GroupListAdapter
import `in`.cashify.androidtrc.module.inventory_manager.fragment.InventoryManagerSummaryFragment
import android.content.Intent
import android.os.Bundle
import android.view.MenuItem
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.app.AlertDialog
import androidx.core.view.GravityCompat
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.amazonaws.util.StringUtils
import com.google.android.material.navigation.NavigationView
import java.util.*
import kotlin.collections.ArrayList
import kotlin.collections.HashMap
import kotlin.collections.LinkedHashMap

class InventoryManagerActivity : BaseActivity() {
    private lateinit var binding: ActivityInventoryManagerBinding
    private lateinit var viewModel: InventoryManagerViewModel
private var group:String = ""


    private var filteredGroupList = ArrayList<String>()
    private var groupMAp = LinkedHashMap<String, Boolean>()




    override fun getLayoutResId(): Int {
        return R.layout.activity_inventory_manager
    }

    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        viewModel = ViewModelProviders.of(this, factory).get(InventoryManagerViewModel::class.java)
        viewModel.activityListener = this


        setTitle(resources.getString(R.string.delivery))
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_INVENTORY_MANAGER, null, null, true)


        viewModel.isShowNoDataDialog.observe(this, Observer {

            if (it) {
                val inflater = this.layoutInflater
                val dialogView = inflater.inflate(R.layout.no_data_found, null)


                val builder = AlertDialog.Builder(this)

                    .setView(dialogView)
                    .setCancelable(false)


                val btnOk = dialogView.findViewById(R.id.btn_ok) as TextView


                val alertDialog = builder.create()
                btnOk.setOnClickListener {
                    alertDialog.dismiss()
                }


                alertDialog.show()


            }


        })



        viewModel?.groupListResponse?.observe(this, Observer {






          filterList( LinkedHashMap<String, Boolean>().apply {
              viewModel?.groupListResponse?.value?.groupList?.onEach {

                  put(it, false)

              }

          }
          )



            groupListDialog {
                mActivityHelper.replaceFragment(
                    this,
                    InventoryManagerTabFragment.newInstance(InventoryManagerEnum.DELIVERY.value),
                    getContainerId(),
                    true
                )


            }


        })



        viewModel?.groupList()



    }


    override fun getContainerId(): Int {
        return binding.container?.id
    }


    override fun onBackPressed() {
        super.onBackPressed()
        if (supportFragmentManager.backStackEntryCount == 1) {
            finish()
        } else {
            super.onBackPressed()
        }
    }


   override  fun isShowNavDrawer():Boolean{
        return true
    }


    override fun onOptionsItemSelected(menuItem: MenuItem): Boolean {
        if (actionBarDrawerToggle?.onOptionsItemSelected(menuItem)?:false) {
            return true;
        }
        return super.onOptionsItemSelected(menuItem);
    }


    override fun initNavDrawer() {
        super.initNavDrawer()
        baseBinding.navView.menu.clear()
        baseBinding.navView.inflateMenu(R.menu.inventory_manager_menu)
        baseBinding.navView.setNavigationItemSelectedListener (object : NavigationView.OnNavigationItemSelectedListener
        {
            override fun onNavigationItemSelected(item: MenuItem): Boolean {
               when(item.itemId){
                   R.id.item_delivery ->{
                       setTitle(resources.getString(R.string.delivery))
                       mActivityHelper.replaceFragment(
                           this@InventoryManagerActivity,
                           InventoryManagerTabFragment.newInstance(InventoryManagerEnum.DELIVERY.value),
                           getContainerId(),
                           true
                       )
                   }
                   R.id.item_return ->{


                       startActivity(Intent(this@InventoryManagerActivity, InventoryManagerReturnActivity::class.java))


                   }
                   R.id.item_summary ->{



                       startActivity(Intent(this@InventoryManagerActivity, InventoryManagerSummaryActivity::class.java))



                   }


               }


                baseBinding.myDrawerLayout.closeDrawer(GravityCompat.START)
                return true
            }

        })


           }


    override fun isShowLogoutButton(): Boolean {
        return false
    }



    fun groupClick(data: Pair<List<String>, LinkedHashMap<String, Boolean>>){
    filteredGroupList.clear()
        groupMAp.clear()

        filterList(data.second)
        dialogSubmitButton?.isEnabled = groupMAp.values.toTypedArray().get(0)
        if(groupMAp.values.toTypedArray().get(0)){
            dialogSubmitButton?.background = resources.getDrawable(R.drawable.teal_bg_round_corner)

        }

        else{
            dialogSubmitButton?.background = resources.getDrawable(R.drawable.dark_grey_bg_round_corner)
        }
        groupListAdapter?.setData(Pair(filteredGroupList,groupMAp))


    }
var dialog:AlertDialog? = null
    var groupListAdapter:GroupListAdapter? = null

    var dialogSubmitButton :Button? = null

     fun groupListDialog( submitClick :()-> Unit){

         if(viewModel?.groupListResponse.value == null){
             viewModel?.groupList()
             return
         }

         dialog?.dismiss()



          groupListAdapter = GroupListAdapter(this::groupClick)
        val rootView: View = layoutInflater.inflate(R.layout.dialog_group_list, null)

         val alertDialog = AlertDialog.Builder(this)
        alertDialog?.setCancelable(false)
        alertDialog?.setView(rootView)

      dialogSubmitButton =    rootView.findViewById<Button>(R.id.btn_submit).apply {

if(groupMAp.values.toTypedArray().get(0)){
    this.background = resources.getDrawable(R.drawable.teal_bg_round_corner)

}

          else{
    this.background = resources.getDrawable(R.drawable.dark_grey_bg_round_corner)
          }
             isEnabled = groupMAp.values.toTypedArray().get(0)

             setOnClickListener {

                 submitClick()


                 dialog?.dismiss()
                 dialog = null

             }
         }




         groupListAdapter?.setData(Pair(filteredGroupList , groupMAp))

        rootView.findViewById<RecyclerView>(R.id.recl_grp_list).apply {
            layoutManager  = LinearLayoutManager(this@InventoryManagerActivity)
            adapter = groupListAdapter

        }







         dialog = alertDialog.create()
        dialog?.window!!.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN)
         dialog?.show()

        return
    }



    private fun filterList(map:LinkedHashMap<String, Boolean>){

        groupMAp.clear()
        filteredGroupList.clear()
        viewModel?.selectedGroups = ""



        val selectedList =  ArrayList<String>()

map.keys.toTypedArray().forEach {
if(map.get(it)?:false){
    selectedList.add(it)
}
}



        viewModel.selectedGroups = selectedList.joinToString (",")


        groupMAp.putAll(map.filter {
            it.value == true
        })



        groupMAp.putAll(map.filter {
            it.value == false
        })


        groupMAp?.forEach{
            filteredGroupList.add(it.key)
        }












    }
}
