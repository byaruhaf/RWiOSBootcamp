//
//  ViewController.swift
//  Birdie
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var tableview: UITableView!
    var posts = MediaPostsHandler.shared.mediaPosts

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
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {

    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {

    }


}

extension ViewController:UITableViewDelegate, UITableViewDataSource  {
    //MARK: UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MediaPostsCellCoordinator.shared.setUpTableViewCell(for: posts[indexPath.row], in: tableView)
        return cell
    }

}



