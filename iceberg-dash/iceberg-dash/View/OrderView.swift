//
//  OrderView.swift
//  iceberg-dash
//
//  Created by yury mid on 09.11.2022.
//

import SwiftUI

struct OrderView: View {
    
    @State var order: OrderCard
    @State var showDatePickerScreen: Bool = false
    
    
    
    var body: some View {
        VStack{
            ScrollView{
                VStack {
                    if (order.orderInfo.orderState){
                        excutingLabelBlock
                    }
                    orderInfoBlock
                    clientInfoBlock
                    clientAddressBlock
                    Button {
                        showDatePickerScreen = true
                    } label: {
                        orderDeliveryDateBlock
                    }
                    orderProductInfoBlock
                    orderAmountBlock
                    HStack{
                        Button {
                            copyTextToClipboard(string: "\(order.orderInfo.orderName)\n\(order.clientInfo.clientName)\n\(order.clientInfo.clientAddress)\n\(unixTimeConverter(ts: Double(order.orderInfo.orderDeliveryTime)))\n\(order.orderInfo.orderProduct)\n\(order.orderInfo.orderAmount.formattedWithSeparator)")
                        } label: {
                            HStack{
                                Image(systemName: "doc.on.clipboard")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 17, height: 17)
                                Text("Copy")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.accentColor)
                        }

                        Spacer()
                    }
                    .padding(.top)
                }
                .padding()
                .background(Color.bg)
                .padding(.bottom)
                
                toolsButtonBlock
                .padding(.horizontal)
            }
            .background(Color.bgSec)
            .foregroundColor(.text)
            .refreshable {
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(order.orderInfo.orderName)
        .overlay(alignment: .bottomTrailing, content: {
            singleCallButtonBlock
        })
        .sheet(isPresented: $showDatePickerScreen, content: {
            DatePickerScreen(date: $order.orderDeliverTypeDate, submitFunc: {
                print("hw")
            })
                .presentationDetents([.fraction(0.30)])
        })
        .toolbar {
            NavigationLink {
                TimelineView()
            } label: {
                HStack(alignment: .center) {
                    Text("Timeline")
                    Image(systemName: "clock.arrow.circlepath")
                }
                .font(.subheadline)
                .foregroundColor(.accentColor)
            }
        }
    }
}

struct OrderView_Previews: PreviewProvider {
    static var previews: some View {
        OrderView(order: OrderCard(
            orderInfo: CrmOrder(
                orderId: 1,
                orderName: "AS11234",
                orderDeliveryTime: 1665982809,
                orderProduct: "Самсунг TV asadqwe sada ad1w",
                orderState: true,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "На доставке asd qe12eqad aasd"
                ),
                orderAmount: 21000
            ),
            clientInfo: CrmClient(
                clientId: 1,
                clientName: "Виталий Калугин Fasasd",
                clientAddress: "Карасай Батыра 185 asdqw123 112",
                clientPhone: 77474373690,
                clientAdditionalPhones: [
                    77574373691,
                    77674373692
                ]
            ),
            seen: true
        ))
    }
}

extension OrderView {
    private var excutingLabelBlock: some View {
        HStack{
            Text("Executing")
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical,5)
        .background(.ultraThinMaterial)
        .cornerRadius(5)
        .padding(.bottom)
    }
    
    private var orderInfoBlock: some View {
        HStack(alignment: .top){
            HStack{
                Image(systemName: "list.clipboard")
                    .foregroundColor(.accentColor)
                Text("Order:")
                    .font(.subheadline)
                Text(order.orderInfo.orderName)
                    .font(.headline)
                    .contextMenu{
                        Button {
                            copyTextToClipboard(string: order.orderInfo.orderName)
                        } label: {
                            Text("Copy order name")
                        }
                    }
            }
            
            Spacer()
            
            VStack{
                Text(order.orderInfo.orderStatus.statusName)
                    .padding(.vertical, 5)
                    .padding(.horizontal, 10)
                    .background(order.orderInfo.orderStatus.statusColor)
                    .foregroundColor(.white)
                    .cornerRadius(7)
            }
            
            
        }
        .padding(.vertical, 5)
    }
    
