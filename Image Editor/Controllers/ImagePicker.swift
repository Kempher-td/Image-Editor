//
//  ImagePicker.swift
//  Image Editor
//
//  Created by Victor Mashukevich on 25.03.24.
//

import Foundation
import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    var imagePickerController: UIImagePickerController?
    var completion: ((UIImage) -> ())?
    
   
    func showImagePicker(in viewController: UIViewController, complition: ((UIImage) -> ())?){
        self.completion = complition
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        imagePickerController?.allowsEditing = false
        viewController.present(imagePickerController!, animated: true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        

        picker.dismiss(animated: true)
        if let image = info[.originalImage] as? UIImage {
            self.completion?(image)
            
            picker.dismiss(animated: true)
        }
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }}
