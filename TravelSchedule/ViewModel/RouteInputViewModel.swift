//
//  RouteInputViewModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 15.04.2025.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class RouteInputViewModel: ObservableObject {
    @Published var fromCity: City?
    @Published var fromStation: Station?
    @Published var toCity: City?
    @Published var toStation: Station?
    @Published var allCities: [City] = []
    @Published var isLoading: Bool = false
    
    private var isLoaded: Bool = false
    private var cancellables = Set<AnyCancellable>()
    
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
    
    func loadCities() async throws {
        guard !isLoaded else { return }
        isLoading = true
        
        do {
            let fetchedCities = try await DataNetworkService.shared.allStations()
            var newCities: [City] = []
            
            for city in fetchedCities {
                var newStations: [Station] = []
                
                for station in city.stations ?? [] {
                    let oneMoreStation = Station(
                        name: station.title ?? "Название станции отсутствует",
                        code: station.codes?.yandex_code ?? ""
                    )
                    newStations.append(oneMoreStation)
                }
                
                let cityName = city.title ?? "Название города отсутствует"
                let newCity = City(name: cityName, stations: newStations)
                newCities.append(newCity)
            }
            
            self.allCities = newCities
            CommonData.shared.commonCities = newCities
            isLoaded = true
        } catch {
            print("Ошибка загрузки городов и станций: \(error.localizedDescription)")
            throw error
        }
        
        isLoading = false
    }
    
    func setFromCity(_ city: City) {
        fromCity = city
        fromStation = nil
    }
    
    func setToCity(_ city: City) {
        toCity = city
        toStation = nil
    }
    
    func setFromStation(_ station: Station) {
        fromStation = station
    }
    
    func setToStation(_ station: Station) {
        toStation = station
    }
}
