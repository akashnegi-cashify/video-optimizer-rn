package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.common.fragment.BarcodeScannerFragment
import `in`.cashify.androidtrc.module.runner.ui.fragment.TrayFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class TrayListActivityFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideTrayFragment(): TrayFragment

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideScannerFragment(): BarcodeScannerFragment
}
