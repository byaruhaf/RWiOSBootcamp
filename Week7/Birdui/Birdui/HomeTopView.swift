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
    var posts:PostViewModel
    @State var isSortedByNewest:Bool = true
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                HStack {
                    VStack {
                        Button("") {
                            self.showSortSheet = true
                        }.padding()
                            .buttonStyle(SortPostButton())
                            .actionSheet(isPresented: $showSortSheet) {
                                ActionSheet(title: Text("Sort By"), buttons: [
                                    .default(Text("Oldest")) {
                                        self.isSortedByNewest = false
                                        self.posts.isSortedByNewest = false
                                        self.posts.toggle()
                                    },
                                    .default(Text("Newest")) {
                                        self.isSortedByNewest = true
                                        self.posts.isSortedByNewest = true
                                        self.posts.toggle()
                                    },
                                    .cancel()
                                ])
                        }
                    }
                    Spacer()
                }
                Text("HOME")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            HStack {
                if isSortedByNewest {
                    Text("Newest")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }else {
                    Text("Oldest")
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                Spacer()
                Text("\(posts.posts.count) Posts")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(.trailing)
            }
            .padding(.leading)
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
