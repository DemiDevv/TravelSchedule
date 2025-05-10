//
//  ChoiceCityView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 05.04.2025.
//

import SwiftUI

struct ChoiceCityView: View {
    let isFromField: Bool
    @Binding var selectedCity: City?
    @Binding var selectedStation: Station?
    @Binding var navigationPath: NavigationPath
    
    @StateObject private var viewModel = ChoiceCityViewModel()
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
    
    private var searchBar: some View {
        SearchBar(text: $viewModel.searchText, isSearching: $viewModel.isSearching)
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(backgroundColor)
    }
    
    private var notFoundView: some View {
        VStack {
            Spacer()
            Text("Город не найден")
                .font(.system(size: 24))
                .bold()
                .foregroundColor(textColor)
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
    }
    
    private var cityList: some View {
        List {
            ForEach(viewModel.filteredCities) { city in
                Button(action: {
                    selectedCity = city
                    selectedStation = nil
                    navigationPath.append(Destination.choiceStation(city: city, isFromField: isFromField))
                }) {
                    RowView(title: city.name, isDarkMode: isDarkMode)
                }
                .buttonStyle(PlainButtonStyle())
                .listRowInsets(EdgeInsets())
                .listRowSeparator(.hidden)
                .listRowBackground(backgroundColor)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    var body: some View {
        VStack(spacing: 0) {
            searchBar
            
            if viewModel.allCities.isEmpty {
                ErrorView(errors: .noInternet)
            } else if viewModel.filteredCities.isEmpty {
                if viewModel.searchText.isEmpty {
                    ErrorView(errors: .noInternet)
                } else {
                    notFoundView
                }
            } else {
                cityList
            }
        }
        .background(backgroundColor)
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Выбор города")
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

#Preview {
    ChoiceCityView(
        isFromField: false,
        selectedCity: .constant(nil),
        selectedStation: .constant(nil),
        navigationPath: .constant(NavigationPath())
    )
}
