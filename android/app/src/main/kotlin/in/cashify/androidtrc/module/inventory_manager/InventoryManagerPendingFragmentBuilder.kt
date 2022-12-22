package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.inventory_manager.fragment.pending.*
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class   InventoryManagerPendingFragmentBuilder : BaseActivityFragmentBuilder() {


//    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
//    internal abstract fun provideIMPendingPartDeliveryFragment(): IMPendingPartDeliveryFragment

//    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
//    internal abstract fun provideIMPartAssignedFragment(): IMPartAssignedFragment




//    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
//    internal abstract fun provideIMPartReturnFragment(): IMPartReturnFragment
//
//
//    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
//    internal abstract fun provideInventoryManagerTabFragment(): InventoryManagerTabFragment



    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMPendingDeviceDetailsFragment(): IMPendingDeviceDetailsFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMPendingDevicePartDetailsFragment(): IMPendingDevicePartDetailsFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMPendingPartBarcodeScannedFragment(): IMPendingPartBarcodeScannedFragment





    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMPendingAlternatePartFragment(): IMPendingAlternatePartFragment




    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMPendingPartBarcodeAssignedFragment(): IMPendingPartBarcodeAssignedFragment








}