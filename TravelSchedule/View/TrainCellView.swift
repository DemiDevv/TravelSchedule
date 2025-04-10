//
//  TrainCellView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 09.04.2025.
//

import SwiftUI

struct TrainCellView: View {
    let train: TrainInfo

    var body: some View {
        ZStack {
            Color(.systemGray6)

            VStack(spacing: 16) {
                HStack(alignment: .top) {
                    train.companyLogo
                        .resizable()
                        .scaledToFit()
                        .frame(width: 38, height: 38)
                        .padding(.leading, 8)

                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(train.companyName)
                                .font(.system(size: 17))

                            Spacer()

                            Text(train.date)
                                .font(.system(size: 12))
                                .foregroundColor(.secondary)
                        }

                        if let note = train.note {
                            Text(note)
                                .font(.system(size: 12))
                                .foregroundColor(.redYP)
                        }
                    }
                    .padding(.trailing, 8)
                }

                HStack {
                    Text(train.departureTime)
                        .font(.system(size: 17))

                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                        .padding(.horizontal, 4)

                    Text(train.duration)
                        .font(.system(size: 12))
                        .foregroundColor(.secondary)

                    Rectangle()
                        .fill(Color.gray.opacity(0.5))
                        .frame(height: 1)
                        .padding(.horizontal, 4)

                    Text(train.arrivalTime)
                        .font(.system(size: 17))
                }
                .padding(.horizontal, 8)
            }
            .padding()
        }
        .frame(height: 104)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
    }
}

#Preview {
    TrainCellView(train: TrainInfo(
        companyName: "РЖД",
        companyLogo: Image(systemName: "tram.fill"),
        note: "С пересадкой в Костроме",
        date: "14 января",
        departureTime: "22:30",
        arrivalTime: "08:15",
        duration: "25 часов"
    ))
}
