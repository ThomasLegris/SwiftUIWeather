//
//  CurrentWeatherView.swift
//  SwiftUIWeather
//
//  Created by Thomas LEGRIS in 2022.
//

import SwiftUI
import SwiftyUserDefaults

/// Main view to display all weather details.
struct CurrentWeatherView: View {
    // MARK: - Internal Properties
    @ObservedObject var viewModel: CurrentWeatherViewModel = CurrentWeatherViewModel()

    // MARK: - UI
    var body: some View {
        VStack(spacing: 24.0) {
            CityFieldView(searchAction: { city in
                self.searchCity(cityName: city)
            })
                .padding(32.0)
                .frame(height: 50.0)
            VStack {
                HStack(alignment: .center) {
                    Image(Asset.icLocation.name)
                        .resizable()
                        .frame(width: 20.0, height: 20.0)
                    Text(viewModel.weatherModel.cityName)
                        .foregroundColor(.black)
                    Spacer()
                }.frame(alignment: .leading)
                    .padding(.horizontal, 32.0)
                WeatherInfoWidget(model: viewModel.weatherModel)
                    .padding(.horizontal)
                    .frame(height: 350.0)
                if let error = viewModel.error {
                    HStack(alignment: .center, spacing: 6.0) {
                        Image(Asset.icWarning.name)
                            .resizable()
                            .frame(width: 16.0,
                                   height: 16.0, alignment: .center)
                        Text(error)
                            .foregroundColor(.red)
                            .font(.system(size: 16.0))
                    }.padding()
                }
            }
            .padding(.vertical, 32.0)
            Spacer()
            if !Defaults.lastUpdatedDate.isEmpty {
                HStack(alignment: .center, spacing: 6.0) {
                    Button(action: {
                        self.searchCity(cityName: Defaults.lastSearchedCity)
                    }) {
                        Image(Asset.icRefresh.name)
                            .resizable()
                            .frame(width: 18.0,
                                   height: 18.0, alignment: .center)
                    }

                    Text(Defaults.lastUpdatedDate)
                        .font(.system(size: 14.0))
                }
            }
        }
        .padding(.top, 24.0)
        .background(Image(Asset.icMainBackground.name).ignoresSafeArea())
    }
}

// MARK: - Private Funcs
private extension CurrentWeatherView {
    /// Search a city with its name.
    func searchCity(cityName: String) {
        viewModel.searchCity(cityName: cityName)
    }
}

struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView()
    }
}
