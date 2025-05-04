//
//  ChoiceCityViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 13.04.2025.
//

import Foundation
import Combine

@MainActor
final class ChoiceCityViewModel: ObservableObject {
    @Published var searchText = ""
    @Published var isSearching = false
    
    var allCities: [City] {
        CommonData.shared.commonCities
    }
    
    var filteredCities: [City] {
        let searchLower = searchText.lowercased()
        return searchText.isEmpty
            ? allCities
            : allCities.filter { $0.name.lowercased().contains(searchLower) }
    }
    
    func updateSearchingState() {
        isSearching = !searchText.isEmpty
    }
}
