//
//  TrainCellView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 09.04.2025.
//

import SwiftUI

struct TrainCellView: View {
    let train: TrainInfo
    @AppStorage(Constants.isDarkMode.stringValue) private var isDarkMode: Bool = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMMM"
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    private func formatDuration(_ interval: TimeInterval) -> String {
        let hours = Int(interval.rounded(.toNearestOrAwayFromZero)) / 3600
        return "\(hours) часов"
    }
    
    var body: some View {
        ZStack {
            isDarkMode ? Color.whiteYP : Color(.systemGray6)
            
            VStack(spacing: 16) {
                HStack(alignment: .top) {
                    train.companyLogo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                        .padding(.leading, 8)
                        .foregroundColor(isDarkMode ? .blackYP : .primary)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(train.companyName)
                                .font(.system(size: 17))
                                .foregroundColor(isDarkMode ? .blackYP : .primary)
                            
                            Spacer()
                            
                            Text(dateFormatter.string(from: train.date))
                                .font(.system(size: 12))
                                .foregroundColor(isDarkMode ? .gray : .secondary)
                        }
                        
                        if let note = train.note {
                            Text("С пересадкой в \(note)")
                                .font(.system(size: 12))
                                .foregroundColor(.redYP)
                        }
                    }
                    .padding(.trailing, 8)
                }
                
                HStack {
                    Text(timeFormatter.string(from: train.departureTime))
                        .font(.system(size: 17))
                        .foregroundColor(isDarkMode ? .blackYP : .primary)
                    
                    Rectangle()
                        .fill(isDarkMode ? Color.gray : Color.gray.opacity(0.5))
                        .frame(height: 1)
                        .padding(.horizontal, 4)
                    
                    Text(formatDuration(train.duration))
                        .font(.system(size: 12))
                        .foregroundColor(isDarkMode ? .gray : .secondary)
                    
                    Rectangle()
                        .fill(isDarkMode ? Color.gray : Color.gray.opacity(0.5))
                        .frame(height: 1)
                        .padding(.horizontal, 4)
                    
                    Text(timeFormatter.string(from: train.arrivalTime))
                        .font(.system(size: 17))
                        .foregroundColor(isDarkMode ? .blackYP : .primary)
                }
                .padding(.horizontal, 8)
            }
            .padding()
        }
        .frame(height: 104)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

// MARK: - Preview
#Preview {
    let sampleTrain = TrainInfo(
        companyName: "РЖД",
        companyLogo: Image(systemName: "train.side.front.car"),
        note: "Костроме",
        date: Date(),
        departureTime: Date(),
        arrivalTime: Date().addingTimeInterval(3600 * 5 + 60 * 30), // 5 часов 30 минут
        duration: 3600 * 5 + 60 * 30
    )
        TrainCellView(train: sampleTrain)
}
