//
//  RouteInputViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 15.04.2025.
//

import Foundation
import Combine
import SwiftUICore

final class RouteInputViewModel: ObservableObject {
    @Published var fromCity: City?
    @Published var fromStation: Station?
    @Published var toCity: City?
    @Published var toStation: Station?
    
    @Published var isSelectingFrom = false
    @Published var isSelectingTo = false
    
    var isSearchEnabled: Bool {
        fromStation != nil && toStation != nil
    }
    
    func textForFromField() -> String {
        if let city = fromCity, let station = fromStation {
            return "\(city.name) (\(station.name))"
        }
        return "Откуда"
    }
    
    func textForToField() -> String {
        if let city = toCity, let station = toStation {
            return "\(city.name) (\(station.name))"
        }
        return "Куда"
    }
    
    func textColor(for text: String) -> Color {
        text == "Откуда" || text == "Куда" ? .gray : .black
    }
    
    func swapStations() {
        swap(&fromCity, &toCity)
        swap(&fromStation, &toStation)
    }
    
    func performSearch() {
        guard let fromCity = fromCity, let fromStation = fromStation,
              let toCity = toCity, let toStation = toStation else { return }
        
        print("Поиск маршрута от \(fromCity.name) (\(fromStation.name)) до \(toCity.name) (\(toStation.name))")
    }
}
