package `in`.cashify.androidtrc.module.rider.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.rider.ui.delivery.RiderDeliveryFragment
import `in`.cashify.androidtrc.module.rider.ui.pickup.PartsDeliverToIM
import `in`.cashify.androidtrc.module.rider.ui.pickup.RiderPickerReceiveFragment
import `in`.cashify.androidtrc.module.rider.ui.pickup.RiderPickupFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class RiderPickupFragmentBBuilder : BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideRiderPickerReceiveFragment(): RiderPickerReceiveFragment
//
//
//
    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideRiderPickupFragment(): PartsDeliverToIM

}