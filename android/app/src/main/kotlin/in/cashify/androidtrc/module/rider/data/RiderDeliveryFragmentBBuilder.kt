package `in`.cashify.androidtrc.module.rider.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.rider.ui.delivery.RiderDeliveryDeliverFragment
import `in`.cashify.androidtrc.module.rider.ui.delivery.RiderDeliveryFragment
import `in`.cashify.androidtrc.module.rider.ui.delivery.RiderDeliveryReceiveFragment

import `in`.cashify.androidtrc.module.rider.ui.pickup.RiderPickupFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class RiderDeliveryFragmentBBuilder : BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class , RiderDeliveryFrgamentBBiuilder::class])
    internal abstract fun provideRiderDeliveryFragment(): RiderDeliveryDeliverFragment
//
//
//
    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideRiderPickupFragment(): RiderDeliveryReceiveFragment
//
//
//
//
//
//    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
//    internal abstract fun RiderPickupDeliverFragment(): RiderPickupDeliverFragment

}