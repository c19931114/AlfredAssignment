//
//  APIManager.swift
//  AlfredAssignment
//
//  Created by Crystal on 2022/7/10.
//

import Foundation

class APIManager {
    
    private let baseURL: URL = URL(string: "https://api.imgur.com/3")!
    private let clientID = "63911e965ccb361"
    
    let session: URLSession = URLSession(configuration: .default)
    
    typealias APICompletionHandler = (GallerySearchResult?, Error?) -> Void
    
    func searchGallery(page: Int = 0, 
                      query: String,
                      completion: @escaping APICompletionHandler) {
        
        guard let request = buildSearchGalleryRequest(page: page, query: query) else {
            // TODO: error handle
            return
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else { return }
                    if httpResponse.statusCode == 200 {
                        print("success")
                        do {
                            let apiData = try JSONDecoder().decode(GallerySearchResult.self, from: data)
                            completion(apiData, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        print(httpResponse.statusCode)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    }
    
    private func buildSearchGalleryRequest(page: Int, query: String) -> URLRequest? {
        let baseURL = baseURL.appendingPathComponent("/gallery/search")
            .appendingPathComponent(String(page))
        let parameters: [String : CustomStringConvertible] = ["q": query]
        
        guard var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            return nil
        }
        components.queryItems = parameters.keys.map { key in
            URLQueryItem(name: key, value: parameters[key]?.description)
        }
        guard let url = components.url else {
            return nil
        }
        return buildRequest(url: url)
    }
    
    private func buildRequest(url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("Client-ID \(clientID)", forHTTPHeaderField: "Authorization")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
}
