//
//  Item.swift
//  iceberg-dash
//
//  Created by yury mid on 14.11.2022.
//

import SwiftUI

struct Item: Identifiable {

    let id = UUID()
    let url: URL

}

extension Item: Equatable {
    static func ==(lhs: Item, rhs: Item) -> Bool {
        return lhs.id == rhs.id && lhs.id == rhs.id
    }
}
