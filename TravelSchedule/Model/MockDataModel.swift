//
//  MockDataModel.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 19.04.2025.
//

import SwiftUI

final class ModelData {
    
    @Published var carriers: [TrainInfo] = []
    
    @Published var carriersInfo: [Carrier] = [
        Carrier(name: "ОАО \u{00AB}РЖД\u{00BB}", logoURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/RZD.svg/2560px-RZD.svg.png") , email: "info@rzhd.ru", phone: "+7 (495) 123-45-67")
        
    ]
    
    static var cities: [City] = [
        City(name: "Москва", stations: [Station(name: "Белорусский вокзал"),
                                        Station(name: "Казанский вокзал"),
                                        Station(name: "Киевский вокзал"),
                                        Station(name: "Курский вокзал"),
                                        Station(name: "Павелецкий вокзал"),
                                        Station(name: "Рижский вокзал"),
                                        Station(name: "Савеловский вокзал"),
                                        Station(name: "Ярославский вокзал")]),
        
        City(name: "Санкт-Петербург", stations: [Station(name: "Московский вокзал"),
                                                 Station(name: "Ладожский вокзал"),
                                                 Station(name: "Витебский вокзал"),
                                                 Station(name: "Финляндский вокзал"),
                                                 Station(name: "Балтийский вокзал")]),
        
        City(name: "Сочи", stations: [Station(name: "Сочинский вокзал"),
                                      Station(name: "Адлерский вокзал")]),
        
        City(name: "Саратов", stations: [Station(name: "Саратов-Пассажирский")]),
        
        City(name: "Красноярск", stations: [Station(name: "Красноярск-Пассажирский")]),
        
        City(name: "Омск", stations: [Station(name: "Омск-1"), Station(name: "Омск-2")]),
        
        City(name: "Краснодар", stations: [Station(name: "Краснодар-Пассажирский")]),
        
        City(name: "Новосибирск", stations: [Station(name: "Новосибирск-Пассажирский")])
    ]
}


