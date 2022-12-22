package `in`.cashify.androidtrc.module.elss.data

import `in`.cashify.androidtrc.module.elss.api.response.ElssPart
import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartInfo


/**
 * Created by Avaneesh Maurya on 10,December,2019
 */
interface OnElssActionHappen {
    fun onElssActionHappen(action: ElssAction)
    fun notifyFilter(repairPartList: ArrayList<ElssPart>?)
    fun onCaptureImage(partList:ElssPart)


}