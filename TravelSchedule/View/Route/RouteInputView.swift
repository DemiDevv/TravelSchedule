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
                
                Spacer()
                    .frame(height: 24)
                // Горизонтальная лента сторис
                StoriesHorizontalView(stories: $storiesData.stories) { story in
                    if let index = storiesData.stories.firstIndex(where: { $0.id == story.id }) {
                        storiesData.stories[index].isViewed = true
                        navigationPath.append(story)
                    }
                }
                
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
                ZStack(alignment: .topTrailing) {
                    StoriesView(
                        stories: storiesData.stories,
                        currentStoryIndex: .constant(storiesData.stories.firstIndex(of: story) ?? 0),
                        onClose: {
                            navigationPath.removeLast()
                        }
                    )
                    .ignoresSafeArea()
                }
                .background(Color.black)
                .navigationBarBackButtonHidden(true)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
    
    private func mockTrains(for routeInfo: RouteInfo) -> [TrainInfo] {
        let calendar = Calendar.current
        let now = Date()
        
        func createDate(day: Int, hour: Int, minute: Int) -> Date? {
            var components = calendar.dateComponents([.year, .month], from: now)
            components.day = day
            components.hour = hour
            components.minute = minute
            
            guard let date = calendar.date(from: components) else {
                // Возвращаем nil или можно поставить дефолтную дату
                return nil
            }
            return date
        }
        
        return [
            TrainInfo(
                companyName: "РЖД",
                companyLogo: Image(systemName: "tram.fill"),
                note: "Костроме",
                date: createDate(day: 14, hour: 0, minute: 0) ?? Date(),
                departureTime: createDate(day: 14, hour: 22, minute: 30) ?? Date(),
                arrivalTime: createDate(day: 15, hour: 8, minute: 15) ?? Date(),
                duration: 20 * 3600
            ),
            TrainInfo(
                companyName: "ФГК",
                companyLogo: Image(systemName: "bolt.car.fill"),
                note: nil,
                date: createDate(day: 15, hour: 0, minute: 0) ?? Date(),
                departureTime: createDate(day: 15, hour: 1, minute: 15) ?? Date(),
                arrivalTime: createDate(day: 15, hour: 9, minute: 0) ?? Date(),
                duration: 9 * 3600
            )
        ]
    }
}

// MARK: - Preview
#Preview("Route Input View Preview") {
    RouteInputView()
        .environmentObject(StoriesStabData.shared)
        .preferredColorScheme(.light)
}
