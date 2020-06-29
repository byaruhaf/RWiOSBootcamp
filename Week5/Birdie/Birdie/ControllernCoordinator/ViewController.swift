//
//  ViewController.swift
//  Birdie
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var tableview: UITableView!
    var mediaPostsHandler = MediaPostsHandler.shared
    var mediaPosts: [MediaPost] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        tableview.delegate = self
        tableview.dataSource = self
        let Textnib = UINib(nibName: "TextPostCell",bundle: nil)
        let Imagenib = UINib(nibName: "ImagePostCell",bundle: nil)
        tableview.register(Textnib, forCellReuseIdentifier: "TextPostCell")
        tableview.register(Imagenib, forCellReuseIdentifier: "ImagePostCell")
        mediaPostsHandler.getPosts()
        mediaPosts = mediaPostsHandler.mediaPosts
        tableview.reloadData()
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {

    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }

    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mediaPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mediaPost = mediaPosts[indexPath.row]
        let cell = MediaPostsCellCoordinator.shared.setUpTableViewCell(for: mediaPost, in: tableView)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }


}
