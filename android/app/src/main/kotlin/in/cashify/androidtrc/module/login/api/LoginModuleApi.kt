package `in`.cashify.androidtrc.module.login.api

import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.Body
import retrofit2.http.POST

interface LoginModuleApi {

    @POST("/login")
    fun loginWithPasswordAsync(
        @Body request: PasswordLoginRequest
    ): Deferred<Response<PasswordLoginResponse>>

    @POST("/user/change-password")
    fun changePasswordAsync(
        @Body request: ChangePasswordRequest
    ): Deferred<Response<ChangePasswordResponse>>

    @POST("/logout")
    fun logoutAsync(): Deferred<Response<LogOutResponse>>

}