//
//  RetweetView.swift
//  Birdui
//
//  Created by Franklin Byaruhanga on 14/07/2020.
//  Copyright © 2020 Razeware. All rights reserved.
//

import SwiftUI
import CoreLocation

struct RetweetView: View {
    @State var repost: RetweetMediaPost
    var postHandler: PostViewModel
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "person.circle") .accessibility(label: Text("Profile Image")).font(.system(size: 40, weight: .regular)).foregroundColor(Color.orange)
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text(repost.userName)
                        .fontWeight(.bold)
                    Text("\(repost.timestamp.toString())")
                        .font(.caption)
                }
            }
            PostView(post: repost.post, postHandler: postHandler)
        }
    }
}

struct RetweetView_Previews: PreviewProvider {
    static var previews: some View {
        RetweetView(repost: RetweetMediaPost(userName: "LittleFinger", timestamp: Date(), post: MediaPost(textBody: "Kirk, Spock, Bones, Sulu, Chekov and Uhura go back to the future (or is it forward to the past?) as the Federation gets repainted, retooled and rebooted",
                                                                                                          userName: "Audrey", timestamp: Date(timeIntervalSinceNow: -9876),
                                                                                                          uiImage: UIImage(named: "octopus"), location: CLLocationCoordinate2DMake(37.8136,144.9631))), postHandler: PostViewModel())
            .previewLayout(PreviewLayout.sizeThatFits)
            .padding()
            .background(Color(.systemBackground))
            .environment(\.colorScheme, .dark)
            .previewDisplayName("Post With Image Dark Mode preview")
    }
}
