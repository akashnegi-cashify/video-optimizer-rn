package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedOkPendingFragment
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedOkPickedFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class MarkOkActivityFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun providePickedFragment(): MarkedOkPickedFragment

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun providePendingFragment(): MarkedOkPendingFragment
}
