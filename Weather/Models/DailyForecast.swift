//
//  DailyForecast.swift
//  Weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

struct DailyForecast {
    let city: City
    let temperatures: [DailyTemperature]
}

struct DailyTemperature {

    let date: Date
    let minimum: String
    let maximum: String
    let items: [Weather]
    private let dateFormatter = DateFormatter()

    func dayOfWeek() -> String {
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self.date)
    }

    func dayOfMonth() -> String {
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self.date)
    }

}
