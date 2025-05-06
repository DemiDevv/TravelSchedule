//
//  ChoiceStationView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//


import SwiftUI

struct ChoiceStationView: View {
    let city: City
    let isFromField: Bool
    @Binding var selectedStation: Station?
    @Binding var navigationPath: NavigationPath
    
    @StateObject private var viewModel: ChoiceStationViewModel
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    private var backgroundColor: Color {
        isDarkMode ? Color.blackYP : Color.white
    }
    
    private var textColor: Color {
        isDarkMode ? .whiteYP : .blackYP
    }
    
    private var backButton: some View {
        Button(action: {
            navigationPath.removeLast()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(isDarkMode ? .whiteYP : .black)
                .font(.system(size: 22, weight: .medium))
        }
    }
    
    init(city: City, isFromField: Bool, selectedStation: Binding<Station?>, navigationPath: Binding<NavigationPath>) {
        self.city = city
        self.isFromField = isFromField
        self._selectedStation = selectedStation
        self._navigationPath = navigationPath
        self._viewModel = StateObject(wrappedValue: ChoiceStationViewModel(city: city))
    }
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(text: $viewModel.searchText, isSearching: $viewModel.isSearching)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(backgroundColor)
            
            if viewModel.filteredStations.isEmpty {
                if viewModel.searchText.isEmpty {
                    ErrorView(errors: .serverError)
                } else {
                    VStack {
                        Spacer()
                        Text("Станция не найдена")
                            .font(.system(size: 24))
                            .foregroundColor(textColor)
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(backgroundColor)
                }
            } else {
                List {
                    ForEach(viewModel.filteredStations) { station in
                        Button(action: {
                            selectedStation = station
                            navigationPath.removeLast(navigationPath.count)
                        }) {
                            RowView(title: station.name, isDarkMode: isDarkMode)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(backgroundColor)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(backgroundColor)
        .navigationTitle("Выбор станции")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Выбор станции")
                    .foregroundColor(textColor)
                    .font(.headline)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

// MARK: - Preview
#Preview {
    PreviewWrapper()
}

private struct PreviewWrapper: View {
    @State private var selectedStation: Station? = nil
    @State private var navigationPath = NavigationPath()

    var body: some View {
        let city = City(name: "Москва", stations: [
            Station(name: "Киевский вокзал", code: ""),
            Station(name: "Курский вокзал", code: ""),
            Station(name: "Ярославский вокзал", code: "")
        ])
        
        return NavigationStack(path: $navigationPath) {
            ChoiceStationView(
                city: city,
                isFromField: true,
                selectedStation: $selectedStation,
                navigationPath: $navigationPath
            )
        }
    }
}

