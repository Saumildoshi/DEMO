 //
//  NetworkManagar.swift
//  Demo App Task - Elluminati
//
//  Created by Demo App on 22/10/24.
//


import UIKit
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
        
    func fetchData<T: Codable>(apiName: String, method: HTTPMethod,completion: @escaping (Result<BaseResponseModel<T>, AFError>) -> Void) {
        
        guard let url = URL(string: BASE_URL.apartmentSize + apiName) else { return }
        let headers = HTTPHeaders(["Accept" : "application/json",
                                   "Authorization" : "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc3RyZWFtbHl0di5jb21cL2FwaVwvYXV0aFwvbG9naW4iLCJpYXQiOjE3Mjc0Mzc0NDEsImV4cCI6MTc0Mjk4OTQ0MSwibmJmIjoxNzI3NDM3NDQxLCJqdGkiOiJzYnVNbGNHcXI1b2liQ09sIiwic3ViIjo1NjgsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEiLCJuYW1lIjoiUUEgU3VyZXNoIiwicm9sZXMiOlt7ImlkIjozLCJuYW1lIjoidXNlciIsImRpc3BsYXlfbmFtZSI6InVzZXIiLCJkZXNjcmlwdGlvbiI6Im5vdCBhZG1pbiBwZXJtaXNpb24iLCJjcmVhdGVkX2F0IjpudWxsLCJ1cGRhdGVkX2F0IjpudWxsLCJwaXZvdCI6eyJ1c2VyX2lkIjo1NjgsInJvbGVfaWQiOjN9fV19.a9PLue7xPSaf5rDSzJte7mv7ORrgvTKhqoJDwDtu2NY"])
        
        AF.request(url, method: method, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BaseResponseModel<T>.self) { response in
                
                print("=============== REQUEST ===============\n")
                print("URL         :- \(response.request?.url?.absoluteString ?? "")")
                print("header      :- \(response.request?.headers.dictionary.prettyPrintedJSONString ?? "")")
                print("Method      :- \(response.request?.httpMethod ?? "")")
                print("========================================\n")

                switch response.result {
                case .success(let baseResponse):
                    print("=============== RESPONSE ===============\n")
                    print(response.data?.prettyPrintedJSONString ?? "")
                    print("========================================\n")
                    completion(.success(baseResponse))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
    }
    
}

extension Data {
    
    var prettyPrintedJSONString: String? {
        if let object = try? JSONSerialization.jsonObject(with: self, options: []){
            if let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]){
                return String(data: data, encoding: .utf8)
            }
        }
        return nil
    }
    
}

extension Dictionary {
    
    var prettyPrintedJSONString: String? {
        if let data = try? JSONSerialization.data(withJSONObject: self, options: [.prettyPrinted]){
            return data.prettyPrintedJSONString
        }
        return nil
    }
}
