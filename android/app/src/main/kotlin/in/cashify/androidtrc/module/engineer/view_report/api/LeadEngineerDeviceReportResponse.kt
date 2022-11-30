package `in`.cashify.androidtrc.module.engineer.view_report.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 21/12/20.
 */
class LeadEngineerDeviceReportResponse : BaseResponse() {


    @SerializedName("r_id")
    var requestId: String? = null

    @SerializedName("dt")
    var data: Data? = null


    class Data : BaseResponse() {

        @SerializedName("leff")
        var leadEngineerEfficieny: LeadEngineerEfficiency? = null
        @SerializedName("lrt")
        var leadEngineerAvgRepairTime: LeadEngineerAvgRepairTime? = null
        @SerializedName("lv")
        var leadEngineerVolume: LeadEngineerVolume? = null


    }


    class LeadEngineerEfficiency : BaseResponse() {

        @SerializedName("meff")
        var efficieny: Double? = 0.0


        @SerializedName("en")
        var engineerName: String? = ""

    }


    class LeadEngineerAvgRepairTime : BaseResponse(){
        @SerializedName("mrt")
        var repairTime: Long? = 0


        @SerializedName("en")
        var engineerName: String? = ""
    }


    class LeadEngineerVolume : BaseResponse(){
        @SerializedName("mv")
        var volume: Int? = 0


        @SerializedName("en")
        var engineerName: String? = ""
    }







}
