//
//  UserDefaultsManagerViewModel.swift
//  iceberg-dash
//
//  Created by yury mid on 12.11.2022.
//

import Foundation
import SwiftUI

class UserDefaultsManagerViewModel: ObservableObject {
    private let userDefaults = UserDefaults.standard
    
    @Published var UDAccentColor: String = "AccentColor"
    @Published var CrmUserToken: String = ""
    @Published var LocalQrList: QrItemList = QrItemList(qrItems: [])
    
    init() {
        self.UDAccentColor = getStringValue(key: "accentColor").isEmpty ? "AccentColor" : getStringValue(key: "accentColor")
        self.CrmUserToken = getStringValue(key: "token")
        self.LocalQrList = getQrList()
    }
    
    public func refreshAccentColor(){
        self.UDAccentColor = getStringValue(key: "accentColor").isEmpty ? "AccentColor" : getStringValue(key: "accentColor")
    }
    
    public func refreshCrmUserToken(){
        self.CrmUserToken = getStringValue(key: "token")
    }
    
    public func getStringValue(key: String) -> String {
        return userDefaults.string(forKey: key) ?? ""
    }
    
    public func saveStringValue(key: String, value: String) {
        userDefaults.set(value, forKey: key)
    }
    
    public func removeByKey(key:String){
        userDefaults.removeObject(forKey: key)
    }
   
    public func refreshQrList(){
        self.LocalQrList = getQrList()
    }
    
    public func getQrList() -> QrItemList{
        var qrList: QrItemList = QrItemList(qrItems: [])
        do{
            if let data = userDefaults.data(forKey: "localQrList") {
                qrList = try JSONDecoder().decode(QrItemList.self, from: data)
            }
        } catch let error {
            print("Error decoding: \(error)")
        }
        return qrList
    }
    
    public func saveQrList(value: QrItemList){
        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: "localQrList")
        } catch let error {
            print("Error encoding: \(error)")
        }
        refreshQrList()
    }
    
}
