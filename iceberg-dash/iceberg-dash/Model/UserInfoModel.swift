//
//  UserInfoModel.swift
//  iceberg-dash
//
//  Created by yury mid on 11.11.2022.
//

import Foundation

struct UserInfo: Decodable {
    let userId: Int
    var userName: String
    
    var userLogin: String
    var userPassword: String
    
    var userPhone: String
    var userEmail: String
    
    let userRoleName: String
    let userCity: String
    let userDistrict: String
    
    init(userId: Int, userName: String, userLogin: String, userPassword: String = "", userPhone: String, userEmail: String, userRoleName: String, userCity: String, userDistrict: String) {
        self.userId = userId
        self.userName = userName
        self.userLogin = userLogin
        self.userPassword = userPassword
        self.userPhone = userPhone
        self.userEmail = userEmail
        self.userRoleName = userRoleName
        self.userCity = userCity
        self.userDistrict = userDistrict
    }
}
