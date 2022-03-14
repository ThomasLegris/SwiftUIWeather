//
//  CurrentWeatherModel.swift
//  SwiftUIWeather
//
//  Created by Thomas LEGRIS in 2022.
//

import UIKit

// MARK: - Structs
/// Model used for updating the custom widget view.
class CommonWeatherModel: ObservableObject {
    // MARK: - Internal Properties
    var temperature: Float
    var iconName: String
    var description: String
    var cityName: String

    init(temperature: Float,
         iconName: String,
         description: String,
         cityName: String) {
        self.temperature = temperature
        self.iconName = iconName
        self.description = description
        self.cityName = cityName
    }
}

// MARK: - Helpers
extension CommonWeatherModel {
    /// Return current temperature as string.
    var temperatureString: String {
        return String(self.temperature.rounded()) + "°"
    }
}

// MARK: - Public Enums
/// Provides different weather description.
enum WeatherGroup {
    case thunder
    case drizzle
    case rain
    case snow
    case atmosphere
    case clear
    case clouds

    /// Returns Icon name corresponding to the current weather description.
    var iconName: String {
        switch self {
        case .thunder:
            return Asset.icThunder.name
        case .rain,
                .drizzle:
            return Asset.icRain.name
        case .snow:
            return Asset.icSnow.name
        case .atmosphere:
            return Asset.icFog.name
        case .clear:
            return Asset.icSun.name
        case .clouds:
            return Asset.icSunCloudy.name
        }
    }
}

