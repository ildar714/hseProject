//
//  NetworkTemperatureResponse.swift
//  hseProject_1
//
//  Created by Ildar on 8/14/20.
//  Copyright © 2020 Ildar Nigmetzyanov. All rights reserved.
//

import UIKit
import SwiftyJSON

enum NetworkTemperatureError: Error {
    case badData
    case badEncodingJSON
    case errorForRequest
    case badUrl
    case deviceIdError
}

class NetworkTemperatureResponse {

    private static var sensorDataDict: [String: JSON] = [:]

    static func getResponse<T>(with string: String, completion:@escaping (Result<T, NetworkTemperatureError>) -> Void) {
        if let url = URL(string: string) {
            let request = URLRequest(url: url)
            URLSession.shared.dataTask(with: request) {data, _, error in
                guard error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(.errorForRequest))
                    }
                    return
                }
                if let data = data {
                    if let data = String(bytes: data, encoding: .utf8) as? T {
                        completion(.success(data))
                    } else {
                        completion(.failure(.deviceIdError))
                    }
                } else {
                    completion(.failure(.badData))
                    return
                }
            }.resume()
        } else {
            completion(.failure(.badUrl))
            return
        }
    }
}