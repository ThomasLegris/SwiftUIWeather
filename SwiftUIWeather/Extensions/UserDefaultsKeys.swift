//
//  UserDefaultsKeys.swift
//  SwiftUIWeather
//
//  Created by Thomas LEGRIS in 2022.
//

import SwiftyUserDefaults

/// Defines key to store in UserDefaults.
extension DefaultsKeys {
    var lastSearchedCity: DefaultsKey<String> { .init("key_lastSearchedCity", defaultValue: "") }
    var lastUpdatedDate: DefaultsKey<String> { .init("key_lastUpdatedDate", defaultValue: "") }
}
