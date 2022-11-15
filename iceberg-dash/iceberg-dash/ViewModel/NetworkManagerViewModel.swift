//
//  NetworkManagerViewModel.swift
//  iceberg-dash
//
//  Created by yury mid on 11.11.2022.
//

import Foundation


class NetworkManagerViewModel: ObservableObject {
    let connection: [String : String] = [
        "protocol": "https",
        "domain": "iceberg-crm.ru",
        "port": "2100"
    ]
    
    @Published var networkState: NetworkState = NetworkState(stateCode: 200)
    
    @Published var userInfo: UserInfo = UserInfo(userId: 0, userName: "", userLogin: "", userPassword: "", userPhone: "", userEmail: "", userRoleName: "", userCity: "", userDistrict: "")
    
    private func urlGenerator(methodIsPost: Bool, endpoint: String = "", params: [GetQueryParam] = []) -> String {
        var urlString = "\(connection["protocol"]!)://\(connection["domain"]!):\(connection["port"]!)"
        if !endpoint.isEmpty {
            urlString += "/\(endpoint)"
        }
        if !params.isEmpty {
            if !methodIsPost {
                urlString += "/?"
                for param in params{
                    urlString += "\(param.key)=\(param.value.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "" )&"
                }
                urlString = String(urlString[..<urlString.index(urlString.startIndex, offsetBy: urlString.count-1)])
            }
        }
        
        return urlString
    }
    
    private func fetchData(json: [String : Any], destination: String){
        switch destination {
            case "userInfo":
                self.userInfo = UserInfo(userId: json["userId"] as! Int, userName: json["userFullName"] as! String, userLogin: json["userLogin"] as! String, userPhone: json["userPhone"] as! String, userEmail: json["userEmail"] as! String, userRoleName: json["userPosition"] as! String, userCity: json["userCity"] as! String, userDistrict: json["userDistrict"] as! String)
            case "123":
                print("123")
            default:
                print("destination (\(destination)) is undefined")
        }
    }
    
    public func getData(endpoint: String = "", params: [GetQueryParam] = [], result: String) {
        let urlString = urlGenerator(methodIsPost: false, endpoint: endpoint, params: params)
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let request = URLRequest(url: url)
            
            let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
              guard error == nil else {
                  self.networkState.stateCode = 500
                  self.networkState.errorMessage = "Unable to connect to the server!"
                  self.networkState.errorDetail = ""
                  return
              }
              guard let data = data else {
                  self.networkState.stateCode = 500
                  self.networkState.errorMessage = "Unable to fetch the data!"
                  self.networkState.errorDetail = ""
                  return
              }
             do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    self.fetchData(json: json, destination: result)
                }
             } catch let error {
                 self.networkState.stateCode = 500
                 self.networkState.errorMessage = "Something went wrong!"
                 self.networkState.errorDetail = error.localizedDescription
                 print(error.localizedDescription)
                 print(self.networkState)
             }
            })
            task.resume()
        }
        
    }
    
    public func postData(endpoint: String = "", params: PostQueryParam = PostQueryParam(parameter: [:]), result: String){
        let urlString = urlGenerator(methodIsPost: true, endpoint: endpoint)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpMethod = "POST"
        let parameters: [String: Any] = params.parameter
        request.httpBody = parameters.percentEncoded()

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                error == nil
            else {                                                               // check for fundamental networking error
                print("error", error ?? URLError(.badServerResponse))
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            // do whatever you want with the `data`, e.g.:
            
            do {
               if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                   self.fetchData(json: json, destination: result)
               }
            } catch let error {
                self.networkState.stateCode = 500
                self.networkState.errorMessage = "Something went wrong!"
                self.networkState.errorDetail = error.localizedDescription
                print(error.localizedDescription)
                print(self.networkState)
            }
            
//            do {
//                let responseObject = try JSONDecoder().decode(ResponseObject<Foo>.self, from: data)
//                print(responseObject)
//            } catch {
//                print(error) // parsing error
//
//                if let responseString = String(data: data, encoding: .utf8) {
//                    print("responseString = \(responseString)")
//                } else {
//                    print("unable to parse response as string")
//                }
//            }
        }

        task.resume()
    }
}
