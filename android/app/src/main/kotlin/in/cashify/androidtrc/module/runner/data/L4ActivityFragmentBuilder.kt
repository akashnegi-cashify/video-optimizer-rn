package `in`.cashify.androidtrc.module.runner.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedL4PendingFragment
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedL4PickedFragment
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedOkPendingFragment
import `in`.cashify.androidtrc.module.runner.ui.fragment.MarkedOkPickedFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector

@Module
abstract class L4ActivityFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideL4PickedFragment(): MarkedL4PickedFragment

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideL4PendingFragment(): MarkedL4PendingFragment
}
