//
//  MainView.swift
//  iceberg-dash
//
//  Created by yury mid on 05.11.2022.
//

import SwiftUI
//import Drops

struct MainView: View {
    @EnvironmentObject private var defaultsManager: UserDefaultsManagerViewModel
    @EnvironmentObject private var locationManager: LocationManager
    
    @State private var img: Image = Image("IconStroke")
    @State private var imgName: String = "ICEBRG"
    @State private var isImageShown: Bool = false
    
    var body: some View {
        if (defaultsManager.CrmUserToken.isEmpty){
            AuthView()
                .environmentObject(locationManager)
                .environmentObject(defaultsManager)
        }else{
            TabView{
                NavigationView {
                    DashboardView()
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                        .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                            .onEnded({ value in
                                if ((value.translation.height > 0) || (value.translation.height < 0)){
                                    UIApplication.shared.endEditing()
                                }
                            }))
                }
                .navigationBarTitleDisplayMode(.inline)
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("Orders")
                }
                NavigationView {
                    TasksView()
                }
                .tabItem {
                    Image(systemName: "checkmark.circle")
                    Text("Tasks")
                }
                MapView()
                    .environmentObject(locationManager)
                    .tabItem {
                        Image(systemName: "map")
                        Text("Map")
                    }
                NavigationView {
                    MessagesView()
                }
                .tabItem {
                    Image(systemName: "message.fill")
                    Text("Messages")
                }
                NavigationView {
                    ProfileMenuView()
                }
                .tabItem {
                    Image(systemName: "person.crop.circle.fill")
                    Text("Profile")
                }
                
                
            }
            .background(Color.bg)
            .ignoresSafeArea()
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(LocationManager())
    }
}

extension MainView {
    
}
