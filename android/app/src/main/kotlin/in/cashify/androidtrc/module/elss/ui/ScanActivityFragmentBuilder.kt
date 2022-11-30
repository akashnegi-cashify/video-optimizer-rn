package `in`.cashify.androidtrc.module.elss.ui

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.elss.ui.fragment.DetailSelectionFragment
import `in`.cashify.androidtrc.module.elss.ui.fragment.ScanElssBarcodeFragment
import `in`.cashify.androidtrc.module.runner.ui.fragment.DeviceAllocatedFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class ScanActivityFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideDetailSelectionFragment(): DetailSelectionFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideScanElssBarcodeFragment(): ScanElssBarcodeFragment
}
