//
//  ContentView.swift
//  iceberg-dash
//
//  Created by yury mid on 05.11.2022.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject private var defaultsManager: UserDefaultsManagerViewModel
    
    @State var prefix: String = ""
    @State var login: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            VStack{
                iconBlock
                textFieldsBlock
                    .padding()
                    .padding(.top)
                Button {
                    defaultsManager.saveStringValue(key: "token", value: "dummytoken")
                    defaultsManager.refreshCrmUserToken()
                } label: {
                    authButtonBlock
                }
                Button {
                    
                } label: {
                    passwordRecoveryButtonBlock
                }
            }
            .padding()
        }
        .foregroundColor(Color.text)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg)
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
 
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}

extension AuthView{
    private var iconBlock: some View {
        Image("IconStroke")
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
    }
    
    private var textFieldsBlock: some View {
        VStack(){
            Text("Log in")
                .padding(.bottom, 15)
            TextField("CRM-prefix", text: $prefix)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.bgSec)
                .cornerRadius(10)
                .onTapGesture {}
            TextField("Login", text: $login)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.bgSec)
                .cornerRadius(10)
                .onTapGesture {}
            SecureField("Password", text: $password)
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.bgSec)
                .cornerRadius(10)
                .onTapGesture {}
        }
    }
    
    private var authButtonBlock: some View {
        HStack{
            Text("Sign in")
                .frame(maxWidth: .infinity)
                .padding(10)
                .background(Color.accentColor)
                .cornerRadius(10)
                .padding()
                .foregroundColor(.white)
                .font(.headline)
        }
    }
    
    private var passwordRecoveryButtonBlock: some View {
        HStack{
            Text("Forgot password?")
        }
    }
}
