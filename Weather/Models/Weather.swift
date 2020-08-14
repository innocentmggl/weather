//
//  Weather.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

struct Weather {
    let date: Date
    let dateString: String
    let forecast: Forecast
    let description: [WeatherDescription]
    let clouds: Clouds
    let wind: Wind
    let visibility: Double
    private let dateFormatter = DateFormatter()

    func time() -> String {
        dateFormatter.dateFormat = "h a"
        return dateFormatter.string(from: self.date)
    }

    func imageUrl() -> URL? {
        if let icon = description.first?.icon, let url = URL(string: "\(AppConfigurations.shared.imageUrl)\(icon)@2x.png") {
            return url
        }
        return nil
    }
}

extension Weather: Decodable {
    enum CodingKeys: String, CodingKey {
        case date = "dt"
        case dateString = "dt_txt"
        case forecast = "main"
        case description = "weather"
        case clouds, wind, visibility
    }
}

extension Weather: Hashable {
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.date == rhs.date
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(date)
    }
}

struct Forecast {
    let temperature: Double
    let feelsLikeTemp: Double
    let minimum: Double
    let maximum: Double
    let pressure: Double
    let humidity: Double
}

extension Forecast: Decodable {
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLikeTemp = "feels_like"
        case minimum = "temp_min"
        case maximum = "temp_max"
        case pressure
        case humidity
    }
}

struct WeatherDescription {
    let heading: String
    let description: String
    let icon: String
}

extension WeatherDescription: Decodable {
    enum CodingKeys: String, CodingKey {
        case heading = "main"
        case description
        case icon
    }
}

struct Wind {
    let speed: Double
    let direction: Double
}

extension Wind: Decodable {
    enum CodingKeys: String, CodingKey {
        case speed
        case direction = "deg"
    }
}

struct Clouds {
    let all: Double
}

extension Clouds: Decodable {
    enum CodingKeys: String, CodingKey {
        case all
    }
}

struct City {
    let id: Int
    let name: String
    let coordinate: CityCoordinates
    let country: String
    let sunrise: Date
    let sunset: Date
}

extension City: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case coordinate = "coord"
        case country
        case sunrise
        case sunset
    }
}

struct CityCoordinates {
    let latitude: Double
    let longitude: Double
}

extension CityCoordinates: Decodable {
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
    }
}
