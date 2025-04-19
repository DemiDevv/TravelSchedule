//
//  NavigationPath.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 19.04.2025.
//

import SwiftUI

enum Screen: Hashable {
    case city(Bool)
    case station(String, [Station], Bool)
    case toRoot
}

final class NavigationModel: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popRoot() {
        path = NavigationPath()
    }
}

//struct Route {
//    @ViewBuilder
//    static func destination(_ screen: Screen, from: Binding<String>, toIn: Binding<String>) -> some View {
//        switch screen {
//        case .city(let isFrom):
//            ChoiceCityView(data: ModelData.cities, selectedCity: isFrom ? from : toIn, isFrom: isFrom)
//        case .station(let city, let stations, let isFrom):
//            ChoiceStationView(city: city, stations: stations, selectedStation: isFrom ? from : toIn, isFrom: isFrom)
//        case .toRoot:
//            EmptyView()
//        }
//    }
//}
