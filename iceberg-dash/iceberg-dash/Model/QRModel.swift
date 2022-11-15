//
//  QRModel.swift
//  iceberg-dash
//
//  Created by yury mid on 08.11.2022.
//

import Foundation

struct QrItem: Hashable, Codable {
    let id: UUID = UUID()
    var title: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
           case id, title, content
       }
}

struct QrItemList: Codable {
    var qrItems: [QrItem]
}
