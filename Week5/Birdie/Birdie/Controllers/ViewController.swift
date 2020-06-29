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
    // create data source for tableview.
    let dataSource = MediaPostsDataSource()
    // create image picker for user.
    var imagePicker: ImagePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        // request user for textpost details then reload tableview.
        MediaPostsHandler.shared.requestPostDetails(vc: self) { [unowned self] in
            self.tableview.reloadData()
        }
    }

    @IBAction func didPressCreateImagePostButton(_ sender: UIButton) {
        // request user to pick an image
        self.imagePicker.present(from: sender)
    }

    func setUpTableView() {
        // Setting up tableview dataSource
        tableview.dataSource = dataSource
        // register custom cells
        let Textnib = UINib(nibName: "TextPostCell",bundle: nil)
        let Imagenib = UINib(nibName: "ImagePostCell",bundle: nil)
        tableview.register(Textnib, forCellReuseIdentifier: "TextPostCell")
        tableview.register(Imagenib, forCellReuseIdentifier: "ImagePostCell")
        // get initial data
        MediaPostsHandler.shared.getPosts()
        tableview.reloadData()
    }
}

extension ViewController: ImagePickerDelegate {
    // use image seleccted by user to request more details need for the post.
    func didSelect(image: UIImage?) {
        MediaPostsHandler.shared.requestPostDetails(withImage: image, vc: self) { [unowned self] in
            self.tableview.reloadData()
        }
    }
}
