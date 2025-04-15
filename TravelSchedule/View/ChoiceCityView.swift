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
    
    var body: some View {
        VStack(spacing: 0) {
            SearchBar(text: $viewModel.searchText, isSearching: $viewModel.isSearching)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.white)
            
            if viewModel.filteredCities.isEmpty && !viewModel.searchText.isEmpty {
                VStack {
                    Spacer()
                    Text("Город не найден")
                        .font(.system(size: 24))
                        .bold()
                        .foregroundColor(.blackYP)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            } else {
                List {
                    ForEach(viewModel.filteredCities) { city in
                        NavigationLink(
                            destination: ChoiceStationView(
                                city: city,
                                selectedStation: $selectedStation
                            )
                        ) {
                            RowView(title: city.name)
                        }
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.white)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
        .background(Color.white)
        .navigationTitle("Выбор города")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.black)
                        .font(.system(size: 20, weight: .bold))
                }
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


