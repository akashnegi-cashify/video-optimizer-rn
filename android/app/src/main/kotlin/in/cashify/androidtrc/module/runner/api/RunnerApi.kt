package `in`.cashify.androidtrc.module.runner.api

import `in`.cashify.androidtrc.module.runner.api.response.device_list.DeviceListAllocatedToEng
import `in`.cashify.androidtrc.module.runner.api.response.engineer_tray.ScanRunnerTray
import `in`.cashify.androidtrc.module.runner.api.response.engineer_tray.TrayListAllocatedToEng
import `in`.cashify.androidtrc.module.runner.api.response.l4.MarkedL4PendingDeviceResponse
import `in`.cashify.androidtrc.module.runner.api.response.l4.MarkedL4PickedDeviceResponse
import `in`.cashify.androidtrc.module.runner.api.response.l4.MoveToMarkL4Tray
import `in`.cashify.androidtrc.module.runner.api.response.l4.PickMarkL4Device
import `in`.cashify.androidtrc.module.runner.api.response.marked_ok_device.*
import kotlinx.coroutines.Deferred
import retrofit2.Response
import retrofit2.http.GET
import retrofit2.http.PUT
import retrofit2.http.Query


/**
 * Created by Avaneesh Maurya on 22,July,2019
 */
interface RunnerApi {

    @GET("/runner/alloted-to-engineer")
    fun getDeviceAllocatedToEngineer(
        @Query("pickedup") isPickedUp: Boolean
    ): Deferred<Response<DeviceListAllocatedToEng>>

    @GET("/runner/engineer-tray")
    fun getTrayAllocatedToEngineer(
        @Query("eid") engineerId: String?,
        @Query("scanned") isPickedUp: Boolean
    ): Deferred<Response<TrayListAllocatedToEng>>

    @PUT("/runner/scan-tray")
    fun scanTrayToRunner(
        @Query("tbr") trayBarcode: String?
    ): Deferred<Response<ScanRunnerTray>>


    @GET("/runner/marked-ok?picked=true")
    fun getMarkedOkPickedUpDevices(
    ): Deferred<Response<MarkedOkPickedDeviceResponse>>

    @GET("/runner/marked-ok?picked=false")
    fun getMarkedOkPendingDevices(
    ): Deferred<Response<MarkedOkPendingDeviceResponse>>

    @PUT("/runner/pick-marked-ok")
    fun pickMarkOkDevice(
        @Query("dbr") DeviceBarcode: String?
    ): Deferred<Response<PickMarkOkDevice>>


    @GET("/runner/marked-l4?picked=true")
    fun getMarkedL4PickedUpDevices(
    ): Deferred<Response<MarkedL4PickedDeviceResponse>>

    @GET("/runner/marked-l4?picked=false")
    fun getMarkedL4PendingDevices(
    ): Deferred<Response<MarkedL4PendingDeviceResponse>>

    @PUT("/runner/pick-marked-l4")
    fun pickMarkL4Device(
        @Query("dbr") deviceBarcode: String
    ): Deferred<Response<PickMarkL4Device>>

    @GET("/runner/engineer-marked-ok")
    fun engineerMarkOkDevice(
        @Query("eid") engineerId: String?
    ): Deferred<Response<EngineerMarkOkDevice>>

    @GET("/runner/engineer-marked-l4")
    fun engineerMarkL4Device(
        @Query("eid") engineerId: String
    ): Deferred<Response<EngineerMarkOkDevice>>

    @PUT("/runner/add-to-mark-ok-tray")
    fun moveToMarkOkDevice(
        @Query("tbr") trayBarcode: String?,
        @Query("dbr") deviceBarcode: String?
    ): Deferred<Response<MoveToMarkOkTray>>

    @PUT("/runner/add-to-l4-tray")
    fun moveToMarkL4Device(
        @Query("tbr") trayBarcode: String,
        @Query("dbr") deviceBarcode: String
    ): Deferred<Response<MoveToMarkL4Tray>>
}