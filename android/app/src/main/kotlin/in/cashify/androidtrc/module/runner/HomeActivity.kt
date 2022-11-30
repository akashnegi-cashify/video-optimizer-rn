package `in`.cashify.androidtrc.module.runner

import `in`.cashify.androidtrc.BuildConfig
import `in`.cashify.androidtrc.R
import `in`.cashify.androidtrc.analytics.helper.AnalyticsController
import `in`.cashify.androidtrc.analytics.helper.AnalyticsEventHelper
import `in`.cashify.androidtrc.common.AppInfoProvider
import `in`.cashify.androidtrc.common.BaseActivity
import `in`.cashify.androidtrc.databinding.ActivityHomeBinding
import `in`.cashify.androidtrc.module.elss.ui.activity.ScanElssBarcodeActivity
 import `in`.cashify.androidtrc.module.engineer.ui.activity.*
import `in`.cashify.androidtrc.module.engineer.view_report.ui.activity.ViewReportTabActivity
import `in`.cashify.androidtrc.module.inventory_manager.InventoryManagerActivity
import `in`.cashify.androidtrc.module.qc.QCActivity
import `in`.cashify.androidtrc.module.rider.ui.RiderActivity
import `in`.cashify.androidtrc.module.rubbing_engineer.ui.activity.RubbingActivity
import `in`.cashify.androidtrc.module.runner.adapter.RoleAdapter
import `in`.cashify.androidtrc.module.runner.data.HomeViewModel
import `in`.cashify.androidtrc.module.runner.data.RoleData
import `in`.cashify.androidtrc.module.runner.ui.activity.GivenDeviceActivity
import `in`.cashify.androidtrc.module.runner.ui.activity.MarkL4Activity
import `in`.cashify.androidtrc.module.runner.ui.activity.MarkOkActivity
import android.content.Intent
import android.os.Bundle
import android.widget.LinearLayout
import androidx.databinding.DataBindingUtil
import androidx.lifecycle.ViewModelProviders
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
class HomeActivity : BaseActivity(), RoleAdapter.OnRoleClick {

    override fun onRoleClick(roleData: RoleData) {
        when (roleData.roleId) {
            RoleAdapter.ENGINEER -> {
                val intent = Intent(
                    this,
                    GivenDeviceActivity::class.java
                )
                startActivity(
                    intent
                )
            }
            RoleAdapter.MARK_OK -> {
                val intent = Intent(
                    this,
                    MarkOkActivity::class.java
                )
                startActivity(
                    intent
                )
            }
            RoleAdapter.L4 -> {
                val intent = Intent(
                    this,
                    MarkL4Activity::class.java
                )
                startActivity(
                    intent
                )
            }

            RoleAdapter.RECEIVED_DEVICES -> {
                val intent = Intent(
                    this,
                    ReceiveDeviceActivity::class.java
                )
                startActivity(
                    intent
                )
            }

            RoleAdapter.RECEIVED_PARTS -> {
                val intent = Intent(
                    this,
                    ReceivePartsActivity::class.java
                )
                startActivity(
                    intent
                )
            }

            RoleAdapter.MY_DEVICES -> {
                startActivity(Intent(this , EngineerMyDevicesTabActivity::class.java))
//                showButtonDialog()
            }

            RoleAdapter.MANAGE_PARTS -> {
                val intent = Intent(
                    this,
                    EngPartListActivity::class.java
                )
                startActivity(
                    intent
                )
            }
            RoleAdapter.SCAN_BARCODE -> {
                val intent = Intent(
                    this,
                    ScanElssBarcodeActivity::class.java
                )
                startActivity(
                    intent
                )
            }

            RoleAdapter.SCAN_BARCODE_RUBBING -> {
                val intent = Intent(
                    this,
                    RubbingActivity::class.java
                )
                startActivity(
                    intent.putExtra(RubbingActivity.IS_SCANNING,true)
                )
            }

            RoleAdapter.RECEIVED_DEVICES_RUBBING -> {
                val intent = Intent(
                    this,
                    RubbingActivity::class.java
                )
                startActivity(
                    intent.putExtra(RubbingActivity.IS_SCANNING,false)
                )
            }


            RoleAdapter.VIEW_REPORT -> {
                val intent = Intent(
                    this,
                    ViewReportTabActivity::class.java
                )
                startActivity(
                    intent
                )
            }



            RoleAdapter.ROLE_INVENTORY_MANAGER -> {
                val intent = Intent(
                    this,
                    InventoryManagerActivity::class.java
                )
                startActivity(
                    intent
                )
            }

            RoleAdapter.STORE_IN -> {
                handleStoreIn()
            }

            RoleAdapter.STORE_OUT -> {
                handleStoreOut()
            }
        }
    }

    private lateinit var homeViewModel: HomeViewModel
    private lateinit var binding: ActivityHomeBinding

    override fun getLayoutResId(): Int {
        return R.layout.activity_home
    }


    override fun create(
        savedInstanceState: Bundle?,
        mainContainer: LinearLayout,
        addToParent: Boolean
    ) {
        binding =
            DataBindingUtil.inflate(layoutInflater, getLayoutResId(), mainContainer, addToParent)
        homeViewModel = ViewModelProviders.of(this, factory).get(HomeViewModel::class.java)
        binding.lifecycleOwner = this
        binding.homeViewModel = homeViewModel
        homeViewModel.activityListener = this
        AnalyticsEventHelper.fireScreenEvent(this, AnalyticsController.AnalyticEventKey.EVENT_ONCREATE, AnalyticsController.AnalyticScreen.SCREEN_HOME, null, null, true)

        if(homeViewModel.isInventoryManagerRole()){
            val intent = Intent(
                this,
                InventoryManagerActivity::class.java
            )
            startActivity(
                intent
            )


            finish()
        }

        else if(homeViewModel.isQCRole()){
            val intent = Intent(
                this,
                QCActivity::class.java
            )
            startActivity(
                intent
            )


            finish()
        }


        else if(homeViewModel.isRiderRole()){
            val intent = Intent(
                this,
                RiderActivity::class.java
            )
            startActivity(
                intent
            )
            finish()
        }


        homeViewModel.loadRoles()

        binding.rvRoles.layoutManager = LinearLayoutManager(this, RecyclerView.VERTICAL, false)
        homeViewModel.adapter.mOnRoleClick = this
        binding.rvRoles.adapter = homeViewModel.adapter

        setTitle("Home")
        binding.tvName.text = "Logged In User:" + AppInfoProvider.getInstance().getUserName()
        binding.tvAppVersion.text = "App Version:" + BuildConfig.VERSION_NAME


    }

}