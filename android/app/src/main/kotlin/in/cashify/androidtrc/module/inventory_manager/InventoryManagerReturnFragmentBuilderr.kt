package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.BaseViewModel
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.inventory_manager.fragment.InventoryManagerSummaryFragment
import `in`.cashify.androidtrc.module.inventory_manager.fragment.receive.IMReceiveFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector
import javax.inject.Inject

@Module
abstract class InventoryManagerReturnFragmentBuilderr  : BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun IMReceiveFragment(): IMReceiveFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun IMPartListReturnFragment(): IMPartListReturnFragment
}