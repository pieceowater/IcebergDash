//
//  NotificationsView.swift
//  iceberg-dash
//
//  Created by yury mid on 07.11.2022.
//

import SwiftUI

struct NotificationsView: View {
    
    @State var notificationsList: [Notification] = [
        Notification(title: "Добро пожаловать в ICEBERG Dash", content: "С помощью этого приложения вы будете всегда оставаться на связи с логистом!", seen: true),
        Notification(title: "Пример уведомления", content: "Как говориться, lorem ipsum и тд", seen: true),
        Notification(title: "Пример уведомления", content: "Как говориться, lorem ipsum и тд", seen: true),
        Notification(title: "Пример уведомления", content: "Как говориться, lorem ipsum и тд", seen: true),
        Notification(title: "Пример уведомления", content: "Как говориться, lorem ipsum и тд", seen: true),
        Notification(title: "Пример уведомления", content: "Как говориться, lorem ipsum и тд", seen: true),
        Notification(title: "Пример уведомления", content: "Как говориться, lorem ipsum и тд", seen: true),
        Notification(title: "Пример уведомления", content: "Как говориться, lorem ipsum и тд", seen: true),
        Notification(title: "Пример уведомления", content: "Как говориться, lorem ipsum и тд", seen: true),
        Notification(title: "Пример уведомления", content: "Как говориться, lorem ipsum и тд")
    ]
    
    let date: Date
    let dateFormatter: DateFormatter
        
    init() {
        date = Date()
        dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .medium
    }

    
    var body: some View {
        VStack{
            ScrollViewReader { proxy in
                List{
                    ForEach(notificationsList, id: \.self) { list in
                        notificationCard(item: list)
                            .swipeActions {
                                Button("Delete") {
                                    //                                notificationsList.remove(atOffsets: id)
                                }
                                .tint(.red)
                                Button("Unread") {
                                    //                                list.seen = false
                                }
                                .tint(.accentColor)
                            }
                    }
                    .listRowBackground(Color.bgSec)
                    .listRowSeparatorTint(.clear)
                    .onAppear {
                        proxy.scrollTo("end")
                    }
                    Color.bgSec
                        .id("end")
                        .listRowBackground(Color.bgSec)
                        .listRowSeparatorTint(.clear)
                }
                .listStyle(.plain)
                .background(Color.bgSec)
                .refreshable {
                    
                }
            }
        }
        .background(Color.bgSec)
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsView()
    }
}

extension NotificationsView {
    private func notificationCard(item: Notification) -> some View {
        HStack{
            VStack{
                ZStack{
                    item.icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.accentColor)
                }
                .padding(10)
                .background(.ultraThinMaterial)
                .cornerRadius(100)
                
                Spacer()
            }
            .padding(.trailing, 10)
            VStack(alignment: .leading, spacing: 10){
                Text(item.title)
                    .font(.headline)
                Text(item.content)
                    .font(.subheadline)
                HStack{
                    Spacer()
                    Text(item.datetime, formatter: dateFormatter)
                        .font(.caption)
                        .foregroundColor(.text.opacity(0.6))
                }
            }
            
            Spacer()
        }
        .padding()
        .background(.ultraThinMaterial).cornerRadius(15)
        .overlay(alignment: .topTrailing) {
            if (!item.seen){
                Circle()
                    .foregroundColor(.red.opacity(0.8))
                    .frame(width: 10, height: 10)
            }
        }

    }
    
}
