//
//  ViewController.swift
//  Image Editor
//
//  Created by Victor Mashukevich on 25.03.24.
//

import UIKit

class MainController: UIViewController {
    
    // MARK: - UI Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let cropView: UIView = {
        let layout  = UICollectionViewFlowLayout()
        let cropView = UIView()
        cropView.layer.borderWidth = 2
        cropView.layer.borderColor = UIColor.yellow.cgColor
        cropView.translatesAutoresizingMaskIntoConstraints = false
        cropView.backgroundColor = UIColor(red: 0.09, green: 0.56, blue: 0.8, alpha: 0.2)
        cropView.clipsToBounds = true
        return cropView
    }()
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "square.and.arrow.down"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.systemBlue, for: .normal)
        button.setImage(UIImage(systemName: "plus.app"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let imagePicker = ImagePicker()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.view.backgroundColor = .white
        setupButton()
       
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        imageView.addGestureRecognizer(panGesture)
        imageView.isUserInteractionEnabled = true
        
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinchGesture))
        imageView.addGestureRecognizer(pinchGesture)
        
        view.addSubview(cropView)
        cropView.addSubview(imageView)
        setupConstraints()
    }

    
    private func setupButton(){
        saveButton.addTarget(self, action: #selector(savebutton), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(openPhotoGallery), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: addButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)
    }
    
    private func setupConstraints(){
        imageView.leftAnchor.constraint(equalTo: cropView.leftAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: cropView.widthAnchor, multiplier: 1).isActive = true
        imageView.heightAnchor.constraint(equalTo: cropView.heightAnchor, multiplier: 1).isActive = true
        imageView.rightAnchor.constraint(equalTo: cropView.rightAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: cropView.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: cropView.centerXAnchor).isActive = true
        
        cropView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cropView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30).isActive = true
        cropView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        cropView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }

    // MARK: - Selectors
    @objc func openPhotoGallery() {
        
        imagePicker.showImagePicker(in: self) { image in
            self.imageView.image = image
            self.imageView.frame = self.cropView.bounds
        
        }
    }

    @objc func savebutton() {
        
        UIGraphicsBeginImageContextWithOptions(cropView.bounds.size, false, 0.0)
        cropView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if let croppedImage = image {
            UIImageWriteToSavedPhotosAlbum(croppedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
            if let error = error {
                // Save Error
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            } else {
                // Successfully save
                let alert = UIAlertController(title: "Successfully", message: "The image is saved to the gallery", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
   

    @objc func handlePinchGesture(sender: UIPinchGestureRecognizer) {
            guard let view = sender.view else { return }
            
            view.transform = view.transform.scaledBy(x: sender.scale, y: sender.scale)
            sender.scale = 1.0
            
        }
        
        @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
            let translation = sender.translation(in: self.view)
            guard let senderView = sender.view else { return }
            
            senderView.center = CGPoint(x: senderView.center.x + translation.x, y: senderView.center.y + translation.y)
            
            sender.setTranslation(CGPoint.zero, in: self.view)
        }
}

