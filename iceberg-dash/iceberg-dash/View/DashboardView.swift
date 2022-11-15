//
//  DashboardView.swift
//  iceberg-dash
//
//  Created by yury mid on 05.11.2022.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject private var defaultsManager: UserDefaultsManagerViewModel
    
    var orders = [
        OrderCard(
            orderInfo: CrmOrder(
                orderId: 1,
                orderName: "AS1",
                orderDeliveryTime: 1665982809,
                orderProduct: "Самсунг TV",
                orderState: true,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "На доставке"
                ),
                orderAmount: 21000
            ),
            clientInfo: CrmClient(
                clientId: 1,
                clientName: "Виталий Калугин",
                clientAddress: "Карасай Батыра 185",
                clientPhone: 77474373690,
                clientAdditionalPhones: [
                    77071299914
                ]
            ),
            seen: true
        ),
        OrderCard(
            orderInfo: CrmOrder(
                orderId: 2,
                orderName: "AS2",
                orderDeliveryTime: 1665982809,
                orderProduct: "LG TV",
                orderState: false,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "Доставлен"
                ),
                orderAmount: 1000
            ),
            clientInfo: CrmClient(
                clientId: 1,
                clientName: "Владислав Дорофейчик",
                clientAddress: "Нурлы жол 1",
                clientPhone: 77778465893
            ),
            seen: true
        ),
        OrderCard(
            orderInfo: CrmOrder(
                orderId: 5,
                orderName: "AS5",
                orderDeliveryTime: 1665982809,
                orderProduct: "Микроволновка SAMSUNG",
                orderState: true,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "На заборе"
                ),
                orderAmount: 51000
            ),
            clientInfo: CrmClient(
                clientId: 1,
                clientName: "Дмитрий Самылки",
                clientAddress: "Ахчба 69",
                clientPhone: 77778465893
            ),
            seen: true
        ),
        OrderCard(
            orderInfo: CrmOrder(
                orderId: 12,
                orderName: "AS12",
                orderDeliveryTime: 1665982809,
                orderProduct: "Посудомойка \"Ева\" ",
                orderState: false,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "Доставлен в сервис"
                ),
                orderAmount: 83500
            ),
            clientInfo: CrmClient(
                clientId: 1,
                clientName: "Адам",
                clientAddress: "Еден 1/21",
                clientPhone: 77778465893
            ),
            seen: false
        ),
        OrderCard(
            orderInfo: CrmOrder(
                orderId: 21,
                orderName: "AS21",
                orderDeliveryTime: 1665982809,
                orderProduct: "Парогенератор \"SteamGaBen\"",
                orderState: false,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "Доставлен"
                ),
                orderAmount: 49500
            ),
            clientInfo: CrmClient(
                clientId: 1,
                clientName: "Марлен",
                clientAddress: "Чуйская Долина",
                clientPhone: 77778465893
            ),
            seen: true
        )
    ]
    @State var searchString: String = ""
    
    @State private var linkActive = false
    
    @State private var selectedSortItem: String = "0"
    @State private var selectedSortType: String = "0"
    
    var body: some View {
            VStack{
                VStack{
                    ScrollView {
                        ForEach(searchString == "" ? orders : orders.filter { ($0.orderInfo.orderName).lowercased().contains(searchString.lowercased())}, id: \.self) { orderCard in
                            NavigationLink(destination: OrderView(order: orderCard)) {
                                cardListItem(item: orderCard)
                                    .padding(.horizontal)
                                    .padding(.vertical, 5)
                            }
                            .shadow(color: Color.black.opacity(0.03), radius: 10)
                        }
                        Color.bgSec
                    }
                    .foregroundColor(.text)
                    .refreshable {
                        
                    }
                }
                .background(Color.bgSec)
            }
            .navigationTitle("Orders")
            .searchable(text: $searchString)
            .background(Color.bg)
            .onAppear{
                self.selectedSortItem = defaultsManager.getStringValue(key: "ordersSortItem").isEmpty ? "0" : defaultsManager.getStringValue(key: "ordersSortItem")
                self.selectedSortType = defaultsManager.getStringValue(key: "ordersSortType").isEmpty ? "0" : defaultsManager.getStringValue(key: "ordersSortType")
            }
            .toolbar {
                Menu {
                    Button {
                        selectedSortItem = "0"
                        defaultsManager.saveStringValue(key: "ordersSortItem", value: selectedSortItem)
                    } label: {
                        Text("Creation date")
                        if selectedSortItem == "0" { Image(systemName: "checkmark") }
                    }
                    Button {
                        selectedSortItem = "1"
                        defaultsManager.saveStringValue(key: "ordersSortItem", value: selectedSortItem)
                    } label: {
                        Text("Delivery date")
                        if selectedSortItem == "1" { Image(systemName: "checkmark") }
                    }
                    
                    Divider()
                    
                    Button {
                        selectedSortType = "0"
                        defaultsManager.saveStringValue(key: "ordersSortType", value: selectedSortType)
                    } label: {
                        Text("Ascending")
                        if selectedSortType == "0" { Image(systemName: "checkmark") }
                    }
                    Button {
                        selectedSortType = "1"
                        defaultsManager.saveStringValue(key: "ordersSortType", value: selectedSortType)
                    } label: {
                        Text("Descending")
                        if selectedSortType == "1" { Image(systemName: "checkmark") }
                    }
                } label: {
                    HStack{
                        Image(systemName: "line.3.horizontal.decrease.circle")
                        Text("Sort")
                    }
                    .foregroundColor(.accentColor)
                    .font(.subheadline)
                }
            }

    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
            .environmentObject(UserDefaultsManagerViewModel())
    }
}

