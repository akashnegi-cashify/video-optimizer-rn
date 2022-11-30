package `in`.cashify.androidtrc.common.dagger

import `in`.cashify.androidtrc.module.elss.ui.ScanActivityFragmentBuilder
import `in`.cashify.androidtrc.module.elss.ui.activity.ElssCaptureImageActivity
import `in`.cashify.androidtrc.module.elss.ui.activity.ElssPartSelectionActivity
import `in`.cashify.androidtrc.module.elss.ui.activity.ScanElssBarcodeActivity
import `in`.cashify.androidtrc.module.engineer.data.*
import `in`.cashify.androidtrc.module.engineer.ui.activity.*
import `in`.cashify.androidtrc.module.engineer.view_report.data.ViewReportFragmentBuilder
import `in`.cashify.androidtrc.module.engineer.view_report.ui.activity.ViewReportTabActivity
import `in`.cashify.androidtrc.module.inventory_manager.*
import `in`.cashify.androidtrc.module.inventory_manager.fragment.pending.InventoryManagerPendingPartActivity
import `in`.cashify.androidtrc.module.inventory_manager.fragment.assigned.IMDeviceAssignedActivity
import `in`.cashify.androidtrc.module.inventory_manager.fragment.assigned.InventoryManagerAssignedFragmentBuilder
import `in`.cashify.androidtrc.module.inventory_manager.fragment.receive.IMReceiveFragmentBuilder
import `in`.cashify.androidtrc.module.inventory_manager.fragment.receive.IMReceiveScanAcitity
import `in`.cashify.androidtrc.module.inventory_manager.fragment.return_parts.IMPartReturnDetailActivity
import `in`.cashify.androidtrc.module.login.ChangePasswordActivity
import `in`.cashify.androidtrc.module.login.LoginActivity
import `in`.cashify.androidtrc.module.login.ScanLocationActivity
import `in`.cashify.androidtrc.module.login.data.LoginActivityFragmentBuilder
import `in`.cashify.androidtrc.module.qc.QCActivity
import `in`.cashify.androidtrc.module.qc.QCActivityFragmentBuilder
import `in`.cashify.androidtrc.module.qc.QCPartBarcodeScanActivity
import `in`.cashify.androidtrc.module.qc.ui.QCPendingPartByBarcodeActivity
import `in`.cashify.androidtrc.module.qc.ui.QCPendingPartDetailsActivity
import `in`.cashify.androidtrc.module.rider.data.RiderFragmentBBuilder
import `in`.cashify.androidtrc.module.rider.ui.RiderActivity
import `in`.cashify.androidtrc.module.rider.ui.delivery.PendingPartsDelivertoEngineerActivity
import `in`.cashify.androidtrc.module.rider.ui.pickup.PickupPartFromEngineerScanActivity
import `in`.cashify.androidtrc.module.rider.ui.pickup.PickupPartListActivity
import `in`.cashify.androidtrc.module.rubbing_engineer.ui.RubbingActivityFragmentBuilder
import `in`.cashify.androidtrc.module.rubbing_engineer.ui.activity.RubbingActivity
import `in`.cashify.androidtrc.module.runner.HomeActivity
import `in`.cashify.androidtrc.module.runner.data.*
import `in`.cashify.androidtrc.module.runner.ui.activity.*
import `in`.cashify.androidtrc.module.splash.SplashActivity
import `in`.cashify.androidtrc.module.storageManager.ui.activity.*
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class ActivityBuilder {

    @ContributesAndroidInjector()
    internal abstract fun bindSplashActivity(): SplashActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class, LoginActivityFragmentBuilder::class])
    internal abstract fun bindLoginActivity(): LoginActivity

    @ContributesAndroidInjector()
    internal abstract fun bindChangePasswordActivity(): ChangePasswordActivity

    @ContributesAndroidInjector()
    internal abstract fun bindHomeActivity(): HomeActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class, AllocatedDeviceActivityFragmentBuilder::class])
    internal abstract fun bindGivenDeviceActivity(): GivenDeviceActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class, TrayListActivityFragmentBuilder::class])
    internal abstract fun bindTrayListActivity(): TrayListActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class, MarkOkActivityFragmentBuilder::class])
    internal abstract fun bindMarkOkActivity(): MarkOkActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class, L4ActivityFragmentBuilder::class])
    internal abstract fun bindMarkL4Activity(): MarkL4Activity

    @ContributesAndroidInjector(modules = [ActivityModule::class, EngTrayScanActivityFragmentBuilder::class])
    internal abstract fun bindEngTrayScanActivity(): EngineerTrayScanActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class, PickMarkOkDeviceActivityFragmentBuilder::class])
    internal abstract fun bindMarkOkScanActivity(): PickMarkOkDeviceActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class, MoveMarkOkDeviceActivityFragmentBuilder::class])
    internal abstract fun bindMoveMarkOkActivity(): MoveMarkOkDeviceActivity

    @ContributesAndroidInjector()
    internal abstract fun bindReceiveDeviceActivity(): ReceiveDeviceActivity

    @ContributesAndroidInjector()
    internal abstract fun bindReceivePartActivity(): ReceivePartsActivity

    @ContributesAndroidInjector()
    internal abstract fun bindScanAllowedPartsActivity(): ScanAllowedPartsActivity
    




    @ContributesAndroidInjector(modules = [ActivityModule::class, EngPartActivityFragmentBuilder::class])
    internal abstract fun bindEngPartActivity(): EngPartListActivity

    @ContributesAndroidInjector()
    internal abstract fun bindWipOptionActivity(): WipOptionActivity

    @ContributesAndroidInjector()
    internal abstract fun bindOrderPartActivity(): OrderPartActivity

    @ContributesAndroidInjector()
    internal abstract fun bindViewPartActivity(): ViewPartActivity



    @ContributesAndroidInjector(modules = [ActivityModule::class, ScanActivityFragmentBuilder::class])
    internal abstract fun bindScanElssActivity(): ScanElssBarcodeActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class, RubbingActivityFragmentBuilder::class])
    internal abstract fun bindScanRubbingActivity(): RubbingActivity

    @ContributesAndroidInjector()
    internal abstract fun bindElssPartActivity(): ElssPartSelectionActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class, StoreInFragmentBuilder::class])
    internal abstract fun bindStoreInActivity(): StoreInActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class, StoreOutHomeFragmentBuilder::class])
    internal abstract fun bindStoreOutActivity(): StoreOutActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class, VirtualStoreScanFragmentBuilder::class])
    internal abstract fun bindVirtualStoreActivity(): VirtualStore


    @ContributesAndroidInjector(modules = [ActivityModule::class, SelfAssignFragmentBuilder::class])
    internal abstract fun bindVirtualSelfAssignmentActivity(): SelfAssignPartActivity



    @ContributesAndroidInjector(modules = [ActivityModule::class])
    internal abstract fun bindElssCaptureActivity(): ElssCaptureImageActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class, ViewReportFragmentBuilder::class])
    internal abstract fun bindviewReportActivity(): ViewReportTabActivity





    @ContributesAndroidInjector(modules = [ActivityModule::class, InventoryManagerFragmentBuilder::class])
    internal abstract fun bindInventoryManagerActivity(): InventoryManagerActivity



    @ContributesAndroidInjector(modules = [ActivityModule::class, InventoryManagerPendingFragmentBuilder::class])
    internal abstract fun bindInventoryManagerPendingPartActivity(): InventoryManagerPendingPartActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class])
    internal abstract fun bindScanLocationActivity(): ScanLocationActivity




    @ContributesAndroidInjector(modules = [ActivityModule::class, InventoryManagerAssignedFragmentBuilder::class ])
    internal abstract fun bindIMDeviceAssignedActivity(): IMDeviceAssignedActivity



    @ContributesAndroidInjector(modules = [ActivityModule::class, QCActivityFragmentBuilder::class ])
    internal abstract fun bindQCActivity(): QCActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class])
    internal abstract fun bindQCPendingPartByBarcodeActivity(): QCPendingPartByBarcodeActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class])
    internal abstract fun bindQCPendingPartDetailsActivity(): QCPendingPartDetailsActivity



    @ContributesAndroidInjector(modules = [ActivityModule::class])
    internal abstract fun bindQCPartBarcodeScanActivity(): QCPartBarcodeScanActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class])
    internal abstract fun bindEngineerDevicePartAssignedListActivity(): EngineerDevicePartAssignedListActivity




    @ContributesAndroidInjector(modules = [ActivityModule::class , RiderFragmentBBuilder::class])
    internal abstract fun bindRiderActivity(): RiderActivity




    @ContributesAndroidInjector(modules = [ActivityModule::class ])
    internal abstract fun bindPendingPartsDelivertoEngineerActivity(): PendingPartsDelivertoEngineerActivity




    @ContributesAndroidInjector(modules = [ActivityModule::class ])
    internal abstract fun bindPickupPartListActivity(): PickupPartListActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class ])
    internal abstract fun pickupPartFromEngineerScanActivity(): PickupPartFromEngineerScanActivity



    @ContributesAndroidInjector(modules = [ActivityModule::class, IMReceiveFragmentBuilder::class ])
    internal abstract fun iMReceiveScanAcitity(): IMReceiveScanAcitity


    @ContributesAndroidInjector(modules = [ActivityModule::class])
    internal abstract fun iMPartReturnDetailActivity(): IMPartReturnDetailActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class])
    internal abstract fun inventoryManagerScannerActivity(): InventoryManagerScannerActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class])
    internal abstract fun inventoryEngineerViewPartScannerActivity(): EngineerViewPartScannerActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class , EngineerMyDevicesTabFragmentBuilder::class])
    internal abstract fun inventoryEngineerMyDevicesTabActivity(): EngineerMyDevicesTabActivity

    @ContributesAndroidInjector(modules = [ActivityModule::class ])
    internal abstract fun wipPartInfoActivity(): WIPPartInfoActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class ])
    internal abstract fun engineerPartInfoActivity(): EngineerPartInfoActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class, InventoryManagerSummaryFragmentBBuilder::class ])
    internal abstract fun inventoryManagerSummaryActivity(): InventoryManagerSummaryActivity



    @ContributesAndroidInjector(modules = [ActivityModule::class, InventoryManagerReturnFragmentBuilderr::class ])
    internal abstract fun inventoryManagerReturnActivity(): InventoryManagerReturnActivity


    @ContributesAndroidInjector(modules = [ActivityModule::class, InventoryManagerRequestsFragmnetBuilder::class])
    internal abstract fun bindInventoryRequestsActivity(): InventoryRequestsActivity


}
