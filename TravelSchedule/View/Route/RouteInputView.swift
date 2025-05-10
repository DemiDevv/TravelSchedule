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
    @State private var showErrorAlert = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 24)
                
                StoriesHorizontalView(stories: $storiesData.stories) { story in
                    if let index = storiesData.stories.firstIndex(where: { $0.id == story.id }) {
                        storiesData.stories[index].isViewed = true
                        navigationPath.append(story)
                    }
                }
                
                Spacer()
                    .frame(height: 44)
                
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
                ListOfCarriersView(routeInfo: routeInfo)
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
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                        .tint(.blueYP)
                }
            }
            .alert("Ошибка", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            .task {
                await loadCities()
            }
        }
    }
    
    private func loadCities() async {
        do {
            try await viewModel.loadCities()
        } catch {
            errorMessage = "Не удалось загрузить список городов и станций. Пожалуйста, проверьте подключение к интернету."
            showErrorAlert = true
        }
    }
}

#Preview("Route Input View Preview") {
    RouteInputView()
        .environmentObject(StoriesStabData.shared)
        .preferredColorScheme(.light)
}
