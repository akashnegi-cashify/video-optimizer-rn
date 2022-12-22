package `in`.cashify.androidtrc.module.rider.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.qc.ui.QCHomeFragment
import `in`.cashify.androidtrc.module.qc.ui.QCPendingFragment
import `in`.cashify.androidtrc.module.rider.ui.delivery.RiderDeliveryFragment
import `in`.cashify.androidtrc.module.rider.ui.pickup.RiderPickupFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class RiderFragmentBBuilder: BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class , RiderDeliveryFragmentBBuilder::class])
    internal abstract fun provideRiderDeliveryFragment(): RiderDeliveryFragment
//
//
//
    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class ,  RiderPickupFragmentBBuilder::class])
    internal abstract fun provideRiderPickupFragment(): RiderPickupFragment

}