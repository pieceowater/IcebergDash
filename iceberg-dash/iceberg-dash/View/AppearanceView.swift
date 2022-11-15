//
//  AppIconView.swift
//  iceberg-dash
//
//  Created by yury mid on 07.11.2022.
//

import SwiftUI

struct AppearanceView: View {
    @EnvironmentObject private var defaultsManager: UserDefaultsManagerViewModel
    @AppStorage("appIcon") private var appIcon: String = ""
    @State var appIcons = ["AppIcon", "Dark", "Retro-Classic", "Retro-Dark"]
    
    private let colorsListNames:[String : String] = [
        "AccentColor":LocalizedStringKey("Default").stringValue(),
        "AccentRed":LocalizedStringKey("Red").stringValue(),
        "AccentYellow":LocalizedStringKey("Yellow").stringValue(),
        "AccentGreen":LocalizedStringKey("Green").stringValue(),
        "AccentOrange":LocalizedStringKey("Orange").stringValue()
    ]
    private let colorsList:[String] = [
        "AccentColor",
        "AccentRed",
        "AccentYellow",
        "AccentGreen",
        "AccentOrange"
    ]

    var body: some View {
        ScrollView {
            HStack{
                Text("Accent color")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(spacing: 20) {
                ForEach(colorsList, id: \.self) { color in
                    HStack{
                        Color(color)
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                        Text(colorsListNames[color]!)
                            .font(.headline)
                        Spacer()
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .onTapGesture {
                        defaultsManager.saveStringValue(key: "accentColor", value: color)
                        defaultsManager.refreshAccentColor()
                        haptic(force: 1)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.bottom, 10)
            .padding(.horizontal)
            
            HStack{
                Text("App icon")
                    .font(.headline)
                Spacer()
            }
            .padding(.horizontal)
            
            VStack(spacing: 20) {
                ForEach(appIcons, id: \.self) { icon in
                    HStack{
                        Image("\(icon == "AppIcon" ? "Classic" : icon )-icon")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .cornerRadius(8)
                            .shadow(color: Color.black.opacity(0.1), radius: 5)
                        Text("\(icon == "AppIcon" ? "Classic" : icon) Iceberg")
                            .font(.headline)
                        Spacer()
                    }
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(15)
                    .onTapGesture {
                        UIApplication.shared.setAlternateIconName(icon == "AppIcon" ? nil : icon)
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.bottom, 10)
            .padding(.horizontal)
        
        }
        .background(Color.bg)
        .navigationTitle("Appearance")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        AppearanceView()
    }
}
