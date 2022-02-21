//
//  ApiCallers.swift
//  spotify
//
//  Created by Naman Jain on 12/05/21.
//

import Foundation

class ApiCallers{
    static let shared = ApiCallers()
    
    private init(){}
    
    struct Constants{
        static let baseApiUrl = "https://imdb8.p.rapidapi.com"
    }
    
    enum ApiError: Error{
        case failedToGetData
        case successToGetData
    }
    
    public func getAutoCompleteSuggestion(query: String, completion: @escaping (Result<MovieData,Error>)-> Void){
        createRequest(with: URL(string:  "\(Constants.baseApiUrl)/auto-complete?q=\(query)"), type: .GET) { baseRequest in
            let task = URLSession.shared.dataTask(with: baseRequest) { (data, _, error) in
                guard let data = data, error == nil else{
                    completion(.failure(ApiError.failedToGetData))
                    return
                }
                do{
                    let result = try JSONDecoder().decode(MovieData.self, from: data)
//                    print(result)
                    print(NSString(data: data, encoding: String.Encoding.utf8.rawValue))
                    completion(.success(result))
                    
                }
                catch{
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
    
    
    
    enum HTTPMethod: String{
        case GET
        case POST
    }
    
    
    
    private func createRequest(with url: URL?,type: HTTPMethod,completion: @escaping (URLRequest)-> Void){
        guard let apiURL = url else{
            return
        }
        let headers = [
            "x-rapidapi-host": "imdb8.p.rapidapi.com",
            "x-rapidapi-key": "ebecbf498fmsh6f4146c0d3d1bccp1f67afjsn5ca88ec259d6"
        ]
        var request = URLRequest(url: apiURL)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = 5
        completion(request)
    }

}
