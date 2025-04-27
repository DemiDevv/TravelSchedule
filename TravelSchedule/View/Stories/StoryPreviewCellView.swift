//
//  StoryPreviewCellView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct StoryPreviewCellView: View {
    let story: Story

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.small)
                .resizable()
                .scaledToFill()
                .frame(width: 92, height: 140)
                .clipped()
                .overlay(
                    story.isViewed ? Color.white.opacity(0.5) : Color.clear
                )
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(story.isViewed ? Color.clear : Color.blue, lineWidth: 4)
                )
                .padding(4)

            Text(story.title)
                .foregroundColor(.white)
                .font(.system(size: 12))
                .lineLimit(2)
                .padding()
        }
        .frame(width: 100, height: 148)
    }
}

// MARK: - Preview
#Preview {
    StoryPreviewCellView(
        story: Story(
            small: .preview1,
            title: "Sample Story Title",
            isViewed: false,
            story: [
                ContentStory(big: .big1, title: "Page 1", description: "Description 1")
            ]
        )
    )
}
