//
//  MediaPostsCellCoordinator.swift
//  Birdie
//
//  Created by Franklin Byaruhanga on 28/06/2020.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit


class MediaPostsCellCoordinator {
    static let shared = MediaPostsCellCoordinator()

    func setUpTableViewCell(for post: MediaPost, in tableview: UITableView) -> UITableViewCell {
        if let post = post as? TextPost {
            let cell = tableview.dequeueReusableCell(withIdentifier: "TextPostCell") as! TextPostCell
            cell.nameLabel.text = post.userName
            cell.timestampLabel.text = post.timestamp.toString()
            cell.textBodyLabel.text = post.textBody
            print("Text")
            return cell
        } else if let post = post as? ImagePost {
            let cell = tableview.dequeueReusableCell(withIdentifier: "ImagePostCell") as! ImagePostCell
            cell.nameLabel.text = post.userName
            cell.timestampLabel.text = post.timestamp.toString()
            cell.textBodyLabel.text = post.textBody
            cell.postImageView.image = post.image
             print("IMGAE")
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = post.textBody
            return cell
        }
    }
}


extension Date {
    func toString(withFormat format: String = "d MMM, HH:mm") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}