    private var clientInfoBlock: some View {
        HStack(alignment: .top){
            HStack{
                Image(systemName: "person")
                    .foregroundColor(.accentColor)
                Text("Client:")
                    .font(.subheadline)
            }
            VStack{
                Text(order.clientInfo.clientName)
                    .font(.headline)
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
    
    private var clientAddressBlock: some View {
        HStack(alignment: .top){
            HStack{
                Image(systemName: "map")
                    .foregroundColor(.accentColor)
                Text("Address:")
                    .font(.subheadline)
            }
            VStack{
                Text(order.clientInfo.clientAddress)
                    .font(.headline)
                    .contextMenu{
                        if (order.clientInfo.clientAddress != ""){
                            Button {
                                copyTextToClipboard(string: order.clientInfo.clientAddress)
                            } label: {
                                Text("Copy client address")
                            }
                            Link("Open Map", destination: URL(string: "https://2gis.kz/search/\(order.clientInfo.clientAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")")!)
                        }
                    }
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
    
    private var orderDeliveryDateBlock: some View {
        HStack(alignment: .top){
            HStack{
                Image(systemName: "clock")
                    .foregroundColor(.accentColor)
                Text("Delivery:")
                    .font(.subheadline)
            }
            VStack{
                Text(unixTimeConverter(ts: Double(order.orderInfo.orderDeliveryTime)))
                    .font(.headline)
                    .foregroundColor(.accentColor)
            }
            Spacer()
        }
        .padding(.vertical, 5)
    }
    
    private var orderProductInfoBlock: some View {
        HStack(alignment: .top){
            HStack{
                Image(systemName: "shippingbox")
                    .foregroundColor(.accentColor)
                Text("Product:")
                    .font(.subheadline)
            }
            VStack{
                Text(order.orderInfo.orderProduct)
                    .font(.headline)
            }
            Spacer()
            
        }
    }
    
    private var orderAmountBlock: some View {
        HStack(alignment: .top){
            HStack{
                Image(systemName: "banknote")
                    .foregroundColor(.accentColor)
                Text("Amount:")
                    .font(.subheadline)
            }
            VStack{
                Text(String(order.orderInfo.orderAmount.formattedWithSeparator))
                    .font(.headline)
            }
            Spacer()
        }.padding(.vertical, 5)
    }
    
    private var toolsButtonBlock: some View {
        HStack{
            NavigationLink{
//                Image(systemName: "photo.on.rectangle.angled")
                AttachmentsView()
            } label: {
                HStack{
                    Image(systemName: "paperclip")
                    Text("Attachments")
                }
                .foregroundColor(.accentColor)
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(10)
            
            Spacer()
            
            if (order.clientInfo.clientAddress != ""){
                HStack{
                    Image(systemName: "rectangle.portrait.and.arrow.forward")
                    Link("Open Map", destination: URL(string: "https://2gis.kz/search/\(order.clientInfo.clientAddress.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")")!)
                }
                .foregroundColor(.accentColor)
                .padding(.vertical, 10)
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
            }
            
            
        }
    }
    
    private var singleCallButtonBlock: some View {
        HStack{
            if (order.clientInfo.clientAdditionalPhones.count == 0){
                Image(systemName: "phone")
                Link("Call", destination: URL(string: "tel:+\(order.clientInfo.clientPhone)")!)
            }else{
                Image(systemName: "phone")
                Menu {
                    Link(formatPhoneNumber(with: "+X (XXX) XXX-XX-XX", phone: String(order.clientInfo.clientPhone)), destination: URL(string: "tel:+\(order.clientInfo.clientPhone)")!)
                    ForEach(order.clientInfo.clientAdditionalPhones, id: \.self) { number in
                        Link(formatPhoneNumber(with: "+X (XXX) XXX-XX-XX", phone: String(number)), destination: URL(string: "tel:+\(number)")!)
                    }
                } label: {
                    Text("Call")
                }
            }
            
        }
        .padding(.vertical)
        .padding(.horizontal, 25)
        .background(.ultraThinMaterial)
        .cornerRadius(15)
        .padding(20)
        .foregroundColor(.accentColor)
    }
}
