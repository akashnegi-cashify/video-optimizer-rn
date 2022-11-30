package `in`.cashify.androidtrc.common


/**
 * Created by Avaneesh Maurya on 25,July,2019
 */
interface OnResult<T> {
    fun  onResultAvailable(data: T)
}