package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.engineer.ui.fragment.EngDeviceListFragment
import `in`.cashify.androidtrc.module.inventory_manager.fragment.InventoryManagerSummaryFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class InventoryManagerSummaryFragmentBBuilder() : BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun inventoryManagerSummaryFragment(): InventoryManagerSummaryFragment
}