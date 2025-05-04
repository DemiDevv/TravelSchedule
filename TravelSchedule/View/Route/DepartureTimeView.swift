//
//  DepartureTimeView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 18.04.2025.
//

import SwiftUI

struct DepartureTimeView: View {
    @ObservedObject var viewModel: ListOfCarriersViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedTimes: [String] = []
    @State private var showWithTransfers: Bool? = nil
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    init(viewModel: ListOfCarriersViewModel) {
        self.viewModel = viewModel
        self._selectedTimes = State(initialValue: viewModel.filterArray)
        self._showWithTransfers = State(initialValue: viewModel.isShowWithTransfers)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    .padding(.bottom, 8)

                ForEach(TimeOption.allCases, id: \.self) { option in
                    CustomCheckboxRow(
                        title: option.label,
                        isSelected: selectedTimes.contains(option.rawValue),
                        isDarkMode: isDarkMode
                    ) {
                        if selectedTimes.contains(option.rawValue) {
                            selectedTimes.removeAll { $0 == option.rawValue }
                        } else {
                            selectedTimes.append(option.rawValue)
                        }
                    }
                }
            }
            .padding(.horizontal, 16)

            VStack(alignment: .leading, spacing: 0) {
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(isDarkMode ? .whiteYP : .blackYP)
                    .padding(.bottom, 8)

                CustomRadioRow(
                    title: "Да",
                    isSelected: showWithTransfers == true,
                    isDarkMode: isDarkMode
                ) {
                    showWithTransfers = true
                }

                CustomRadioRow(
                    title: "Нет",
                    isSelected: showWithTransfers == false,
                    isDarkMode: isDarkMode
                ) {
                    showWithTransfers = false
                }
            }
            .padding(.horizontal, 16)

            Spacer()

            Button(action: {
                viewModel.filterArray = selectedTimes
                viewModel.isShowWithTransfers = showWithTransfers
                dismiss()
            }) {
                Text("Применить")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(height: 60)
            .background(Color.blueYP)
            .cornerRadius(16)
            .padding(.horizontal)
            .padding(.top, 8)
        }
        .padding(.top, 16)
        .background(isDarkMode ? Color.blackYP : Color.whiteYP)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(isDarkMode ? .white : .black)
                        .font(.system(size: 22, weight: .medium))
                }
            }
        }
    }
}
