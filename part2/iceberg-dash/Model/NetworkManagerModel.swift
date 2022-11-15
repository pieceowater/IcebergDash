//
//  NetworkManagerModel.swift
//  iceberg-dash
//
//  Created by yury mid on 12.11.2022.
//

import Foundation
import SwiftUI

struct NetworkState {
    var stateCode: Int
    var errorMessage: String
    var errorDetail: String
    
    init(stateCode: Int, errorMessage: String = "", errorDetail: String = "") {
        self.stateCode = stateCode
        self.errorMessage = LocalizedStringKey(errorMessage).stringValue()
        self.errorDetail = errorDetail
    }
}

struct GetQueryParam {
    let key: String
    let value: String
}

struct PostQueryParam {
    let parameter: [String: Any]
}
