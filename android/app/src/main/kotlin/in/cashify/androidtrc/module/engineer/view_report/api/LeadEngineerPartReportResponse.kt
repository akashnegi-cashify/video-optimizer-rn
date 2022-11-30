package `in`.cashify.androidtrc.module.engineer.view_report.api

import `in`.cashify.androidtrc.common.api.BaseResponse
import com.google.gson.annotations.SerializedName

/**
 * Created by Rishika on 21/12/20.
 */
class LeadEngineerPartReportResponse : BaseResponse() {
@SerializedName("r_id")
var requestId:String? = null


    @SerializedName("dt")
    var data:Data? = null



    class Data:BaseResponse(){
        @SerializedName("lpc")
        var leadEngineerPartCost:LeadEngineerPartCost? = null

        @SerializedName("lpcon")
        var leadEngineerPartConsumption:LeadEngineerPartConsumption? = null

    }


    class LeadEngineerPartCost:BaseResponse(){
@SerializedName("mpc")
var partCost:Double? = 0.0


        @SerializedName("en")
        var engineerName:String? = ""



    }


    class LeadEngineerPartConsumption:BaseResponse(){
        @SerializedName("pcon")
        var partConsumption:Double? = 0.0


        @SerializedName("en")
        var engineerName:String? = ""
    }




}