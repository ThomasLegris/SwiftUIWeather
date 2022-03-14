//
//  WeatherApI.swift
//  SwiftUIWeather
//
//  Created by Thomas LEGRIS in 2022.
//

import Foundation

// MARK: - Protocols
/// Stores methods for OpenWeatherMap API calls.
protocol WeatherApi {
    /// Requests local weather.
    ///
    /// - Parameters:
    ///     - cityName: name of the city
    ///     - completion: handler which give weather model and optionnal error
    func requestDailyWeather(cityName: String, completion: @escaping (_ model: CommonWeatherModel?, _ error: WeatherManagerError?) -> Void)
}

// MARK: - Internal Enums
/// Stores potential errors which could occur during an API call.
enum WeatherManagerError: Error {
    case noData
    case genericError
    case jsonParsingError
}

// MARK: - Internal Properties
extension WeatherManagerError {
    /// Returns title for error.
    var errorTitle: String {
        switch self {
        case .noData:
            return L10n.errorNoInfo
        case .genericError:
            return L10n.commonError
        case .jsonParsingError:
            return L10n.errorUnknownCity
        }
    }
}
