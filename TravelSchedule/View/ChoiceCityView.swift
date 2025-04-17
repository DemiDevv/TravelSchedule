//
//  ChoiceCityView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 05.04.2025.
//

import SwiftUI

struct ChoiceCityView: View {
    @Binding var selectedCity: City?
    @Binding var selectedStation: Station?
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = ChoiceCityViewModel()
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    private var backgroundColor: Color {
        isDarkMode ? Color.blackYP : Color.white
    }
    
    private var textColor: Color {
        isDarkMode ? Color.whiteYP : Color.blackYP
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(isDarkMode ? .whiteYP : .black)
                .font(.system(size: 20, weight: .bold))
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
                NavigationLink(
                    destination: ChoiceStationView(
                        city: city,
                        selectedStation: $selectedStation
                    )
                ) {
                    RowView(title: city.name, isDarkMode: isDarkMode)
                }
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
            
            if viewModel.filteredCities.isEmpty && !viewModel.searchText.isEmpty {
                notFoundView
            } else {
                cityList
            }
        }
        .background(backgroundColor)
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                backButton
            }
        }
        .onChange(of: viewModel.searchText) { _ in
            viewModel.updateSearchingState()
        }
        .onChange(of: selectedStation) { newValue in
            if newValue != nil {
                selectedCity = viewModel.filteredCities.first { $0.stations.contains { $0.id == newValue?.id } }
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}
