package `in`.cashify.androidtrc.module.engineer.view_report.data

import `in`.cashify.androidtrc.common.BaseActivityFragmentBuilder
import `in`.cashify.androidtrc.common.dagger.FragmentBuilderModule
import `in`.cashify.androidtrc.module.engineer.ui.fragment.SelfAssignPartFragment
import `in`.cashify.androidtrc.module.engineer.view_report.ui.fragment.ViewDeviceReportFragment
import `in`.cashify.androidtrc.module.engineer.view_report.ui.fragment.ViewPartReportFragment

import dagger.Module
import dagger.android.ContributesAndroidInjector

/**
 * Created by Rishika on 04/12/20.
 */
@Module
abstract class ViewReportFragmentBuilder : BaseActivityFragmentBuilder() {

    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideSelfAssignFragment(): ViewDeviceReportFragment


    @ContributesAndroidInjector(modules = [FragmentBuilderModule::class])
    internal abstract fun provideViewPartReportFragment(): ViewPartReportFragment
}