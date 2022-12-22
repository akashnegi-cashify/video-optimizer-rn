package `in`.cashify.androidtrc.module.inventory_manager.fragment.receive

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.rider.data.RiderDeliveryFragmentBBuilder
import `in`.cashify.androidtrc.module.rider.data.RiderPickupFragmentBBuilder
import `in`.cashify.androidtrc.module.rider.ui.delivery.RiderDeliveryFragment
import `in`.cashify.androidtrc.module.rider.ui.pickup.RiderPickupFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector


@Module
abstract  class IMReceiveFragmentBuilder:BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class ])
    internal abstract fun provideIMReceiveScanFragment(): IMReceiveScanFragment
    //
//
//
    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMReceivePartListFragment(): IMReceivePartListFragment
}