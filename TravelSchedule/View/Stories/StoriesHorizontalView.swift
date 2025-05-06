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

// MARK: - Preview
#Preview("Stories Horizontal View Preview") {
    @Previewable @State var stories = StoriesStabData.shared.stories
    
    return StoriesHorizontalView(stories: $stories) { story in
        print("Tapped on story: \(story.title)")
    }
    .background(Color.gray.opacity(0.1))
}
