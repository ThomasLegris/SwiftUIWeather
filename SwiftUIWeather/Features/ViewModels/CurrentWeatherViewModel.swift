//
//  CurrentWeatherViewModel.swift
//  SwiftUIWeather
//
//  Created by Thomas LEGRIS in 2022.
//

import SwiftUI
import SwiftyUserDefaults
import Reachability

/// View model used to handle logic for main weather view.
class CurrentWeatherViewModel: ObservableObject {
    // MARK: - Internal Properties
    @Published var error: String?
    @Published var weatherModel: CommonWeatherModel = CommonWeatherModel(temperature: 0.0,
                                                                         iconName: "icSun",
                                                                         description: L10n.dash,
                                                                         cityName: L10n.dash)

    // MARK: - Private Properties
    /// Returns true if connected to internet, false otherwise.
    private var isNetworkReachable: Bool {
        let reachability = try? Reachability()

        return reachability?.connection == .wifi ||  reachability?.connection == .cellular
    }

    // MARK: - Init
    init() {
        if !Defaults.lastSearchedCity.isEmpty {
            searchCity(cityName: Defaults.lastSearchedCity)
        }
    }

    // MARK: - Internal Funcs
    /// Search city with its city name.
    func searchCity(cityName: String) {
        guard isNetworkReachable else {
            error = L10n.errorNoInternet
            return
        }

        WeatherManager.shared.requestDailyWeather(cityName: cityName, completion: { [weak self] model, error in
            guard error?.errorTitle == nil else {
                self?.error = error?.errorTitle
                return
            }
            guard let model = model else {
                self?.error = WeatherManagerError.genericError.errorTitle
                return
            }

            Defaults.lastSearchedCity = model.cityName
            self?.updateLastUpdateDate()
            self?.error = nil
            self?.weatherModel = model
        })
    }
}

// MARK: - Private Funcs
private extension CurrentWeatherViewModel {
    /// Returns weather last updated time in hour.
    func updateLastUpdateDate() {
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        Defaults.lastUpdatedDate = "Last updated weather at \(formatter.string(from: currentDateTime))"
    }
}
