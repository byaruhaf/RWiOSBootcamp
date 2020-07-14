//
//  ImagePicker.swift
//  Birdui
//
//  Created by Audrey Tam on 4/7/20.
//  Copyright © 2020 Razeware. All rights reserved.
//

import Foundation
import SwiftUI


class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    @Binding var image: UIImage?
    @Binding var isShown: Bool

    init(image: Binding<UIImage?>, isShown: Binding<Bool>) {
        _image = image
        _isShown = isShown
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiImage
            isShown = false
        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isShown = false
    }

}


struct ImagePicker: UIViewControllerRepresentable {

    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator

    @Binding var image: UIImage?
    @Binding var isShown: Bool

    var sourceType: UIImagePickerController.SourceType = .savedPhotosAlbum

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(image: $image, isShown: $isShown)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.delegate = context.coordinator
        guard UIImagePickerController.isSourceTypeAvailable(sourceType) else { return pickerController }
        pickerController.sourceType = sourceType
        pickerController.allowsEditing = true
        return pickerController

    }

}

