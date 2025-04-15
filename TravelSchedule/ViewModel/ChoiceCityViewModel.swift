//
//  ChoiceCityViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 13.04.2025.
//

import Foundation
import Combine

class ChoiceCityViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var isSearching = false
    
    private let allCities: [City] = [
        City(name: "Москва", stations: [
            Station(name: "Казанский вокзал"),
            Station(name: "Киевский вокзал")
        ]),
        City(name: "Санкт-Петербург", stations: [
            Station(name: "Московский вокзал"),
            Station(name: "Ладожский вокзал")
        ])
    ]
    
    var filteredCities: [City] {
        searchText.isEmpty
            ? allCities
            : allCities.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    func updateSearchingState() {
        isSearching = !searchText.isEmpty
    }
}
