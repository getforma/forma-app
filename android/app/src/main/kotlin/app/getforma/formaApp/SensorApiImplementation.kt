package app.getforma.formaApp

import SensorApi
import SensorDataModel
import SensorCallbackpi
import ThreeAxisMeasurementModel
import androidx.app.Activity
import androidx.content.Context
import com.wit.witsdk.modular.sensor.device.exceptions.OpenDeviceException
import com.wit.witsdk.modular.sensor.example.ble5.Bwt901ble
import com.wit.witsdk.modular.sensor.example.ble5.interfaces.IBwt901bleRecordObserver
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.BluetoothBLE
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.BluetoothSPP
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.WitBluetoothManager
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.exceptions.BluetoothBLEException
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.interfaces.IBluetoothFoundObserver
import com.wit.witsdk.modular.sensor.modular.processor.constant.WitSensorKey
import io.flutter.plugin.common.BinaryMessenger


class SensorApiImplementation private constructor(
    private val context: Context,
    messenger: BinaryMessenger,
    activity: Activity,
) : SensorApi,
    IBluetoothFoundObserver, IBwt901bleRecordObserver {

    /**
     * Device List
     */
    private val bwt901bleList: MutableList<Bwt901ble> = mutableListOf()

    private val flutterApi = FlutterApi(messenger, activity)

    companion object {

        @Volatile
        private var instance: SensorApi? = null

        fun getInstance(context: Context, messenger: BinaryMessenger, activity: Activity) =
            instance ?: synchronized(this) {
                instance ?: SensorApiImplementation(context, messenger, activity).also {
                    instance = it
                }
            }
    }

    override fun initialize() {
        WitBluetoothManager.initInstance(context)
    }

    override fun startDiscovery() {
        // Turn off all device
        bwt901bleList.forEach {
            it.removeRecordObserver(this)
            it.close()
        }

        // Erase all devices
        bwt901bleList.clear()

        // Start searching for bluetooth
        try {
            // get bluetooth manager
            val bluetoothManager = WitBluetoothManager.getInstance()

            // Monitor communication signals
            bluetoothManager.registerObserver(this)

            // Specify the Bluetooth name to search for
//            WitBluetoothManager.DeviceNameFilter = ["WT"]

            // start search
            bluetoothManager.startDiscovery()
        } catch (e: BluetoothBLEException) {
            e.printStackTrace()
        }
    }

    override fun onFoundBle(bluetoothBLE: BluetoothBLE?) {
        // Create a Bluetooth 5.0 sensor connection object
        val bwt901ble = Bwt901ble(bluetoothBLE)

        for (i in bwt901bleList.indices) {
            if (bwt901bleList[i].deviceName == bwt901ble.deviceName) {
                return
            }
        }

        // add to device list
        bwt901bleList.add(bwt901ble)

        // Registration data record
        bwt901ble.registerRecordObserver(this)

        // Turn on the device
        try {
            bwt901ble.open()
            setSensorFrequency(bwt901ble)
        } catch (e: OpenDeviceException) {
            // Failed to open device
            e.printStackTrace()
        }
    }

    override fun onFoundSPP(p0: BluetoothSPP?) {
        // Our sensor connects only via Bluetooth 5.0. This method is used for Bluetooth 2.0.
    }

    /**
     * This method will be called back when data needs to be recorded
     */
    override fun onRecord(bwt901ble: Bwt901ble?) {
        val deviceData = getDeviceData(bwt901ble) ?: return
        flutterApi.onSensorDataRecorded(sensorData = deviceData)
//        Log.d(
//            MainActivity::class.java.simpleName,
//            "device data = $deviceData"
//        )
    }

    private fun getDeviceData(bwt901ble: Bwt901ble?): SensorDataModel? {
        if (bwt901ble == null) {
            return null
        }

        return SensorDataModel(
            name = bwt901ble.deviceName,
            acceleration = ThreeAxisMeasurementModel(
                x = bwt901ble.getDeviceData(WitSensorKey.AccX)?.toDoubleOrNull(),
                y = bwt901ble.getDeviceData(WitSensorKey.AccY)?.toDoubleOrNull(),
                z = bwt901ble.getDeviceData(WitSensorKey.AccZ)?.toDoubleOrNull(),
            ),
            angularVelocity = ThreeAxisMeasurementModel(
                x = bwt901ble.getDeviceData(WitSensorKey.AsX)?.toDoubleOrNull(),
                y = bwt901ble.getDeviceData(WitSensorKey.AsY)?.toDoubleOrNull(),
                z = bwt901ble.getDeviceData(WitSensorKey.AsZ)?.toDoubleOrNull(),
            ),
            magneticField = ThreeAxisMeasurementModel(
                x = bwt901ble.getDeviceData(WitSensorKey.HX)?.toDoubleOrNull(),
                y = bwt901ble.getDeviceData(WitSensorKey.HY)?.toDoubleOrNull(),
                z = bwt901ble.getDeviceData(WitSensorKey.HZ)?.toDoubleOrNull(),
            ),
            angle = ThreeAxisMeasurementModel(
                x = bwt901ble.getDeviceData(WitSensorKey.AngleX)?.toDoubleOrNull(),
                y = bwt901ble.getDeviceData(WitSensorKey.AngleY)?.toDoubleOrNull(),
                z = bwt901ble.getDeviceData(WitSensorKey.AngleZ)?.toDoubleOrNull(),
            )
        )
    }

    private fun setSensorFrequency(bwt901ble: Bwt901ble) {
        /**
         * 0x01：0.1Hz
         * 0x02：0.5Hz
         * 0x03：1Hz
         * 0x04：2Hz
         * 0x05：5Hz
         * 0x06：10Hz（default）
         * 0x07：20Hz
         * 0x08：50Hz
         * 0x09：100Hz
         * 0x0A：200Hz
         */
        bwt901ble.setReturnRate(0x08)
    }
}

private class FlutterApi(messenger: BinaryMessenger, val activity: Activity) {

    val flutterApi: SensorCallbackpi = SensorCallbackApi(messenger)

    fun onSensorDataRecorded(sensorData: SensorData) {
        activity.runOnUiThread {
            flutterApi.onSensorDataRecorded(sensorData) { _ -> }
        }
    }
}
