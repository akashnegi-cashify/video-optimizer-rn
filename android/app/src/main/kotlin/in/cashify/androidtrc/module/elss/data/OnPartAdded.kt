package `in`.cashify.androidtrc.module.elss.data

import `in`.cashify.androidtrc.module.engineer.api.response.DevicePartInfo


/**
 * Created by Avaneesh Maurya on 12,December,2019
 */
interface OnPartAdded {
    fun onPartAdded(partList: ArrayList<DevicePartInfo>?)
}