//
//  RouteInputViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 15.04.2025.
//

import Foundation
import Combine
import SwiftUICore

class RouteInputViewModel: ObservableObject {
    @Published var from: CityStation = CityStation(city: "Откуда")
    @Published var to: CityStation = CityStation(city: "Куда")
    @Published var isSelectingFrom = false
    @Published var isSelectingTo = false
    
    var isSearchEnabled: Bool {
        from.city != "Откуда" && to.city != "Куда"
    }
    
    func textColor(for field: CityStation) -> Color {
        field.city == "Откуда" || field.city == "Куда" ? .gray : .black
    }
    
    func swapStations() {
        swap(&from, &to)
    }
    
    func performSearch() {
        print("Поиск маршрута от \(from.displayName) до \(to.displayName)")
        // Здесь будет логика поиска маршрутов
    }
    
    func resetSelection(for fieldType: FieldType) {
        switch fieldType {
        case .from:
            isSelectingFrom = false
        case .to:
            isSelectingTo = false
        }
    }
    
    enum FieldType {
        case from, to
    }
}
