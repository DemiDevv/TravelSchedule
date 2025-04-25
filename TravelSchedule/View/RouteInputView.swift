//
//  RouteInputView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//

import SwiftUI

struct RouteInputView: View {
    @StateObject private var viewModel = RouteInputViewModel()
    @StateObject private var storiesData = StoriesStabData.shared
    @State private var navigationPath = NavigationPath()
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0) {
                // Горизонтальная лента сторис
                StoriesHorizontalView(stories: $storiesData.stories)
                
                // Отступ 44 между сторис и основным контентом
                Spacer()
                    .frame(height: 44)
                
                // Основной контент
                VStack(spacing: Constants.spacing) {
                    RouteInputFields(
                        viewModel: viewModel,
                        navigationPath: $navigationPath
                    )
                    .padding(.top, Constants.spacing)
                    
                    if viewModel.isSearchEnabled {
                        Button(action: {
                            let routeInfo = RouteInfo(
                                fromCity: viewModel.fromCity,
                                fromStation: viewModel.fromStation,
                                toCity: viewModel.toCity,
                                toStation: viewModel.toStation
                            )
                            navigationPath.append(routeInfo)
                        }) {
                            Text("Найти")
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(width: 150, height: 60)
                                .background(Color.blueYP)
                                .cornerRadius(Constants.cornerRadius)
                        }
                        .padding(.bottom, Constants.spacing)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal)
            }
            .background(isDarkMode ? Color.blackYP : Color.white)
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .choiceCity(let isFromField):
                    ChoiceCityView(
                        isFromField: isFromField,
                        selectedCity: isFromField ? $viewModel.fromCity : $viewModel.toCity,
                        selectedStation: isFromField ? $viewModel.fromStation : $viewModel.toStation,
                        navigationPath: $navigationPath
                    )
                    .ignoresSafeArea(edges: .bottom)
                case .choiceStation(let city, let isFromField):
                    ChoiceStationView(
                        city: city,
                        isFromField: isFromField,
                        selectedStation: isFromField ? $viewModel.fromStation : $viewModel.toStation,
                        navigationPath: $navigationPath
                    )
                    .ignoresSafeArea(edges: .bottom)
                }
            }
            .navigationDestination(for: RouteInfo.self) { routeInfo in
                ListOfCarriersView(
                    routeInfo: routeInfo,
                    trains: mockTrains(for: routeInfo)
                )
            }
            .navigationDestination(for: Story.self) { story in
                // TODO: - Открывание фулл экрана сторис
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func mockTrains(for routeInfo: RouteInfo) -> [TrainInfo] {
        let calendar = Calendar.current
        let now = Date()
        
        func createDate(day: Int, hour: Int, minute: Int) -> Date {
            var components = calendar.dateComponents([.year, .month], from: now)
            components.day = day
            components.hour = hour
            components.minute = minute
            return calendar.date(from: components)!
        }
        
        return [
            TrainInfo(
                companyName: "РЖД",
                companyLogo: Image(systemName: "tram.fill"),
                note: "Костроме",
                date: createDate(day: 14, hour: 0, minute: 0),
                departureTime: createDate(day: 14, hour: 22, minute: 30),
                arrivalTime: createDate(day: 15, hour: 8, minute: 15),
                duration: 20 * 3600
            ),
            TrainInfo(
                companyName: "ФГК",
                companyLogo: Image(systemName: "bolt.car.fill"),
                note: nil,
                date: createDate(day: 15, hour: 0, minute: 0),
                departureTime: createDate(day: 15, hour: 1, minute: 15),
                arrivalTime: createDate(day: 15, hour: 9, minute: 0),
                duration: 9 * 3600
            )
        ]
    }
}
