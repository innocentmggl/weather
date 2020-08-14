//
//  WeatherResponse.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/41.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

/// Structure responsible for mapping search response
struct WeatherResponse {
    let code: String
    let message: String
    let city: City?
    let results: [Weather]?

    enum CodingKeys: String, CodingKey {
        case code = "cod", message, city, results = "list"
    }
}

extension WeatherResponse: Decodable {
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decode(String.self, forKey: .code)
        city = try values.decodeIfPresent(City.self, forKey: .city)
        results = try values.decodeIfPresent([Weather].self, forKey: .results)

        do {
            message = try values.decode(String.self, forKey: .message)
        } catch {
            message = try String(values.decode(Int.self, forKey: .message))
        }
    }
}

extension WeatherResponse {
    func dailyTemperatures() -> DailyForecast {
        var temperatures: [DailyTemperature] = [DailyTemperature]()
        let grouped = results?.groupSort(byDate: {$0.date})
        grouped?.forEach({ day in
            let max = dailyMax(weather: day)
            let min = dailyMin(weather: day)
            if let date = day.first?.date {
                temperatures.append(DailyTemperature(date: date, minimum: max, maximum: min, items: day))
            }
        })
        return DailyForecast(city: self.city!, temperatures: temperatures)
    }

    private func dailyMin(weather: [Weather]) -> String {
        let min = weather.map {$0.forecast.minimum}.min()
        return min != nil ? "\(Int(min!))\u{00B0}" : "-"
    }

    private func dailyMax(weather: [Weather]) -> String {
        let max = weather.map {$0.forecast.maximum}.max()
        return max != nil ? "\(Int(max!))\u{00B0}" : "-"
    }
}
