//
//  WinePairingAPI.swift
//  RestaurantMenu
//
//  Created by Monika Mateska on 5/15/21.
//

import Foundation
import Combine

struct WinePairingAPI {
    struct Response<T, Error> {
        let value: T
        let response: URLResponse
    }
    
    let headers = [
        "x-rapidapi-key": "1a72ed1f78msh63d546d1ac31dcdp147c77jsn2baf555ca4f8",
        "x-rapidapi-host": "spoonacular-recipe-food-nutrition-v1.p.rapidapi.com"
    ]
    
    func getWines(for searchText: String) -> AnyPublisher<WinePairingResponseModel, Error> {
        let urlString = "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/food/wine/pairing?food=\((searchText))"
        var request = URLRequest(url: URL(string: urlString)!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .mapError { $0 as Error }
            .map { $0.data }
            .decode(type: WinePairingResponseModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getImageData(from url: URL) -> AnyPublisher<Data, Error> {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .mapError { $0 as Error }
            .map { $0.data }
            .eraseToAnyPublisher()
    }
}
