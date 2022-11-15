//
//  OrderModal.swift
//  iceberg-dash
//
//  Created by yury mid on 05.11.2022.
//

import Foundation
import SwiftUI


struct CrmOrderStatus {
    let statusId: Int
    let statusName: String
    let statusColor: Color = Color.accentColor
}

struct CrmOrder: Equatable{
    let orderId: Int
    let orderName: String
    let orderDeliveryTime: Int64
    let orderProduct: String
    let orderState: Bool
    let orderStatus: CrmOrderStatus
    let orderAmount: Int
    
    
    static func == (lhs: CrmOrder, rhs: CrmOrder) -> Bool {
        return lhs.orderId == rhs.orderId
    }
}

struct CrmClient: Equatable {
    let clientId: Int
    let clientName: String
    let clientAddress: String
    let clientPhone: Int
    var clientAdditionalPhones: [Int] = []
    
    
    static func == (lhs: CrmClient, rhs: CrmClient) -> Bool {
        return lhs.clientId == rhs.clientId
    }
}

struct OrderCard: Hashable, Equatable {
    var orderInfo: CrmOrder
    var clientInfo: CrmClient
    var seen: Bool = false
        
    var orderDeliverTypeDate: Date
    
    init(orderInfo: CrmOrder, clientInfo: CrmClient, seen: Bool) {
        self.orderInfo = orderInfo
        self.clientInfo = clientInfo
        self.seen = seen
        
        self.orderDeliverTypeDate = NSDate(timeIntervalSince1970: Double(orderInfo.orderDeliveryTime)) as Date
    }
    
    
    
   
    
    static func == (lhs: OrderCard, rhs: OrderCard) -> Bool {
        return lhs.orderInfo == rhs.orderInfo && lhs.clientInfo == rhs.clientInfo
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(orderInfo.orderId)
    }
}

struct OrderTimelineItem: Hashable {
    let itemId: Int
    let itemAuthorId: Int
    let itemAuthorName: String
    let itemHeader: String
    let itemContent: String
    let isContainsMedia: Bool = false
    let itemDatetime: Int64
    let iconKey: Int
}

let timelineIcons = [
    0: Image(systemName: "info.circle.fill"),
    1: Image(systemName: "message.fill"),
    2: Image(systemName: "clipboard.fill")
]
