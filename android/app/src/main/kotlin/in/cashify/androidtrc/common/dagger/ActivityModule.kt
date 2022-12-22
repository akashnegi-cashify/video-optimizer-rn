package `in`.cashify.androidtrc.common.dagger

import `in`.cashify.androidtrc.common.BaseActivity
import android.content.Context
import androidx.fragment.app.FragmentManager
import dagger.Module
import dagger.Provides

@Module
public abstract class ActivityModule {

@Module
    companion object{
    @JvmStatic
    @Provides
    fun provideContext(activity: BaseActivity): Context {
        return activity.getApplicationContext()
    }

    @JvmStatic
    @Provides
    fun provideFragmentManager(activity: BaseActivity): FragmentManager {
        return activity.getSupportFragmentManager()
    }
}}