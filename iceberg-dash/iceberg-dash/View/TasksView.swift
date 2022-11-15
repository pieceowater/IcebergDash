//
//  TasksView.swift
//  iceberg-dash
//
//  Created by yury mid on 07.11.2022.
//

import SwiftUI

struct TasksView: View {
    @EnvironmentObject private var defaultsManager: UserDefaultsManagerViewModel
    
    let tasks = [
        iceberg_dash.Task(id: 1,
             title: "Связаться",
             caption: "Не соглашается с условиями - связаться с клиентом",
             deadline: 1665982820,
             createDate: 1665982809,
             executorsList: [
                 TaskExecutor(
                    id: 2,
                    name: "Юрий Литвиненко"
                 ),
                 TaskExecutor(
                    id: 1,
                    name: "Виталий Калугин"
                 )
             ],
             managersList: [
                 TaskManager(
                    id: 3,
                    name: "Марлен Монро"
                 ),
                 TaskManager(
                    id: 5,
                    name: "Владислав Дорофейчик"
                 ),
                 TaskManager(
                    id: 6,
                    name: "Адель"
                 )
             ],
             order: CrmOrder(
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
             seen: true,
             completed: true
            ),
        iceberg_dash.Task(id: 2,
             title: "Доставить",
             caption: "Доставить товар по адресу. Адрес указан в заказе",
             deadline: 1665982820,
             createDate: 1665982809,
             executorsList: [
                 TaskExecutor(
                    id: 2,
                    name: "Юрий Литвиненко"
                 )
             ],
             managersList: [
                 TaskManager(
                    id: 4,
                    name: "Виктор Туков"
                 )
             ],
             order: CrmOrder(
                orderId: 2,
                orderName: "AS2",
                orderDeliveryTime: 1665982809,
                orderProduct: "LG TV",
                orderState: true,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "На доставке"
                ),
                orderAmount: 41000
             ),
             seen: true,
             completed: false
            ),
        iceberg_dash.Task(id: 3,
             title: "Забрать товар",
             caption: "Забрать товар по адресу. Адрес указан в заказе",
             deadline: 1665982820,
             createDate: 1665982809,
             executorsList: [
                 TaskExecutor(
                    id: 2,
                    name: "Юрий Литвиненко"
                 )
             ],
             managersList: [
                 TaskManager(
                    id: 4,
                    name: "Виктор Туков"
                 )
             ],
             order: CrmOrder(
                orderId: 5,
                orderName: "AS5",
                orderDeliveryTime: 1665982809,
                orderProduct: "Микроволновка SAMSUNG",
                orderState: true,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "На заборе"
                ),
                orderAmount: 21000
             ),
             seen: false,
             completed: false
            ),
        iceberg_dash.Task(id: 3,
             title: "Забрать товар",
             caption: "Забрать товар по адресу. Адрес указан в заказе",
             deadline: 1665982820,
             createDate: 1665982809,
             executorsList: [
                 TaskExecutor(
                    id: 2,
                    name: "Юрий Литвиненко"
                 )
             ],
             managersList: [
                 TaskManager(
                    id: 4,
                    name: "Виктор Туков"
                 )
             ],
             order: CrmOrder(
                orderId: 5,
                orderName: "AS5",
                orderDeliveryTime: 1665982809,
                orderProduct: "Микроволновка SAMSUNG",
                orderState: true,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "На заборе"
                ),
                orderAmount: 21000
             ),
             seen: false,
             completed: false
            ),
        iceberg_dash.Task(id: 3,
             title: "Забрать товар",
             caption: "Забрать товар по адресу. Адрес указан в заказе",
             deadline: 1665982820,
             createDate: 1665982809,
             executorsList: [
                 TaskExecutor(
                    id: 2,
                    name: "Юрий Литвиненко"
                 )
             ],
             managersList: [
                 TaskManager(
                    id: 4,
                    name: "Виктор Туков"
                 )
             ],
             order: CrmOrder(
                orderId: 5,
                orderName: "AS5",
                orderDeliveryTime: 1665982809,
                orderProduct: "Микроволновка SAMSUNG",
                orderState: true,
                orderStatus: CrmOrderStatus(
                    statusId: 1,
                    statusName: "На заборе"
                ),
                orderAmount: 21000
             ),
             seen: false,
             completed: false
            )
    ]
    
    @State var searchString: String = ""
    @State var selectedFilter: Int = 1
    let filterOptions = [0,1,2]
    let filterOptionsLocal = [
        0:LocalizedStringKey("All"),
        1:LocalizedStringKey("Executing"),
        2:LocalizedStringKey("Leading")
    ]
    
    @State private var selectedSortItem = "0"
    @State private var selectedSortType = "0"
    
    var body: some View {
        VStack{
            VStack{
                ScrollView {
                    taskFilterBlock
                        .padding(.horizontal, 20)
                    ForEach(searchString == "" ? tasks : tasks.filter { ($0.title).lowercased().contains(searchString.lowercased())  }, id: \.self) { taskCard in
                        NavigationLink(destination: cardListItem(item: taskCard)) {
                            cardListItem(item: taskCard)
                                .padding(.horizontal)
                                .padding(.vertical, 5)
                        }
                        .shadow(color: Color.black.opacity(0.03), radius: 10)
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
                    Color.bgSec
                }
                .foregroundColor(.text)
                .refreshable {
                    
                }

            }
            .background(Color.bgSec)
            .refreshable {
                
            }
            
            
            .overlay(alignment: .bottomTrailing) {
                Button(action: {

                }, label: {
                    plusTaskButtonBlock
                })
                .padding(20)
            }
        }
        .navigationTitle("Tasks")
        .searchable(text: $searchString)
        .background(Color.bg)
        .onAppear{
            self.selectedSortItem = defaultsManager.getStringValue(key: "tasksSortItem").isEmpty ? "0" : defaultsManager.getStringValue(key: "tasksSortItem")
            self.selectedSortType = defaultsManager.getStringValue(key: "tasksSortType").isEmpty ? "0" : defaultsManager.getStringValue(key: "tasksSortType")
        }
        .toolbar {
            Menu {
                Button {
                    selectedSortItem = "0"
                    defaultsManager.saveStringValue(key: "tasksSortItem", value: selectedSortItem)
                } label: {
                    Text("Creation date")
                    if selectedSortItem == "0" { Image(systemName: "checkmark") }
                }
                Button {
                    selectedSortItem = "1"
                    defaultsManager.saveStringValue(key: "tasksSortItem", value: selectedSortItem)
                } label: {
                    Text("Deadline")
                    if selectedSortItem == "1" { Image(systemName: "checkmark") }
                }
                
                Divider()
                
                Button {
                    selectedSortType = "0"
                    defaultsManager.saveStringValue(key: "tasksSortType", value: selectedSortType)
                } label: {
                    Text("Ascending")
                    if selectedSortType == "0" { Image(systemName: "checkmark") }
                }
                Button {
                    selectedSortType = "1"
                    defaultsManager.saveStringValue(key: "tasksSortType", value: selectedSortType)
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

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView()
            .environmentObject(UserDefaultsManagerViewModel())
    }
}

extension TasksView {
    func unixTimeConverter(ts: Double)->String{
        let date = NSDate(timeIntervalSince1970: ts)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY hh:mm:ss a"
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
    
    private var taskFilterBlock: some View {
        Picker(selection: $selectedFilter, label: Text("")) {
            ForEach(filterOptions, id: \.self) {
                Text(filterOptionsLocal[self.filterOptions[$0]] ?? "").tag(self.filterOptions[$0])
            }
        }.pickerStyle(.segmented)
    }
    
    private func cardListItem(item: Task) -> some View {
            VStack(spacing: 10){
                HStack{
                    Text("\(item.title)")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                    Spacer()
                    if (item.order != nil) {
                        Text(item.order?.orderName ?? "")
                            .font(.caption)
                            .padding(5)
                            .background(.ultraThinMaterial)
                            .cornerRadius(5)
                    }
                }
                Divider()
                VStack(alignment: .leading,spacing: 8){
                    HStack{
                        Image(systemName: "ellipsis.message")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        Text(item.caption)
                            .font(.subheadline)
                            .lineLimit(1)
                        Spacer()
                    }
                    
                    HStack{
                        Image(systemName: "clock.badge.exclamationmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 15, height: 15)
                        Text(String(
                            unixTimeConverter(ts: Double(item.deadline))
                        ))
                            .font(.subheadline)
                        Spacer()
                    }
                    HStack(alignment: .center) {
                        VStack{
                            Image(systemName: "person.circle")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                                .padding(.top, 10)
                            Spacer()
                        }
                        VStack{
                            if (item.managersList.count > 1){
                                DisclosureGroup("Leaders") {
                                    VStack {
                                        ForEach(item.managersList, id: \.self) { mngr in
                                            HStack{
                                                Text(mngr.name)
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                .font(.subheadline)
                            }else{
                                Text(item.managersList[0].name)
                                    .font(.subheadline)
                            }
                            
                        }
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
    }
    
    private var plusTaskButtonBlock: some View {
        HStack{
            Image(systemName: "plus")
            Text("Task")
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(15)
    }
}
