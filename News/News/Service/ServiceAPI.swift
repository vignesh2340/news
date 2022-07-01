//
//  ServiceAPI.swift
//  News
//
//  Created by Admin on 30/06/22.
//

import Foundation

final class ServiceAPI {
    
    static let serviceAPI = ServiceAPI()
    
    static func getInstance() -> ServiceAPI {
        return serviceAPI
    }
    
    /// Method to getResponseJson From API
    /// - Parameters:
    ///   - url: denotes API url
    ///   - completionHandler: denotes API response(Any, ZivameError)
    func requestJson(url: URL, completionHandler: @escaping (_ result: Any?, _ error: ServiceError?)-> Void) {
        let task = URLSession.shared.dataTask(with: url) { (jsonData, response, error) in
            if let httpResponse = response as? HTTPURLResponse, let jsonData = jsonData {
                print("Statuscode: \(httpResponse.statusCode)")
                if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
                    print(JSONString)
                }
                switch httpResponse.statusCode {
                case 200, 201:
                    completionHandler(jsonData, nil)
                case 400:
                    completionHandler(nil, self.getServiceError(jsonData: jsonData))
                case 401:
                    //Force logout
                    break
                case 419:
                    //Access token issue
                    break
                default:
                    if let defaultError = self.getServiceError(jsonData: jsonData) {
                        completionHandler(nil, defaultError)
                    } else {
                        completionHandler(nil, ServiceError(message: "Response is Empty", errorCode: 0))
                    }
                }
            }
        }
        task.resume()
    }
    
    /// Method to get API Url from String
    /// - Parameter url: denotes Url String
    /// - Returns: denotes Url
    private func getURL(url: String) -> URL {
        return URL(string: url)!
    }
    
    /// Method to parsee a error response from Json
    /// - Parameter jsonData: Denotes JSondata
    /// - Returns: denotes ZivameError
    private func getServiceError(jsonData: Data) -> ServiceError? {
        do {
            return try JSONDecoder().decode(ServiceError.self, from: jsonData)
        } catch let error {
            return ServiceError(message: error.localizedDescription, errorCode: 0)
        }
    }
    
    
    /// Mwthod to get all most papular news
    /// - Parameters:
    ///   - url: String
    ///   - completionHandler: (_ result: MostPapularNews?, _ error: ServiceError?)
    func getMostPapularNews(url: String, completionHandler: @escaping (_ result: MostPapularNews?, _ error: ServiceError?) -> Void) {
        requestJson(url: getURL(url: url)) { result, error in
            if let error = error {
                completionHandler(nil, ServiceError(message: error.message, errorCode: 0))
            } else if let result = result {
                do {
                    let allProductList = try JSONDecoder().decode(MostPapularNews.self, from: result as! Data)
                    completionHandler(allProductList, nil)
                } catch let error {
                    print(error)
                    completionHandler(nil, ServiceError(message: error.localizedDescription, errorCode: 0))
                }
            }
        }
    }

}


