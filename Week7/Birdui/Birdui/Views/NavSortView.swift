//
//  NavSortView.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 09/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct NavSortView: View {
    @State var isCreateNewPostShowing = false
    @State var showSortSheet: Bool = false
    var isSortedByNewest:Bool { return  self.posts.isSortedByNewest}
    var sortState: String  { return isSortedByNewest ? "Newest": "Oldest" }
    var posts:PostViewModel

    var body: some View {
        HStack {
            Button("") {
                self.showSortSheet = true
            }
            .buttonStyle(SortPostButtonStyle())
            .actionSheet(isPresented: $showSortSheet) {
                ActionSheet(title: Text("Sort Images By"), buttons: [
                    .default(Text("Newest Date")) {
                        self.posts.isSortedByNewest = false
                        self.posts.toggle()
                    },
                    .default(Text("Oldest Date")) {
                        self.posts.isSortedByNewest = true
                        self.posts.toggle()
                    },
                    .cancel()
                ])
            }
            Text(sortState)
                .font(.subheadline)
                .fontWeight(.bold)
                .onTapGesture {
                    self.showSortSheet = true
            }


        }
    }
}


struct HomeTopView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavSortView(posts: PostViewModel())
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Home Top Dark Mode")
        }
    }
}
