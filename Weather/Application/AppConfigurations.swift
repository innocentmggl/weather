//
//  AppConfigurations.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/13.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import Keys

/**
   Base Api url configurations
*/
enum BaseUrl: String {
    case dev = "http://api.openweathermap.org/data/2.5"
}

/**
   Singleton data provider class for setting up app specific configurations.
*/
final class AppConfigurations {

    static let shared = AppConfigurations()

    private init() {}

    lazy var keys = WeatherKeys()

    lazy var environmentUrl: BaseUrl = {
        return .dev
    }()

    lazy var accessToken: String = {
        return keys.apiKey
    }()

    lazy var apiBaseUrl: String = {
        return environmentUrl.rawValue
    }()
    lazy var imageUrl: String = {
        return "http://openweathermap.org/img/wn/"
    }()
}
