//
//  OpenWeatherApiRepository.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/13.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import Moya

typealias DailyForcastResultValue = (Result<DailyForecast, ApiError>)

enum ApiError: Error {
    case known(String?)
    case unknown(Error?)
}

protocol OpenWeatherApiRepository {
    var provider: MoyaProvider<OpenWeatherApi> { get }
    func getForecastWith(latitude: Double, longitude: Double, completion: @escaping (DailyForcastResultValue) -> Void)
}

class OpenWeatherApiRepositoryImplementation: OpenWeatherApiRepository {
    let provider: MoyaProvider<OpenWeatherApi>

    init(provider: MoyaProvider<OpenWeatherApi>) {
        self.provider = provider
    }

    func getForecastWith(latitude: Double, longitude: Double, completion: @escaping (DailyForcastResultValue) -> Void) {
        self.provider.request(.getForecastWith(latitude: latitude, longitude: longitude)) { result in
            switch result {
            case .success(let response):
                let data = self.parseResponse(response: response)
                completion(data)
            case .failure(let moyaError):
                completion(Result.failure(.unknown(moyaError)))
            }
        }
    }

    private func parseResponse(response: Response) -> DailyForcastResultValue {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let res = try decoder.decode(WeatherResponse.self, from: response.data)
            if res.code == "200" {
                return Result.success(res.dailyTemperatures())
            } else {
                return Result.failure(.known(res.message))
            }
        } catch let error {
            debugPrint("Decoding error: \(error)")
            return Result.failure(.unknown(error))
        }
    }
}
