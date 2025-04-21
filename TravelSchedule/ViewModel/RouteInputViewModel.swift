//
//  RouteInputViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 15.04.2025.
//

import Foundation
import Combine
import SwiftUI

final class RouteInputViewModel: ObservableObject {
    @Published var fromCity: City?
    @Published var fromStation: Station?
    @Published var toCity: City?
    @Published var toStation: Station?
    
    var isSearchEnabled: Bool {
        fromStation != nil && toStation != nil
    }
    
    func displayText(isFromField: Bool) -> String {
        let city = isFromField ? fromCity : toCity
        let station = isFromField ? fromStation : toStation
        
        if let city = city, let station = station {
            return "\(city.name) (\(station.name))"
        } else if let city = city {
            return city.name
        }
        return isFromField ? "Откуда" : "Куда"
    }
    
    func textColor(for text: String, isDarkMode: Bool) -> Color {
        (text == "Откуда" || text == "Куда") ? .gray : (isDarkMode ? .whiteYP : .blackYP)
    }
    
    func swapStations() {
        withAnimation {
            swap(&fromCity, &toCity)
            swap(&fromStation, &toStation)
        }
    }
}
