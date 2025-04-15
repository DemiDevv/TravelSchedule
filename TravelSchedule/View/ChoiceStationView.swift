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
                .background(Color.white)
            
            if viewModel.filteredStations.isEmpty && !viewModel.searchText.isEmpty {
                VStack {
                    Spacer()
                    Text("Станция не найдена")
                        .font(.system(size: 24))
                        .foregroundColor(.blackYP)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.white)
            } else {
                List {
                    ForEach(viewModel.filteredStations) { station in
                        Button(action: {
                            selectedStation = station
                            dismiss()
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            RowView(title: station.name)
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
        .navigationTitle("Выбор станции")
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
    }
}
