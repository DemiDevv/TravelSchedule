//
//  StoriesHorizontalView.swift
//  TravelSchedule
//
//  Created by Demain Petropavlov on 25.04.2025.
//

import SwiftUI

struct StoriesHorizontalView: View {
    @Binding var stories: [Story]
    var onStoryTap: (Story) -> Void

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                ForEach($stories) { $story in
                    StoryPreviewCellView(story: story)
                        .onTapGesture {
                            story.isViewed = true
                            onStoryTap(story)
                        }
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
