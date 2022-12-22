package `in`.cashify.androidtrc.module.login.data

import `in`.cashify.androidtrc.module.login.api.UserDetailResponse

interface LoginProcessListener {
    abstract fun performVerification()
    abstract fun onCompleteLogin(credentials: UserDetailResponse)
}