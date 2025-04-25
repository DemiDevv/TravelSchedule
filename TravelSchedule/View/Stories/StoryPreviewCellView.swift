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

            Text(story.title)
                .foregroundColor(.white)
                .font(.system(size: 12))
                .lineLimit(2)
                .padding()
        }
        .frame(width: 92, height: 140)
    }
}

struct StoryPreviewCellView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleStory = Story(
            small: .preview1,
            title: "Old Engineer",
            isViewed: false,
            story: [
                ContentStory(big: .big1, title: "Story 1", description: "Detailed description here.")
            ]
        )

        let viewedStory = Story(
            small: .preview2,
            title: "Officer Anna",
            isViewed: true,
            story: [
                ContentStory(big: .big2, title: "Story 2", description: "Another detailed description.")
            ]
        )

        return Group {
            StoryPreviewCellView(story: sampleStory)
                .previewDisplayName("Не просмотрено")

            StoryPreviewCellView(story: viewedStory)
                .previewDisplayName("Просмотрено")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
