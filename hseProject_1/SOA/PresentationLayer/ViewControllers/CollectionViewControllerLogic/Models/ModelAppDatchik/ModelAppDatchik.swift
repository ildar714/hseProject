//
//  ModelAppDatchik.swift
//  IndoorClimateControlSystems
//
//  Created by Ildar on 12/18/20.
//  Copyright © 2020 Ildar Nigmetzyanov. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol ModelAppDatchikDelegate: class {
    func show2(error message: String)
}

class ModelAppDatchik: ModelAppDatchikProtocol {
    weak var delegate: ModelAppDatchikDelegate?
    private let appDatchikService: AppDatchikServiceProtocol
    init(appDatchikService: AppDatchikServiceProtocol) {
        self.appDatchikService = appDatchikService
    }
    func fetchAppDatchik<T>(type: TypeOfSensor, completion: @escaping (T) -> Void) {
        self.appDatchikService.loadAppDatchik(type: type) { (result: Result<T, NetworkSensorError>) in
            switch result {
            case .success(let result):
                completion(result)

            case .failure(let error):
                print(error.localizedDescription)
                self.delegate?.show2(error: error.localizedDescription)
            }
        }
    }
}
