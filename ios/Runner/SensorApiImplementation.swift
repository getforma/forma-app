//
//  SensorApiImplementation.swift
//  Runner
//
//  Created by Aleksander Kapera on 10/13/24.
//

import Foundation
import CoreBluetooth

class SensorApiImplementation: NSObject, SensorApi, ObservableObject, IBluetoothEventObserver, IBwt901bleRecordObserver, CBCentralManagerDelegate {
    
    // Get bluetooth manager
    var bluetoothManager: WitBluetoothManager = WitBluetoothManager.instance
    private var centralManager: CBCentralManager!
    private var stateCallback: ((Result<Bool, Error>) -> Void)?
    
    fileprivate var flutterApi: FlutterApi
    
    // Bluetooth 5.0 sensor object
    @Published
    var deviceList:[Bwt901ble] = [Bwt901ble]()
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.flutterApi = FlutterApi(binaryMessenger: binaryMessenger)
    }
    
    func initialize(completion: @escaping (Result<Bool, Error>) -> Void) {
        centralManager = CBCentralManager(delegate: self, queue: nil)
        self.stateCallback = completion
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
            case .poweredOn:
                stateCallback?(Result.success(true))
                break
            default:
                stateCallback?(Result.success(false))
                break
        }
    }
    
    func startDiscovery() throws {
        print("Start scanning for surrounding bluetooth devices")
        // Remove all devices, here all devices are turned off and removed from the list
        removeAllDevice()
        
        // Registering a Bluetooth event observer
        self.bluetoothManager.registerEventObserver(observer: self)
        
        // Turn on bluetooth scanning
        self.bluetoothManager.startScan()
    }
    
    // MARK: This method is called if a Bluetooth Low Energy sensor is found
    func onFoundBle(bluetoothBLE: BluetoothBLE?) {
        if isNotFound(bluetoothBLE) {
            print("\(String(describing: bluetoothBLE?.peripheral.name)) found a bluetooth device")
            self.deviceList.append(Bwt901ble(bluetoothBLE: bluetoothBLE))
            openDevice(bwt901ble: Bwt901ble(bluetoothBLE: bluetoothBLE))
        }
    }
    
    // Judging that the device has not been found
    func isNotFound(_ bluetoothBLE: BluetoothBLE?) -> Bool{
        for device in deviceList {
            if device.mac == bluetoothBLE?.mac {
                return false
            }
        }
        return true
    }
    
    // MARK: You will be notified here when the connection is successful
    func onConnected(bluetoothBLE: BluetoothBLE?) {
        print("\(String(describing: bluetoothBLE?.peripheral.name)) connected")
        flutterApi.onSensorConnected(isConnected: true)
    }
    
    // MARK: Notifies you here when the connection fails
    func onConnectionFailed(bluetoothBLE: BluetoothBLE?) {
        print("\(String(describing: bluetoothBLE?.peripheral.name)) failed to connect")
        flutterApi.onSensorConnected(isConnected: false)
    }
    
    // MARK: You will be notified here when the connection is lost
    func onDisconnected(bluetoothBLE: BluetoothBLE?) {
        print("\(String(describing: bluetoothBLE?.peripheral.name)) disconnected")
        flutterApi.onSensorConnected(isConnected: false)
    }
    
    // MARK: Stop scanning for devices
    func stopScan(){
        self.bluetoothManager.removeEventObserver(observer: self)
        self.bluetoothManager.stopScan()
    }
    
    func openDevice(bwt901ble: Bwt901ble?){
        print("Turn on the device")
        
        do {
            try bwt901ble?.openDevice()
            
            // Monitor data
            bwt901ble?.registerListenKeyUpdateObserver(obj: self)
            
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
            try bwt901ble?.unlockReg()
            try bwt901ble?.writeRge([0xff ,0xaa, 0x03, 0x08, 0x00], 10)
            try bwt901ble?.saveReg()
        }
        catch{
            print("Failed to open device")
        }
    }
    
    // MARK: Remove all devices
    func removeAllDevice(){
        for item in deviceList {
            closeDevice(bwt901ble: item)
        }
        deviceList.removeAll()
    }
    
    // MARK: Turn off the device
    func closeDevice(bwt901ble: Bwt901ble?){
        print("Turn off the device")
        bwt901ble?.closeDevice()
        flutterApi.onSensorConnected(isConnected: false)
    }
    
    
    // MARK: You will be notified here when data from the sensor needs to be recorded
    func onRecord(_ bwt901ble: Bwt901ble) {
        // You can get sensor data here
        let deviceData = getDeviceData(bwt901ble)
        flutterApi.onSensorDataRecorded(sensorData: deviceData)
    }
    
    // MARK: Get the data of the device and concatenate it into a string
    func getDeviceData(_ device:Bwt901ble) -> SensorDataModel {
        return SensorDataModel(name: device.name ?? "",
                          acceleration: ThreeAxisMeasurementModel(
                            x: Double(device.getDeviceData(WitSensorKey.AccX) ?? ""),
                            y: Double(device.getDeviceData(WitSensorKey.AccY) ?? ""),
                            z: Double(device.getDeviceData(WitSensorKey.AccZ) ?? "")),
                          angularVelocity: ThreeAxisMeasurementModel(
                            x: Double(device.getDeviceData(WitSensorKey.GyroX) ?? ""),
                            y: Double(device.getDeviceData(WitSensorKey.GyroY) ?? ""),
                            z: Double(device.getDeviceData(WitSensorKey.GyroZ) ?? "")),
                          magneticField: ThreeAxisMeasurementModel(
                            x: Double(device.getDeviceData(WitSensorKey.MagX) ?? ""),
                            y: Double(device.getDeviceData(WitSensorKey.MagY) ?? ""),
                            z: Double(device.getDeviceData(WitSensorKey.MagZ) ?? "")),
                          angle: ThreeAxisMeasurementModel(
                            x: Double(device.getDeviceData(WitSensorKey.AngleX) ?? ""),
                            y: Double(device.getDeviceData(WitSensorKey.AngleY) ?? ""),
                            z: Double(device.getDeviceData(WitSensorKey.AngleZ) ?? "")))
    }
}

private class FlutterApi {
    var flutterAPI: SensorCallbackApi
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        flutterAPI = SensorCallbackApi(binaryMessenger: binaryMessenger)
    }
    
    func onSensorDataRecorded(sensorData: SensorDataModel) {
        flutterAPI.onSensorDataRecorded(sensorData: sensorData) {_ in
        }
    }
    
    func onSensorConnected(isConnected: Bool){
        flutterAPI.onSensorConnected(isConnected: isConnected) {_ in
        }
    }
}
