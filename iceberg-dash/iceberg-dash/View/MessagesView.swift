//
//  MessagesView.swift
//  iceberg-dash
//
//  Created by yury mid on 05.11.2022.
//

import SwiftUI

struct MessagesView: View {
    var body: some View {
        VStack{
//            headerBlock
            ScrollView{
    
                NavigationLink {
                    NotificationsView()
                } label: {
                    notificationsBlock
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                }

                NavigationLink {
                    ChatView()
                } label: {
                    commonChatBlock
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                }

                Spacer()
            }
            .refreshable {
                
            }

        }
        .navigationTitle("Messages")
        .background(Color.bgSec)
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}

extension MessagesView {
    private var headerBlock: some View {
        VStack(alignment: .center){
            HStack{
                Spacer()
                Text("Messages & Notifications")
                    .font(.headline)
                    .padding(.vertical, 15)
                Spacer()
            }
            .background(Color.bg)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var notificationsBlock: some View {
        HStack{
            Image(systemName: "bell.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.accentColor)
                .background(.ultraThinMaterial)
                .cornerRadius(100)
            Text("Notifications")
                .font(.headline)
                .foregroundColor(.text)
            Spacer()
            Text("4")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
                .background(Color.accentColor)
                .cornerRadius(100)
                .padding(5)
            Image(systemName: "chevron.right")
                .font(.subheadline)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
        
    }
    
    private var commonChatBlock: some View {
        HStack{
            Image(systemName: "person.3.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15)
                .foregroundColor(.white)
                .padding(10)
                .background(Color.accentColor)
                .background(.ultraThinMaterial)
                .cornerRadius(100)
            Text("Chat")
                .font(.headline)
                .foregroundColor(.text)
            Spacer()
            Text("9")
                .font(.caption)
                .foregroundColor(.white)
                .padding(.vertical, 5)
                .padding(.horizontal, 8)
                .background(Color.accentColor)
                .cornerRadius(100)
                .padding(5)
            Image(systemName: "chevron.right")
                .font(.subheadline)
        }
        .padding(10)
        .background(.ultraThinMaterial)
        .cornerRadius(10)
    }
}
