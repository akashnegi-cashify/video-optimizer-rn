package `in`.cashify.androidtrc.util


import `in`.cashify.androidtrc.common.dagger.TrcViewModelFactory
import `in`.cashify.androidtrc.module.elss.data.ElssCaptureImageViewModel
import `in`.cashify.androidtrc.module.elss.data.ElssViewModel
import `in`.cashify.androidtrc.module.engineer.data.*
import `in`.cashify.androidtrc.module.engineer.view_report.data.ViewReportViewModel
import `in`.cashify.androidtrc.module.inventory_manager.*
import `in`.cashify.androidtrc.module.inventory_manager.fragment.return_parts.IMPartReturnDetailViewModel
import `in`.cashify.androidtrc.module.login.data.LoginViewModelV2
import `in`.cashify.androidtrc.module.qc.QCActivityViewModel
import `in`.cashify.androidtrc.module.qc.QCPartBBarcodeScanActivityViewModel
import `in`.cashify.androidtrc.module.qc.QCPendingByBarcodeViewModel
import `in`.cashify.androidtrc.module.qc.QCPendingPartDetailActivityViewModel
import `in`.cashify.androidtrc.module.rider.data.PendingPartDeliverToEngineerViewModel
import `in`.cashify.androidtrc.module.rider.data.PickupPartListActivityViewmodel
import `in`.cashify.androidtrc.module.rider.data.RiderActivityViewModel
import `in`.cashify.androidtrc.module.rubbing_engineer.data.RubbingViewModel
import `in`.cashify.androidtrc.module.runner.data.*
import `in`.cashify.androidtrc.module.storageManager.data.StoreInViewModel
import `in`.cashify.androidtrc.module.storageManager.data.StoreOutViewMadel
import `in`.cashify.androidtrc.module.storageManager.data.VirtualStoreViewModel
import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import dagger.Binds
import dagger.Module
import dagger.multibindings.IntoMap


@Module
internal abstract class ViewModelModule {

