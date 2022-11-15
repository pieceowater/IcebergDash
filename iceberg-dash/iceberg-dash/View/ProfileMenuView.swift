//
//  ProfileMenuView.swift
//  iceberg-dash
//
//  Created by yury mid on 07.11.2022.
//

import SwiftUI



struct ProfileMenuView: View {
    @EnvironmentObject private var defaultsManager: UserDefaultsManagerViewModel
    @State private var isPresentingConfirm: Bool = false
    var body: some View {
        VStack{
            ScrollView{
    
                NavigationLink {
                    ProfileView()
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                        .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                            .onEnded({ value in
                                if ((value.translation.height > 0) || (value.translation.height < 0)){
                                    UIApplication.shared.endEditing()
                                }
                        }))
                } label: {
                    profileBlock
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                }
                
                NavigationLink {
                    QrListView()
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                        .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                            .onEnded({ value in
                                if ((value.translation.height > 0) || (value.translation.height < 0)){
                                    UIApplication.shared.endEditing()
                                }
                        }))
                } label: {
                    qrBlock
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                }

                NavigationLink {
                    AppearanceView()
                } label: {
                    appearanceBlock
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                }
                
                NavigationLink {
                    faqView()
                } label: {
                    faqBlock
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                }

                
                       
                Spacer()
            }
            .refreshable {
                
            }

        }
        .navigationTitle("Preferences")
        .background(Color.bgSec)
        .toolbar {
            Button(action: {
                isPresentingConfirm = true
                
            }, label: {
                HStack{
                    Image(systemName: "door.right.hand.open")
                    Text("Log out")
                }
                .foregroundColor(.accentColor)
                .font(.subheadline)
            })
        }
        .confirmationDialog("Are you sure?", isPresented: $isPresentingConfirm) {
             Button("Log out", role: .destructive) {
                 logOutTapped()
              }
            }
          
    }

}

struct ProfileMenuView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileMenuView()
    }
}

extension ProfileMenuView {
    
    private func logOutTapped() {
        defaultsManager.removeByKey(key: "accentColor")
        defaultsManager.refreshAccentColor()
        defaultsManager.saveStringValue(key: "token", value: "")
        defaultsManager.refreshCrmUserToken()
        defaultsManager.removeByKey(key: "localQrList")
        defaultsManager.refreshQrList()
        haptic(force: 4)
    }
    
    private var headerBlock: some View {
        VStack(alignment: .center){
            HStack{
                Spacer()
                Text("Preferences")
                    .font(.headline)
                    .padding(.vertical, 15)
                Spacer()
            }
            .background(Color.bg)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var profileBlock: some View {
        HStack{
            Image(systemName: "person")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.accentColor)
                .background(.ultraThinMaterial)
                .cornerRadius(100)
            Text("Profile")
                .font(.headline)
                .foregroundColor(.text)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.subheadline)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        
    }
    
    private var qrBlock: some View {
        HStack{
            Image(systemName: "qrcode")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.accentColor)
                .background(.ultraThinMaterial)
                .cornerRadius(100)
            Text("QR Settings")
                .font(.headline)
                .foregroundColor(.text)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.subheadline)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        
    }
    
    private var appearanceBlock: some View {
        HStack{
            Image(systemName: "swatchpalette")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.accentColor)
                .background(.ultraThinMaterial)
                .cornerRadius(100)
            Text("Appearance")
                .font(.headline)
                .foregroundColor(.text)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.subheadline)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
    
    private var faqBlock: some View {
        HStack{
            Image(systemName: "info.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.accentColor)
                .background(.ultraThinMaterial)
                .cornerRadius(100)
            Text("F.A.Q")
                .font(.headline)
                .foregroundColor(.text)
            Spacer()
            Image(systemName: "chevron.right")
                .font(.subheadline)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
    
}
