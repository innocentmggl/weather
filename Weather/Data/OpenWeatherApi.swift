//
//  OpenWeatherApi.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/13.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import Moya

enum OpenWeatherApi {
    case getForecastByCity(name: String)
    case getForecastWith(latitude: Double, longitude: Double)
}

// MARK: - TargetType Protocol Implementation
extension OpenWeatherApi: TargetType {
    var baseURL: URL { return URL(string: "\(AppConfigurations.shared.apiBaseUrl)")! }

    var path: String {
        switch self {
        case .getForecastByCity, .getForecastWith:
            return "/forecast"
        }
    }
    var method: Moya.Method {
        switch self {
        case .getForecastByCity, .getForecastWith:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .getForecastByCity(let name):
            let params: [String: Any] = ["q": name, "appid": AppConfigurations.shared.accessToken, "units": "metric"]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .getForecastWith(let latitude, let longitude):
            let params: [String: Any] = ["lat": latitude, "lon": longitude, "appid": AppConfigurations.shared.accessToken, "units": "metric"]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
       }
    }

    var sampleData: Data {
        switch self {
        case .getForecastByCity, .getForecastWith:
            return Data()
        }
    }
    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
