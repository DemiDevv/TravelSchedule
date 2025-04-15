//
//  ChoiceStationViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 15.04.2025.
//

import Foundation
import Combine

class ChoiceStationViewModel: ObservableObject {
    let city: String
    @Published var searchText = ""
    @Published var isSearching = false
    
    private let allStations = [
        "Казанский вокзал", "Киевский вокзал", "Курский вокзал",
        "Ярославский вокзал", "Белорусский вокзал",
        "Савеловский вокзал", "Ленинградский вокзал"
    ]
    
    init(city: String) {
        self.city = city
    }
    
    var filteredStations: [String] {
        searchText.isEmpty
            ? allStations
            : allStations.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    func updateSearchingState() {
        isSearching = !searchText.isEmpty
    }
    
    func selectStation(_ station: String, completion: @escaping (CityStation) -> Void) {
        let selection = CityStation(city: city, station: station)
        completion(selection)
    }
}