    @Binds
    @IntoMap
    @ViewModelKey(LoginViewModelV2::class)
    abstract fun bindLoginViewModel(viewModel: LoginViewModelV2): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(HomeViewModel::class)
    abstract fun bindHomeViewModel(viewModel: HomeViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(DeviceAllocatedViewModel::class)
    abstract fun bindDeviceAllocatedModel(viewModel: DeviceAllocatedViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(TrayActivityViewModel::class)
    abstract fun bindTrayActivityViewModel(viewModel: TrayActivityViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(MarkOkViewModel::class)
    abstract fun bindMarkOkActivityViewModel(viewModel: MarkOkViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(L4ViewModel::class)
    abstract fun bindL4ActivityViewModel(viewModel: L4ViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(EngTrayScanViewModel::class)
    abstract fun bindEngScanViewModel(viewModel: EngTrayScanViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(PickMarkOkDeviceViewModel::class)
    abstract fun bindMarkOkScanViewModel(viewModel: PickMarkOkDeviceViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(MoveMarkOkDeviceViewModel::class)
    abstract fun bindMoveMarkOkViewModel(viewModel: MoveMarkOkDeviceViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(ReceiveDeviceActivityViewModel::class)
    abstract fun bindReceiveDeviceViewModel(viewModel: ReceiveDeviceActivityViewModel): ViewModel





    @Binds
    @IntoMap
    @ViewModelKey(EngPartsViewModel::class)
    abstract fun bindPartsViewModel(viewModel: EngPartsViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(WipOptionActivityModel::class)
    abstract fun bindWipOptionViewModel(viewModel: WipOptionActivityModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(OrderPartActivityModel::class)
    abstract fun bindOrderPartViewModel(viewModel: OrderPartActivityModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(ViewPartActivityViewModel::class)
    abstract fun bindViewPartViewModel(viewModel: ViewPartActivityViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(ElssViewModel::class)
    abstract fun bindElssViewModel(viewModel: ElssViewModel): ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(ElssCaptureImageViewModel::class)
    abstract fun bindElssCaptureImageViewModel(viewModel: ElssCaptureImageViewModel): ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(StoreInViewModel::class)
    abstract fun bindStoreInActivity(viewModel: StoreInViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(StoreOutViewMadel::class)
    abstract fun bindStoreOutActivity(viewModel: StoreOutViewMadel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(VirtualStoreViewModel::class)
    abstract fun bindVirtualStoreActivity(viewModel: VirtualStoreViewModel): ViewModel




    @Binds
    @IntoMap
    @ViewModelKey(SelfAssignViewModel::class)
    abstract fun selfAssignmentViewModel(viewModel: SelfAssignViewModel): ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(ViewReportViewModel::class)
    abstract fun viewReportViewModel(viewModel: ViewReportViewModel): ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(EngDevicePartAssignedListViewModel::class)
    abstract fun viewEngDevicePartAssignedListViewModel(viewModel: EngDevicePartAssignedListViewModel): ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(InventoryManagerPendingPartViewModel::class)
    abstract fun inventoryManagerPendingPartViewModel(pendingPartViewModel: InventoryManagerPendingPartViewModel): ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(InventoryManagerViewModel::class)
    abstract fun inventoryManagerViewModel(pendingPartViewModel: InventoryManagerViewModel): ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(InventoryManagerAssignedPartViewModel::class)
    abstract fun inventoryManagerAssignedPartViewModel(pendingPartViewModel: InventoryManagerAssignedPartViewModel): ViewModel



    @Binds
    @IntoMap
    @ViewModelKey(QCActivityViewModel::class)
    abstract fun qcActivityViewModel(pendingPartViewModel: QCActivityViewModel): ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(QCPendingPartDetailActivityViewModel::class)
    abstract fun qcPendingPartDetailActivityViewModel(pendingPartViewModel: QCPendingPartDetailActivityViewModel): ViewModel



    @Binds
    @IntoMap
    @ViewModelKey(QCPendingByBarcodeViewModel::class)
    abstract fun QCPendingByBarcodeViewModel(pendingPartViewModel: QCPendingByBarcodeViewModel): ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(QCPartBBarcodeScanActivityViewModel::class)
    abstract fun QCPartBBarcodeScanActivityViewModel(pendingPartViewModel: QCPartBBarcodeScanActivityViewModel): ViewModel



    @Binds
    @IntoMap
    @ViewModelKey(RiderActivityViewModel::class)
    abstract fun QCRiderActivityViewModel(pendingPartViewModel: RiderActivityViewModel): ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(PendingPartDeliverToEngineerViewModel::class)
    abstract fun PendingPartDeliverToEngineerViewModel(pendingPartViewModel: PendingPartDeliverToEngineerViewModel):ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(PickupPartListActivityViewmodel::class)
    abstract fun PickupPartListActivityViewmodel(pendingPartViewModel: PickupPartListActivityViewmodel):ViewModel
    @Binds
    abstract fun bindViewModelFactory(factory: TrcViewModelFactory): ViewModelProvider.Factory



    @Binds
    @IntoMap
    @ViewModelKey(IMReceiveScanActivityViewModel::class)
    abstract fun IMReceiveScanActivityViewModel(pendingPartViewModel: IMReceiveScanActivityViewModel):ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(IMPartReturnDetailViewModel::class)
    abstract fun IMPartReturnDetailViewModel(pendingPartViewModel: IMPartReturnDetailViewModel):ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(EngineerMyDevicesTabViewModel::class)
    abstract fun EngineerMyDevicesTabViewModel(pendingPartViewModel: EngineerMyDevicesTabViewModel):ViewModel



    @Binds
    @IntoMap
    @ViewModelKey(WipPartInfoctivityModel::class)
    abstract fun wipPartInfoctivityModel(pendingPartViewModel: WipPartInfoctivityModel):ViewModel

    @Binds
    @IntoMap
    @ViewModelKey(EngineerPartInfoActivityViewmodel::class)
    abstract fun engineerPartInfoActivityViewmodel(pendingPartViewModel: EngineerPartInfoActivityViewmodel):ViewModel



    @Binds
    @IntoMap
    @ViewModelKey(InventoryManagerSummaryViewModel::class)
    abstract fun inventoryManagerSummaryViewModel(pendingPartViewModel: InventoryManagerSummaryViewModel):ViewModel




    @Binds
    @IntoMap
    @ViewModelKey(InventoryManagerReturnViewModel::class)
    abstract fun InventoryManagerReturnViewModel(pendingPartViewModel: InventoryManagerReturnViewModel):ViewModel


    @Binds
    @IntoMap
    @ViewModelKey(RubbingViewModel::class)
    abstract fun rubbingViewModel(rubbingViewModel: RubbingViewModel):ViewModel




}
