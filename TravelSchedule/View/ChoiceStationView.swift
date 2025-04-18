//
//  ChoiceStationView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 08.04.2025.
//


import SwiftUI

struct ChoiceStationView: View {
    let city: City
    @Binding var selectedStation: Station?
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
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
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(isDarkMode ? .whiteYP : .black)
                .font(.system(size: 22, weight: .medium))
        }
    }
    
    init(city: City, selectedStation: Binding<Station?>) {
        self.city = city
        self._selectedStation = selectedStation
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
                            dismiss()
                            presentationMode.wrappedValue.dismiss()
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
        .onChange(of: viewModel.searchText) { _ in
            viewModel.updateSearchingState()
        }
    }
}
