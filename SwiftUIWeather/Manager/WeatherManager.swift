//
//  WeatherManager.swift
//  SwiftUIWeather
//
//  Created by Thomas LEGRIS in 2022.
//

import Alamofire

/// Manager which handles methods relative to Weather API.
final class WeatherManager {
    // MARK: - Internal Properties
    static let shared: WeatherManager = WeatherManager()

    // MARK: - Private Properties
    /// Returns the Open Weather Map API Key.
    private var apiKey: String {
        // TODO: Fill it with your own OWP Api key. To create one, check this link `https://openweathermap.org/price`.
        return ""
    }

    // MARK: - Init
    private init() { }
}

// MARK: - Private Enums
private extension WeatherManager {
    /// Provides common constants.
    enum Constants {
        static let baseURL: String = "https://api.openweathermap.org/data/2.5/"
        static let tempUnit: String = "metric"
        static let cityParam: String = "q"
        static let unitsParam: String = "units"
        static let keyParam: String = "APPID"
    }
    
    /// Provides OWMap API endpoints.
    enum EndPoints {
        static let weatherEndPoint: String = "weather"
    }
}

// MARK: - WeatherApi
extension WeatherManager: WeatherApi {
    func requestDailyWeather(cityName: String, completion: @escaping (_ model: CommonWeatherModel?, _ error: WeatherManagerError?) -> Void) {
        let params: [String: String] = [Constants.cityParam: cityName,
                                        Constants.unitsParam: Constants.tempUnit,
                                        Constants.keyParam: self.apiKey]
        AF.request(Constants.baseURL + EndPoints.weatherEndPoint,
                   method: .get,
                   parameters: params).responseDecodable(of: LocalWeatherResponse.self) { response in
            guard response.error == nil else {
                completion(nil, WeatherManagerError.genericError)
                return
            }

            guard let response = response.value else {
                completion(nil, WeatherManagerError.noData)
                return
            }

            
            guard let weather = response.weather?.first else {
                completion(nil, WeatherManagerError.jsonParsingError)
                return
            }
            
            completion(CommonWeatherModel(temperature: response.main.temp,
                                          iconName: self.groupFromId(identifier: weather.identifier).iconName,
                                          description: weather.description,
                                          cityName: response.name), nil)
        }
    }
}

// MARK: - Private Funcs
private extension WeatherManager {
    /// Returns weather group according to its identifier.
    ///
    /// - Parameters:
    ///     - identifier: weather call response id
    /// - Returns: A weather group associated to its id.
    func groupFromId(identifier: Int) -> WeatherGroup {
        switch identifier {
        case 200...232:
            return .thunder
        case 300...321:
            return .drizzle
        case 500...531:
            return .rain
        case 600...622:
            return .snow
        case 701...781:
            return .atmosphere
        case 800:
            return .clear
        default:
            return .clouds
        }
    }
}
