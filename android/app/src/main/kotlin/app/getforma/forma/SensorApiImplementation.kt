package app.getforma.forma

import SensorApi
import SensorData
import android.content.Context
import android.util.Log
import com.wit.witsdk.modular.sensor.device.exceptions.OpenDeviceException
import com.wit.witsdk.modular.sensor.example.ble5.Bwt901ble
import com.wit.witsdk.modular.sensor.example.ble5.interfaces.IBwt901bleRecordObserver
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.BluetoothBLE
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.BluetoothSPP
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.WitBluetoothManager
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.exceptions.BluetoothBLEException
import com.wit.witsdk.modular.sensor.modular.connector.modular.bluetooth.interfaces.IBluetoothFoundObserver
import com.wit.witsdk.modular.sensor.modular.processor.constant.WitSensorKey


class SensorApiImplementation private constructor(private val context: Context) : SensorApi,
    IBluetoothFoundObserver, IBwt901bleRecordObserver {

    /**
     * Device List
     */
    private val bwt901bleList: MutableList<Bwt901ble> = mutableListOf()

    companion object {

        @Volatile
        private var instance: SensorApi? = null

        fun getInstance(context: Context) =
            instance ?: synchronized(this) {
                instance ?: SensorApiImplementation(context).also { instance = it }
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

    override fun getSensorData(callback: (Result<SensorData>) -> Unit) {
        callback(Result.success(SensorData(temperature = 69.0, humidity = 420.0)))
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
        val deviceData: String = getDeviceData(bwt901ble)
        Log.d(
            MainActivity::class.java.simpleName,
            "device data [ " + bwt901ble?.deviceName + "] = " + deviceData
        )
    }

    private fun getDeviceData(bwt901ble: Bwt901ble?): String {
        if (bwt901ble == null) {
            return ""
        }

        val builder = StringBuilder()
        builder.append(bwt901ble.deviceName).append("\n")
        builder.append(context.getString(R.string.accX)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.AccX)).append("g \t")
        builder.append(context.getString(R.string.accY)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.AccY)).append("g \t")
        builder.append(context.getString(R.string.accZ)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.AccZ)).append("g \n")
        builder.append(context.getString(R.string.asX)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.AsX)).append("°/s \t")
        builder.append(context.getString(R.string.asY)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.AsY)).append("°/s \t")
        builder.append(context.getString(R.string.asZ)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.AsZ)).append("°/s \n")
        builder.append(context.getString(R.string.angleX)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.AngleX)).append("° \t")
        builder.append(context.getString(R.string.angleY)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.AngleY)).append("° \t")
        builder.append(context.getString(R.string.angleZ)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.AngleZ)).append("° \n")
        builder.append(context.getString(R.string.hX)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.HX)).append("\t")
        builder.append(context.getString(R.string.hY)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.HY)).append("\t")
        builder.append(context.getString(R.string.hZ)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.HZ)).append("\n")
        builder.append(context.getString(R.string.t)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.T)).append("\n")
        builder.append(context.getString(R.string.electricQuantityPercentage)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.ElectricQuantityPercentage)).append("\n")
        builder.append(context.getString(R.string.versionNumber)).append(":")
            .append(bwt901ble.getDeviceData(WitSensorKey.VersionNumber)).append("\n")
        return builder.toString()
    }
}
