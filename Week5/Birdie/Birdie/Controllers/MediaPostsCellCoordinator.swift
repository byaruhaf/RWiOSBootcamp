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

    // Return tableviewcell based on mediaPost.
    func configureCell(for post: MediaPost, in tableview: UITableView) -> UITableViewCell {
        if let post = post as? TextPost {
            let cell = tableview.dequeueReusableCell(withIdentifier: CellType.text) as! TextPostCell
            cell.nameLabel.text = post.userName
            cell.timestampLabel.text = post.timestamp.toString()
            cell.textBodyLabel.text = post.textBody
            return cell
        } else if let post = post as? ImagePost {
            let cell = tableview.dequeueReusableCell(withIdentifier: CellType.image) as! ImagePostCell
            cell.nameLabel.text = post.userName
            cell.timestampLabel.text = post.timestamp.toString()
            cell.textBodyLabel.text = post.textBody
            cell.postImageView.image = post.image
            return cell
        } else {
            let cell = UITableViewCell()
            cell.textLabel?.text = post.textBody
            return cell
        }
    }
}
