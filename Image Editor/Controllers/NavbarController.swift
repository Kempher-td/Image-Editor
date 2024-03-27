//
//  NavBarController.swift
//  Image Editor
//
//  Created by Victor Mashukevich on 26.03.24.
//
import UIKit

final class NavbarController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure(){
        view.backgroundColor =  .systemTeal        
        navigationBar.isTranslucent = false
        navigationBar.standardAppearance.titleTextAttributes = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.fontNames(forFamilyName: "Helvetica")
        ]
    }
}
