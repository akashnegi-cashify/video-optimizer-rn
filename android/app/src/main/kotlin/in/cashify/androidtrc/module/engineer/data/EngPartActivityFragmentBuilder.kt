package `in`.cashify.androidtrc.module.engineer.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.engineer.ui.fragment.EngPartInfoFragment
import dagger.Module
import dagger.android.ContributesAndroidInjector


/**
 * Created by Avaneesh Maurya on 19,August,2019
 */
@Module
abstract class EngPartActivityFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideEngPartListFragment(): EngPartInfoFragment
}