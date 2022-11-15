//
//  MapView.swift
//  iceberg-dash
//
//  Created by yury mid on 05.11.2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapView: View {
    
    @EnvironmentObject private var locationManager: LocationManager
    
    var body: some View {
        mapBlock
            .overlay {
                infoBlock
                    .frame(width: 250, height: 150)
                    .shadow(color: Color.black.opacity(0.1), radius: 5)
            }
            .ignoresSafeArea()
    }
        
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

extension MapView {
    private var infoBlock: some View {
        VStack(alignment: .center, spacing: 10){
            Text("The map is unavailable.")
                .font(.headline)
            Text("At the moment, this functionality is in development!")
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: 200)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
    
    private var mapBlock: some View {
        ZStack{
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
