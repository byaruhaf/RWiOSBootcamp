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
    let dataSource = MediaPostsDataSource()
    var imagePicker: ImagePicker!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
//        createPost()
        requestPostDetails()
    }

    @IBAction func didPressCreateImagePostButton(_ sender: UIButton) {
//        createPost(withImage:true)
        self.imagePicker.present(from: sender)

    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        tableview.dataSource = dataSource
        let Textnib = UINib(nibName: "TextPostCell",bundle: nil)
        let Imagenib = UINib(nibName: "ImagePostCell",bundle: nil)
        tableview.register(Textnib, forCellReuseIdentifier: "TextPostCell")
        tableview.register(Imagenib, forCellReuseIdentifier: "ImagePostCell")
        MediaPostsHandler.shared.getPosts()
        tableview.reloadData()
    }

}

extension ViewController: ImagePickerDelegate {

    func didSelect(image: UIImage?) {
        requestPostDetails(withImage: image)
    }
}

//extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {

extension ViewController {

//    func createPost(withImage:Bool = false) {
//        if withImage {
//            selectImageForPost()
//        } else {
//            requestPostDetails()
//        }
//    }
//
//    func selectImageForPost() {
//        let pickerController = UIImagePickerController()
//        pickerController.delegate = self
//        pickerController.allowsEditing = false
//        pickerController.sourceType = .photoLibrary
//        present(pickerController, animated: true)
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        guard let image = info[.originalImage] as? UIImage else { return }
//        dismiss(animated: true)
//        requestPostDetails(withImage: image)
//    }


    func requestPostDetails(withImage:UIImage? = nil) {
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

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ [unowned self] _  in
            guard let username = alert.textFields?[0].text else { return }
            let textPost = alert.textFields?[1].text
            if let imageForPost = withImage {
                let post = ImagePost(textBody: textPost, userName: username, timestamp: Date(), image: imageForPost)
                MediaPostsHandler.shared.addImagePost(imagePost: post)
            } else {
                let post = TextPost(textBody: textPost, userName: username, timestamp: Date())
                MediaPostsHandler.shared.addTextPost(textPost: post)
            }

              self.tableview.reloadData()
        }))

        present(alert, animated: true, completion: nil)
    }

}
