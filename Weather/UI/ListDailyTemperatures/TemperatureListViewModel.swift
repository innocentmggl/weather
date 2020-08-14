//
//  TemperatureListViewModel.swift
//  weather
//
//  Created by Innocent Magagula on 2020/08/14.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation

enum Router {
    case none
    case showDetails(viewModel: ViewWeatherDetailsViewModel)
}

// MARK: - INPUTS
protocol TemperatureListViewModelInput {
    func getDailyTemperaturesFor(latitude: Double, longitude: Double)
    func selectedItem(at index: Int)
}

// MARK: - OUTPUTS
protocol TemperatureListViewModelOutput {
    var city: Observer<String> { get }
    var items: Observer<[DailyTemperature]> { get }
    var error: Observer<String> { get }
    var loading: Observer<Bool> { get }
    var message: Observer<String> { get }
    var route: Observer<Router> { get }
}

protocol TemperatureListViewModel: TemperatureListViewModelInput, TemperatureListViewModelOutput {}

/// Simple class that implements `TemperatureListViewModel` and provides inputs and outputs for `TemperatureListViewController`
final class DefaultTemperatureListViewModel: TemperatureListViewModel {

    let repository: OpenWeatherApiRepository
    private var forecast: DailyForecast?

    // MARK: - OUTPUTS
    let items: Observer<[DailyTemperature]> = Observer([DailyTemperature]())
    let error: Observer<String> = Observer("")
    let city: Observer<String> = Observer("")
    let loading: Observer<Bool> = Observer(false)
    let message: Observer<String> = Observer("")
    let route: Observer<Router> = Observer(.none)

    init(repository: OpenWeatherApiRepository) {
        self.repository = repository
    }

    func getDailyTemperaturesFor(latitude: Double, longitude: Double) {
        self.loading.value = true
        self.repository.getForecastWith(latitude: latitude, longitude: longitude) {  results in
            self.loading.value = false
            switch results {
            case .success(let response):
                self.forecast = response
                self.items.value = response.temperatures
                self.city.value = response.city.name
            case .failure(let error):
                self.handleApiFailure(error: error)
            }
        }
    }

    // MARK: - INPUTS
    /**
     Creates a route with a view model of passing in the selected item from a table view.
     - Parameters:
     - index: Index of selected item.
     */
    func selectedItem(at index: Int) {
        let item  = items.value[index].items
        let viewModel = DefaultViewWeatherDetailsViewModel(city: forecast!.city, forecast: item)
        self.route.value = .showDetails(viewModel: viewModel)
    }

    /**
     Handles api error response.
     - Parameters:
     - error: enum error object
     */
    private func handleApiFailure(error: ApiError) {
        switch error {
        case .known(let message):
            if let message = message {
                self.message.value = message.firstUppercased
            } else {
                self.error.value = "error.unknown".localized()
            }
        case .unknown(let error):
            if let error = error {
                self.error.value = error.localizedDescription
            } else {
                self.error.value = "error.unknown".localized()
            }
        }
    }
}
