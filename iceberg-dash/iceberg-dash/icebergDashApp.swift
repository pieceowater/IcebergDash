//
//  iceberg_dashApp.swift
//  iceberg-dash
//
//  Created by yury mid on 05.11.2022.
//

import SwiftUI

@main
struct iceberg_dashApp: App {
    
    @StateObject private var defaultsManager = UserDefaultsManagerViewModel()
    @StateObject private var locationManager = LocationManager()
    ///temp
    @StateObject var dataModel = DataModel()
    
///    @StateObject private var networkManager = NetworkManagerViewModel()
    
    var body: some Scene {
        WindowGroup {
            
///                AuthView()
///                    .environmentObject(locationManager)
///                    .environmentObject(defaultsManager)
///            }else{
                MainView().accentColor(Color(defaultsManager.UDAccentColor))
                    .environmentObject(locationManager)
                    .environmentObject(defaultsManager)
                    ///temp
                    .environmentObject(dataModel)
                    .onAppear{
///                        networkManager.postData(result: "123")
                    }
///            }
        }
    }
}
