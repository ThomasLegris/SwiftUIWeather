//
//  CityFieldView.swift
//  SwiftUIWeather
//
//  Created by Thomas LEGRIS in 2022.
//

import SwiftUI

/// Text field view to enter name of a desired city.
struct CityFieldView: View {
    // MARK: - Internal Properties
    var searchAction: (String) -> Void

    // MARK: - Private Properties
    @State private var city: String = ""

    // MARK: - UI
    var body: some View {
        HStack(alignment: .center, spacing: 8.0) {
            TextField(L10n.enterCity, text: $city)
                .disableAutocorrection(true)
                .padding()
            Button(action: {
                searchAction(city)
            }) {
                Image(Asset.icSearch.name)
                    .resizable()
                    .frame(width: 20.0,
                           height: 20.0)
                    .padding(.leading, 8.0)
            }

        }.background(Color.white.opacity(0.4))
            .overlay(RoundedRectangle(cornerRadius: 10.0)
                        .stroke(.white, lineWidth: 1.0))
            .padding(8.0)
            .clipped()
            .frame(height: 50.0)
    }
}

struct CityFieldView_Previews: PreviewProvider {
    static var previews: some View {
        CityFieldView(searchAction: { _ in })
    }
}
