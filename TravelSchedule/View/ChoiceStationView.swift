//
//  ChoiceStationView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//

import SwiftUI

struct ChoiceStationView: View {
    let city: String
    @Binding var selected: CityStation
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    let stations = [
        "Казанский вокзал", "Киевский вокзал", "Курский вокзал",
        "Ярославский вокзал", "Белорусский вокзал",
        "Савеловский вокзал", "Ленинградский вокзал"
    ]
    
    @State private var searchText = ""

    var body: some View {
        List {
            ForEach(filteredStations, id: \.self) { station in
                Button(action: {
                    selected = CityStation(city: city, station: station)
                    dismiss()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    RowView(title: station)
                }
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(Color.white)
            }
        }
        .listStyle(PlainListStyle())
        .background(Color.white)
        .searchable(text: $searchText, prompt: "Введите запрос")
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                }
            }
        }
    }

    var filteredStations: [String] {
        searchText.isEmpty ? stations : stations.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
}

struct ChoiceStationView_Previews: PreviewProvider {
    @State static var selected = CityStation(city: "Москва", station: nil)

    static var previews: some View {
        NavigationView {
            ChoiceStationView(city: "Москва", selected: $selected)
        }
    }
}
