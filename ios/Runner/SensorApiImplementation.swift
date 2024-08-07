//
//  SensorApiImplementation.swift
//  Runner
//
//  Created by Aleksander Kapera on 8/2/24.
//

import Foundation
import WitSDK

class SensorApiImplementation: SensorApi, ObservableObject, IBluetoothEventObserver, IBwt901bleRecordObserver {
    
    // Get bluetooth manager
    var bluetoothManager:WitBluetoothManager = WitBluetoothManager.instance
    
    fileprivate var flutterApi: FlutterApi
    
    // Bluetooth 5.0 sensor object
    @Published
    var deviceList:[Bwt901ble] = [Bwt901ble]()
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        self.flutterApi = FlutterApi(binaryMessenger: binaryMessenger)
    }
    
    func initialize() throws {
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
    }
    
    // MARK: Notifies you here when the connection fails
    func onConnectionFailed(bluetoothBLE: BluetoothBLE?) {
        print("\(String(describing: bluetoothBLE?.peripheral.name)) failed to connect")
    }
    
    // MARK: You will be notified here when the connection is lost
    func onDisconnected(bluetoothBLE: BluetoothBLE?) {
        print("\(String(describing: bluetoothBLE?.peripheral.name)) disconnected")
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
    }
    
    
    // MARK: You will be notified here when data from the sensor needs to be recorded
    func onRecord(_ bwt901ble: Bwt901ble) {
        // You can get sensor data here
        let deviceData = getDeviceData(bwt901ble)
        flutterApi.onSensorDataRecorded(sensorData: deviceData)
    }
    
    // MARK: Get the data of the device and concatenate it into a string
    func getDeviceData(_ device:Bwt901ble) -> SensorData {
        return SensorData(name: device.name ?? "",
                          acceleration: ThreeAxisMeasurement(
                            x: Double(device.getDeviceData(WitSensorKey.AccX) ?? ""),
                            y: Double(device.getDeviceData(WitSensorKey.AccY) ?? ""),
                            z: Double(device.getDeviceData(WitSensorKey.AccZ) ?? "")),
                          angularVelocity: ThreeAxisMeasurement(
                            x: Double(device.getDeviceData(WitSensorKey.GyroX) ?? ""),
                            y: Double(device.getDeviceData(WitSensorKey.GyroY) ?? ""),
                            z: Double(device.getDeviceData(WitSensorKey.GyroZ) ?? "")),
                          magneticField: ThreeAxisMeasurement(
                            x: Double(device.getDeviceData(WitSensorKey.MagX) ?? ""),
                            y: Double(device.getDeviceData(WitSensorKey.MagY) ?? ""),
                            z: Double(device.getDeviceData(WitSensorKey.MagZ) ?? "")),
                          angle: ThreeAxisMeasurement(
                            x: Double(device.getDeviceData(WitSensorKey.AngleX) ?? ""),
                            y: Double(device.getDeviceData(WitSensorKey.AngleY) ?? ""),
                            z: Double(device.getDeviceData(WitSensorKey.AngleZ) ?? "")))
    }
}

private class FlutterApi {
    var flutterAPI: SensorFlutterApi
    
    init(binaryMessenger: FlutterBinaryMessenger) {
        flutterAPI = SensorFlutterApi(binaryMessenger: binaryMessenger)
    }
    
    func onSensorDataRecorded(sensorData: SensorData) {
        flutterAPI.onSensorDataRecorded(sensorData: sensorData) {_ in
        }
    }
}
