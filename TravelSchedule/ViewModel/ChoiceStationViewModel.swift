//
//  ChoiceStationViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 15.04.2025.
//

import Foundation
import Combine

class ChoiceStationViewModel: ObservableObject {
    let city: City
    @Published var searchText = ""
    @Published var isSearching = false
    
    init(city: City) {
        self.city = city
    }
    
    var filteredStations: [Station] {
        searchText.isEmpty
            ? city.stations
            : city.stations.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    func updateSearchingState() {
        isSearching = !searchText.isEmpty
    }
}
