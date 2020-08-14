//
//  AppDIContainer.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/13.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import Moya

/**
    Class that abstract the creation of dependancies
*/
final class AppDIContainer {
    // MARK: - Singleton instance
    static let shared = AppDIContainer()

    private init() {}

     // MARK: - TemperatureListViewModel instance
    lazy var temperatureListViewModel: TemperatureListViewModel = {
        return DefaultTemperatureListViewModel(repository: repository)
    }()

    // MARK: - Repository instance
    lazy var repository: OpenWeatherApiRepository = {
        return OpenWeatherApiRepositoryImplementation(provider: moyaProvider)
    }()

    // MARK: - Network instance
    lazy var moyaProvider: MoyaProvider<OpenWeatherApi> = {
        return MoyaProvider<OpenWeatherApi>()
    }()
}
