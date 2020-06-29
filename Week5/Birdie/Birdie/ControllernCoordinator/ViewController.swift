//
//  ViewController.swift
//  Birdie
//
//  Created by Jay Strawn on 6/18/20.
//  Copyright © 2020 Jay Strawn. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource{

    @IBOutlet weak var tableview: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }

    @IBAction func didPressCreateTextPostButton(_ sender: Any) {
        createPost()
    }

    @IBAction func didPressCreateImagePostButton(_ sender: Any) {
        createPost(withImage:true)
    }

    func setUpTableView() {
        // Set delegates, register custom cells, set up datasource, etc.
        tableview.dataSource = self
        let Textnib = UINib(nibName: "TextPostCell",bundle: nil)
        let Imagenib = UINib(nibName: "ImagePostCell",bundle: nil)
        tableview.register(Textnib, forCellReuseIdentifier: "TextPostCell")
        tableview.register(Imagenib, forCellReuseIdentifier: "ImagePostCell")
        MediaPostsHandler.shared.getPosts()
        tableview.reloadData()
    }

}

extension ViewController {
    //MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MediaPostsHandler.shared.mediaPosts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let mediaPost = MediaPostsHandler.shared.mediaPosts[indexPath.row]
        let cell = MediaPostsCellCoordinator.shared.configureCell(for: mediaPost, in: tableView)
        cell.backgroundView = UIView(backgroundColor: .white)
        cell.backgroundView?.addSeparator()

        cell.selectedBackgroundView = UIView(backgroundColor: .lightGray)
        cell.selectedBackgroundView?.addSeparator()
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    func createPost(withImage:Bool = false) {
        if withImage {
            selectImageForPost()
        } else {
            requestPostDetails()
        }
    }

    fileprivate func selectImageForPost() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing = false
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        dismiss(animated: true)
        requestPostDetails(withImage: image)
    }


    func requestPostDetails(withImage:UIImage? = nil) {
        let alert = UIAlertController(title: "Create Post", message: "Whats the latest update", preferredStyle: UIAlertController.Style.alert)

        alert.addTextField { (textField) in
            textField.placeholder = "Username"
            textField.returnKeyType = .next
        }

        alert.addTextField { (textField) in
            textField.placeholder = "post"
            textField.autocapitalizationType = .sentences
            textField.autocorrectionType = .yes
            textField.returnKeyType = .done
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:nil))

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler:{ (UIAlertAction) in
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

        self.present(alert, animated: true, completion: nil)
    }


}

private extension UIView {
    convenience init(backgroundColor: UIColor) {
        self.init()
        self.backgroundColor = backgroundColor
    }

    func addSeparator() {
        let separatorHeight: CGFloat = 2
        let frame = CGRect(x: 0, y: bounds.height - separatorHeight, width: bounds.width, height: separatorHeight)
        let separator = UIView(frame: frame)
        separator.backgroundColor = .gray
        separator.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]

        addSubview(separator)
    }
}
