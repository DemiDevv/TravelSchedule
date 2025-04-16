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
    
    @Published var allCities: [City] = []
    
    init() {
        let moscow = City(name: "Москва", stations: [Station(name: "Ленинградский вокзал"), Station(name: "Казанский вокзал"), Station(name: "Киевский вокзал"), Station(name: "Савеловский вокзал"), Station(name: "Белорусский вокзал"), Station(name: "Ярославский вокзал")])
        let spb = City(name: "Санкт Петербург", stations: [Station(name: "Московский вокзал"), Station(name: "Финляндский вокзал"), Station(name: "Ладожский вокзал"), Station(name: "Витебский вокзал"), Station(name: "Балтийский вокзал")])
        let sochi = City(name: "Сочи", stations: [Station(name: "Вокзал Сочи")])
        let gv = City(name: "Горный воздух", stations: [Station(name: "Станция Горный Воздух")])
        let krasnodar = City(name: "Краснодар", stations: [Station(name: "Вокзал Краснодара")])
        let kazan = City(name: "Казань", stations: [Station(name: "Вокзал Казани")])
        let omsk = City(name: "Омск", stations: [Station(name: "Вокзал Омска")])
        
        self.allCities = [moscow, spb, sochi, gv, krasnodar, kazan, omsk]
    }
    
    var filteredCities: [City] {
        searchText.isEmpty
            ? allCities
            : allCities.filter { $0.name.lowercased().contains(searchText.lowercased()) }
    }
    
    func updateSearchingState() {
        isSearching = !searchText.isEmpty
    }
}
