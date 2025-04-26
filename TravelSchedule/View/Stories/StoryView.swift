//
//  StoryView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct StoryView: View {
    let content: ContentStory

    var body: some View {
        ZStack {
            Color.blackYP
                .ignoresSafeArea() // Черный фон

            Image(content.big)
                .resizable()
                .aspectRatio(contentMode: .fit) // Показывать полностью без обрезания
                .clipShape(RoundedRectangle(cornerRadius: 40))

            VStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text(content.title)
                        .font(.bold34)
                        .foregroundColor(.white)
                    Text(content.description)
                        .font(.regular20)
                        .lineLimit(3)
                        .foregroundColor(.white)
                }
                .padding(.init(top: 0, leading: 16, bottom: 40, trailing: 16))
            }
        }
    }
}
