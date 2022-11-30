package `in`.cashify.androidtrc.module.inventory_manager

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.inventory_manager.fragment.pending.IMPendingPartDeliveryFragment
import `in`.cashify.androidtrc.module.inventory_manager.fragment.receive.IMReceiveFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector


@Module
abstract class InventoryManagerRequestsFragmnetBuilder  : BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun IMPendingPartDeliveryFragment(): IMPendingPartDeliveryFragment


}