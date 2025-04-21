//
//  RouteInputView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//
import SwiftUI

struct RouteInputView: View {
    @StateObject private var viewModel = RouteInputViewModel()
    @State private var navigationPath = NavigationPath()
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack(spacing: Constants.spacing) {
                Spacer()
                
                RouteInputFields(
                    viewModel: viewModel,
                    navigationPath: $navigationPath
                )
                .padding(.top, Constants.spacing)
                
                if viewModel.isSearchEnabled {
                    Button(action: viewModel.performSearch) {
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
            .navigationBarBackButtonHidden(true)
        }
    }
}

