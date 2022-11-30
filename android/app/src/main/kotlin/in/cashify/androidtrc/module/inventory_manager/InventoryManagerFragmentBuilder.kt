package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.inventory_manager.fragment.InventoryManagerSummaryFragment
import `in`.cashify.androidtrc.module.inventory_manager.fragment.pending.*
import `in`.cashify.androidtrc.module.inventory_manager.fragment.receive.IMReceiveFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class  InventoryManagerFragmentBuilder:BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMPendingPartDeliveryFragment(): IMPendingPartDeliveryFragment

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMPartAssignedFragment(): IMDeviceAssignedFragment




    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMPartReturnFragment(): IMPartListReturnFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideInventoryManagerTabFragment(): InventoryManagerTabFragment



    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMReceiveFragment(): IMReceiveFragment



    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideInventoryManagerSummaryFragment(): InventoryManagerSummaryFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMPendingEngineersFragment(): IMPendingEngineersFragment


}