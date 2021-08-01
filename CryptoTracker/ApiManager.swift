//
//  ApiManager.swift
//  CryptoTracker
//
//  Created by Zapp Antonio on 1/8/21.
//

import UIKit
enum HttpMethod: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case PATCH = "PATCH"
    case DELETE = "DELETE"
}
final class ApiManager {

    static let shared = ApiManager()
    private init(){}
    
    struct Constants {
        static let apiKey = "f5399ba6-74ec-4d61-b347-44c9e80c7430"
        static let apiKeyHeader = "X-CMC_PRO_API_KEY"
        static let apiUrl = "https://pro-api.coinmarketcap.com/v1/"
        static let eth = "ethereum"
        static let endPoint = "cryptocurrency/quotes/latest"
    }
    
    
    enum ApiError: Error {
        case invalidUrl
        case failed
        case parseFailed
    }
    func getEthereumData(_ completionHandler: @escaping (Result<CryptoCoinData, Error>) -> Void ) {
        guard let url = URL(string: Constants.apiUrl + Constants.endPoint + "?slug=" + Constants.eth) else {
            completionHandler(.failure(ApiError.invalidUrl))
            return
        }
        
        print(url.absoluteString)
        var request = URLRequest(url: url)
        request.addValue(Constants.apiKey, forHTTPHeaderField: Constants.apiKeyHeader)
        request.httpMethod = HttpMethod.GET.rawValue
        
        let task =  URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let  data = data else {
                completionHandler(.failure(ApiError.failed))
                return
            }
            
            do {
                print(String(data: data, encoding: .utf8)!)
                let parsedResponse = try JSONDecoder().decode(ApiResponse.self, from: data)
                
                guard let ethereumData = parsedResponse.data.values.first else {
                    completionHandler(.failure(ApiError.parseFailed))
                    return
                }
                completionHandler(.success(ethereumData))
            }
            
            catch {
                completionHandler(.failure(error))
            }
        }
        
        
        task.resume()
    }
}
