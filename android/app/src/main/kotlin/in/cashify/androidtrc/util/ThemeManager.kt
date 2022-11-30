package `in`.cashify.androidtrc.util

import `in`.cashify.androidtrc.R

/**
 * Created by Avaneesh Maurya on 23,Junho,2019
 */
object ThemeManager {

    const val ENGINEER: Int = 1
    const val RUNNER: Int = 2

    fun getTheme(serviceType: Int): Int {
        when (serviceType) {
            ENGINEER -> return R.style.Engineer
            RUNNER -> return R.style.Runner
        }
        return R.style.Engineer
    }

}