extension DashboardView {
   
    
    private func cardListItem(item: OrderCard) -> some View {
            VStack(spacing: 10){
                HStack{
                    Text("\(item.orderInfo.orderName)")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .contextMenu{
                            Button {
                                copyTextToClipboard(string: item.orderInfo.orderName)
                            } label: {
                                Text("Copy order name")
                            }
                        }
                    Spacer()
                    if item.orderInfo.orderState {
                        Text("Executing")
                            .font(.caption)
                            .padding(5)
                            .background(.ultraThinMaterial)
                            .cornerRadius(5)
                    }
                }
                Divider()
                VStack(alignment: .leading,spacing: 8){
                    HStack{
                        Image(systemName: "shippingbox")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        Text(item.orderInfo.orderProduct)
                            .font(.subheadline)
                        Spacer()
                    }
                    
                    HStack{
                        Image(systemName: "map")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        Text(item.clientInfo.clientAddress)
                            .font(.subheadline)
                            .contextMenu{
                                if (item.clientInfo.clientAddress != ""){
                                    Button {
                                        copyTextToClipboard(string: item.clientInfo.clientAddress)
                                    } label: {
                                        Text("Copy client address")
                                    }
                                    Link("Open Map", destination: URL(string: "https://2gis.kz/search/\(item.clientInfo.clientAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")")!)
                                }
                            }
                        Spacer()
                    }
                    
                    
                    HStack{
                        Image(systemName: "clock")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        Text(String(
                            unixTimeConverter(ts: Double(item.orderInfo.orderDeliveryTime))
                        ))
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                    }
                }
            }
            .padding()
            .background(Color.bg)
            .cornerRadius(15)
            .overlay(alignment: .topTrailing) {
                if (!item.seen){
                    Circle()
                        .foregroundColor(.red.opacity(0.8))
                        .frame(width: 10, height: 10)
                }
            }
            .contextMenu {
                Button {
                    copyTextToClipboard(string: "\(item.orderInfo.orderName)\n\(item.orderInfo.orderProduct)\n\(item.clientInfo.clientAddress)\n\(unixTimeConverter(ts: Double(item.orderInfo.orderDeliveryTime)))")
                } label: {
                    Text("Copy order info")
                }

                if (item.clientInfo.clientAddress != ""){
                    Link("Open Map", destination: URL(string: "https://2gis.kz/search/\(item.clientInfo.clientAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")")!)
                }
            }
    }
}
