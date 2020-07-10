//
//  HomeTopView.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 09/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI

struct HomeTopView: View {
    @State var isCreateNewPostShowing = false
    @State var showSortSheet: Bool = false
    @State var isSortedByNewest:Bool = true
    var sortState: String  { return isSortedByNewest ? "Newest": "Oldest" }
    var posts:PostViewModel

    var body: some View {
        HStack {
                Button("") {
                    self.showSortSheet = true
                }
                .buttonStyle(SortPostButton())
                .actionSheet(isPresented: $showSortSheet) {
                    ActionSheet(title: Text("Sort Images By"), buttons: [
                        .default(Text("Oldest Date")) {
                            self.isSortedByNewest = false
                            self.posts.isSortedByNewest = false
                            self.posts.toggle()
                        },
                        .default(Text("Newest Date")) {
                            self.isSortedByNewest = true
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
            HomeTopView(posts: PostViewModel())
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .previewDisplayName("Home Top")
            HomeTopView(posts: PostViewModel())
                .previewLayout(PreviewLayout.sizeThatFits)
                .padding()
                .background(Color(.systemBackground))
                .environment(\.colorScheme, .dark)
                .previewDisplayName("Home Top Dark Mode")
        }
    }
}
