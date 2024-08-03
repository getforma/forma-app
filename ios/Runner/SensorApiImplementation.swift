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
    
    // Bluetooth 5.0 sensor object
    @Published
    var deviceList:[Bwt901ble] = [Bwt901ble]()
        
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
    
    func getSensorData(completion: @escaping (Result<SensorData, Error>) -> Void) {
        
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
        let deviceData =  getDeviceDataToString(bwt901ble)
        
        // Prints to the console, where you can also log the data to your file
        print(deviceData)
    }
    
    // MARK: Get the data of the device and concatenate it into a string
    func getDeviceDataToString(_ device:Bwt901ble) -> String {
        var s = ""
        s  = "\(s)name:\(device.name ?? "")\r\n"
        s  = "\(s)mac:\(device.mac ?? "")\r\n"
        s  = "\(s)version:\(device.getDeviceData(WitSensorKey.VersionNumber) ?? "")\r\n"
        s  = "\(s)AX:\(device.getDeviceData(WitSensorKey.AccX) ?? "") g\r\n"
        s  = "\(s)AY:\(device.getDeviceData(WitSensorKey.AccY) ?? "") g\r\n"
        s  = "\(s)AZ:\(device.getDeviceData(WitSensorKey.AccZ) ?? "") g\r\n"
        s  = "\(s)GX:\(device.getDeviceData(WitSensorKey.GyroX) ?? "") °/s\r\n"
        s  = "\(s)GY:\(device.getDeviceData(WitSensorKey.GyroY) ?? "") °/s\r\n"
        s  = "\(s)GZ:\(device.getDeviceData(WitSensorKey.GyroZ) ?? "") °/s\r\n"
        s  = "\(s)AngX:\(device.getDeviceData(WitSensorKey.AngleX) ?? "") °\r\n"
        s  = "\(s)AngY:\(device.getDeviceData(WitSensorKey.AngleY) ?? "") °\r\n"
        s  = "\(s)AngZ:\(device.getDeviceData(WitSensorKey.AngleZ) ?? "") °\r\n"
        s  = "\(s)HX:\(device.getDeviceData(WitSensorKey.MagX) ?? "") μt\r\n"
        s  = "\(s)HY:\(device.getDeviceData(WitSensorKey.MagY) ?? "") μt\r\n"
        s  = "\(s)HZ:\(device.getDeviceData(WitSensorKey.MagZ) ?? "") μt\r\n"
        s  = "\(s)Electric:\(device.getDeviceData(WitSensorKey.ElectricQuantityPercentage) ?? "") %\r\n"
        s  = "\(s)Temp:\(device.getDeviceData(WitSensorKey.Temperature) ?? "") °C\r\n"
        return s
    }
}
