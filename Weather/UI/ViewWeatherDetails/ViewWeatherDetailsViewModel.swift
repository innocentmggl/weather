//
//  ViewWeatherDetailsViewModel.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/11.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

// MARK: - OUTPUTS
protocol ViewWeatherDetailsViewModelInput {
    func selectedItem(at index: Int)
}

protocol ViewWeatherDetailsViewModelOutput {
    var city: City { get }
    var items: Observer<[Weather]> { get }
    var selectedItem: Observer<Weather> { get }
    var day: Observer<String> { get }
}

protocol ViewWeatherDetailsViewModel: ViewWeatherDetailsViewModelInput, ViewWeatherDetailsViewModelOutput {}

final class DefaultViewWeatherDetailsViewModel: ViewWeatherDetailsViewModel {

    let city: City
    let items: Observer<[Weather]> = Observer([Weather]())
    let selectedItem: Observer<Weather>
    let day: Observer<String>
    private let dateFormatter = DateFormatter()

    init(city: City, forecast: [Weather]) {
        self.city = city
        self.items.value = forecast
        self.selectedItem = Observer(forecast[0])
        self.dateFormatter.dateFormat = "EEEE, d MMM, h a"
        self.day = Observer(dateFormatter.string(from: selectedItem.value.date))
    }
    // MARK: - INPUTS
    /**
     Creates a route with a view model of passing in the selected item from a table view.
     - Parameters:
        - index: Index of selected item.
     */
    func selectedItem(at index: Int) {
        self.selectedItem.value = items.value[index]
        self.day.value = getDateString(date: selectedItem.value.date)
    }

    private func getDateString(date: Date) -> String {
        return dateFormatter.string(from: date)
    }
}
