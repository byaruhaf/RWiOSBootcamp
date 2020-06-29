//
//  MediaPosts.swift
//  Birdie
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class MediaPostsHandler: NSObject {
    static let shared = MediaPostsHandler()
    var mediaPosts: [MediaPost] = []

    private override init() {}

    func getPosts() {
        let imagePost1 = ImagePost(textBody: "I love debugging software!", userName: "Jay", timestamp: Date(timeIntervalSince1970: 10000), image: UIImage(named: "chop")!)
        let imagePost2 = ImagePost(textBody: "Went to the Aquarium today :]", userName: "Audrey", timestamp: Date(timeIntervalSince1970: 30000), image: UIImage(named: "octopus")!)
        let textPost1 = TextPost(textBody: "Hello World!", userName: "Bhagat", timestamp: Date(timeIntervalSince1970: 20000))
        let textPost2 = TextPost(textBody: "This is my favorite social media app!", userName: "Jeff", timestamp: Date(timeIntervalSince1970: 40000))

        mediaPosts = [imagePost1, imagePost2, textPost1, textPost2]
        mediaPosts = mediaPosts.sorted(by: { $0.timestamp > $1.timestamp })
    }

    func addTextPost(textPost: TextPost) {
        mediaPosts.append(textPost)
        mediaPosts = mediaPosts.sorted(by: { $0.timestamp > $1.timestamp })
    }

    func addImagePost(imagePost: ImagePost) {
        mediaPosts.append(imagePost)
        mediaPosts = mediaPosts.sorted(by: { $0.timestamp > $1.timestamp })
    }

    func requestPostDetails(withImage:UIImage? = nil,vc: UIViewController,  completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "New Post", message: "What's happening?", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Username"
            textField.returnKeyType = .next
            textField.autocapitalizationType = .words
        }

        alert.addTextField { (textField) in
            textField.placeholder = "post"
            textField.autocapitalizationType = .sentences
            textField.autocorrectionType = .yes
            textField.returnKeyType = .done
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ _  in
            guard let username = alert.textFields?[0].text else { return }
            let textPost = alert.textFields?[1].text
            if let imageForPost = withImage {
                let post = ImagePost(textBody: textPost, userName: username, timestamp: Date(), image: imageForPost)
                MediaPostsHandler.shared.addImagePost(imagePost: post)
            } else {
                let post = TextPost(textBody: textPost, userName: username, timestamp: Date())
                MediaPostsHandler.shared.addTextPost(textPost: post)
            }
             completion()
        }))

        vc.present(alert, animated: true, completion: nil)
    }

}
