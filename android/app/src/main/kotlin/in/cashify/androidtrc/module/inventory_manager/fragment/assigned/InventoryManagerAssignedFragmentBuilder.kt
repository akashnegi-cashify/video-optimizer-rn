package `in`.cashify.androidtrc.module.inventory_manager.fragment.assigned

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule

import dagger.Module
import dagger.android.ContributesAndroidInjector


@Module
abstract class InventoryManagerAssignedFragmentBuilder : BaseActivityFragmentBuilder() {


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMAssignedDeviceDetailsFragmentt(): IMAssignedDeviceDetailsFragment



    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideIMAssignedPartDetailsFragment(): IMAssignedPartDetailsFragment

}