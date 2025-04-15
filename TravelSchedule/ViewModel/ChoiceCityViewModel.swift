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
    
    let allCities = ["Москва", "Санкт-Петербург", "Сочи"]
    
    var filteredCities: [String] {
        searchText.isEmpty
            ? allCities
            : allCities.filter { $0.lowercased().contains(searchText.lowercased()) }
    }
    
    func updateSearchingState() {
        isSearching = !searchText.isEmpty
    }
}
