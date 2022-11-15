//
//  ProfileView.swift
//  iceberg-dash
//
//  Created by yury mid on 05.11.2022.
//

import SwiftUI
import SkeletonUI

struct ProfileView: View {
    
    @State var currentUserInfo: UserInfo = UserInfo(userId: 0,
                                                    userName: "Yury Mid",
                                                    userLogin: "mid",
                                                    userPassword: "",
                                                    userPhone: "77778465893",
                                                    userEmail: "yury.lvn@mail.ru",
                                                    userRoleName: "Developer",
                                                    userCity: "Almaty",
                                                    userDistrict: "Center")
    
    
    @State private var sheetFAQ: Bool = false
    
    var body: some View {
        VStack{
            ScrollView{
                editAccountBlock
            }
            .refreshable {
               
            }
        }
        .background(Color.bgSec)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(currentUserInfo.userName)
        //delete this before pull
//        .onReceive(profile.$userInfo) { item in
//            currentUserInfo = item
//        }
        //delete this before pull
        .onAppear{
//            profile.getUserInfo()
        }
        
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
    private var headerBlock: some View {
        VStack(alignment: .center){
            HStack{
                Spacer()
                Text(currentUserInfo.userName)
                    .font(.headline)
                    .padding(.vertical, 15)
                Spacer()
            }
            .background(Color.bg)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var editAccountBlock: some View {
        VStack (alignment: .leading, spacing: 5){
            Text("Edit personal info")
                .font(.subheadline)
            
            VStack(alignment: .leading){
                Text("Full name")
                    .font(.caption)
                TextField("Full name", text: $currentUserInfo.userName)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.bg)
                    .cornerRadius(10)
                    .onTapGesture {}
                    .skeleton(with: currentUserInfo.userName.isEmpty, size: CGSizeMake(.infinity, 40)).shape(type: .rectangle).cornerRadius(10)
                    
                Text("\(LocalizedStringKey("Position").stringValue()): \(currentUserInfo.userRoleName)")
                    .font(.caption)
                    .padding(.horizontal)
                    .skeleton(with: currentUserInfo.userRoleName.isEmpty, size: CGSizeMake(150, 20)).shape(type: .rectangle).cornerRadius(5)
                Text("\(currentUserInfo.userCity) > \(currentUserInfo.userDistrict)")
                    .font(.caption)
                    .padding(.horizontal)
                    .skeleton(with: currentUserInfo.userDistrict.isEmpty, size: CGSizeMake(150, 20)).shape(type: .rectangle).cornerRadius(5)
            }.padding(.vertical,5)
            
            VStack(alignment: .leading, spacing: 10){
                Text("Additional info")
                    .font(.subheadline)
                
                VStack(alignment: .leading){
                    Text("Email")
                        .font(.caption)
                    TextField("Email", text: $currentUserInfo.userEmail)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.bgSec)
                        .cornerRadius(10)
                        .onTapGesture {}
                }.padding(.horizontal,5)
                
                VStack(alignment: .leading){
                    Text("Phone number")
                        .font(.caption)
                    TextField("Phone number", text: $currentUserInfo.userPhone)
                        .onChange(of: currentUserInfo.userPhone, perform: { oldValue in
                            currentUserInfo.userPhone = formatPhoneNumber(with: "+X (XXX) XXX-XX-XX", phone: oldValue)
                        })
                        .onAppear{
                            currentUserInfo.userPhone = formatPhoneNumber(with: "+X (XXX) XXX-XX-XX", phone: currentUserInfo.userPhone)
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.bgSec)
                        .cornerRadius(10)
                        .onTapGesture {}
                }.padding(.horizontal,5)
                
                
            }
            .padding()
            .background(Color.bg)
            .skeleton(with: (currentUserInfo.userEmail.isEmpty || currentUserInfo.userPhone.isEmpty), size: CGSizeMake(.infinity, 170)).shape(type: .rectangle)
            .cornerRadius(10)
            .padding(.bottom)
            
            
            
            VStack(alignment: .leading, spacing: 10){
                Text("Credentials")
                    .font(.subheadline)
                VStack(alignment: .leading){
                    Text("Login")
                        .font(.caption)
                    TextField("Login", text: $currentUserInfo.userLogin)
                        .padding(.vertical, 10)
//                        .skeleton(with: currentUserInfo.userLogin.isEmpty)
                        .padding(.horizontal, 15)
                        .background(Color.bgSec)
                        .cornerRadius(10)
                        .onTapGesture {}
                        
                }.padding(.horizontal,5)
                
                VStack(alignment: .leading){
                    Text("New password")
                        .font(.caption)
                    SecureField("New password", text: $currentUserInfo.userPassword)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 15)
                        .background(Color.bgSec)
                        .cornerRadius(10)
                        .onTapGesture {}
                }.padding(.horizontal,5)
            }
            .padding()
            .background(Color.bg)
            .skeleton(with: currentUserInfo.userLogin.isEmpty, size: CGSizeMake(.infinity, 150)).shape(type: .rectangle)
            .cornerRadius(10)
            .padding(.bottom)
            
            Button {
                print("save tapped")
            } label: {
                HStack{
                    Text("Save")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.vertical,10)
                }
                .frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .cornerRadius(10)
            }
            .skeleton(with: currentUserInfo.userLogin.isEmpty, size: CGSizeMake(.infinity, 50)).shape(type: .rectangle).cornerRadius(10)

        }
        .padding()
        .frame(maxWidth: .infinity)
    }
}
