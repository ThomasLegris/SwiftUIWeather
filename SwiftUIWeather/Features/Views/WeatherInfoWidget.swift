//
//  WeatherInfoWidget.swift
//  SwiftUIWeather
//
//  Created by Thomas LEGRIS in 2022.
//

import SwiftUI

/// Main widget displaying temperature, description..
struct WeatherInfoWidget: View {
    // MARK: - Internal Properties
    @ObservedObject var model: CommonWeatherModel

    // MARK: - Init
    init(model: CommonWeatherModel) {
        _model = ObservedObject(wrappedValue: model)
    }

    // MARK: - UI
    var body: some View {
        VStack(alignment: .center, spacing: 16.0) {
            HStack(alignment: .top) {
                Image(Asset.icThermometer.name)
                    .frame(width: 20.0,
                           height: 20.0,
                           alignment: .leading)
                Spacer()

                Text(model.temperatureString)
                    .multilineTextAlignment(.trailing)
                    .frame(alignment: .trailing)
                    .font(.largeTitle)

            }.padding(24.0)

            Image(model.iconName)
                .resizable()
                .frame(width: 80.0,
                       height: 80.0)
            Spacer()
            Text(model.description)
                .padding(24.0)
                .font(.callout)
                .foregroundColor(Color.gray.opacity(0.8))
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .background(Color.white.opacity(0.4).ignoresSafeArea())
            .overlay(RoundedRectangle(cornerRadius: 10.0)
                        .stroke(.white, lineWidth: 1.0))
            .padding(24.0)

    }
}

struct WeatherInfoWidget_Previews: PreviewProvider {
    static var previews: some View {
        WeatherInfoWidget(model: CommonWeatherModel(temperature: 0.0,
                                                    iconName: "icSun",
                                                    description: "-",
                                                    cityName: "-"))
    }
}
