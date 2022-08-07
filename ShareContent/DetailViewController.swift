//
//  DetailViewController.swift
//  StormViewer_HS
//
//  Created by Shah Md Imran Hossain on 16/7/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var selectImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let imageToLoad = selectImage else {
            print("[DetailViewController] selected image is nil")
            return
        }
        
        // setting title of screen
        title = imageToLoad
        navigationItem.largeTitleDisplayMode = .never
        
        // .action - indicates it's a actionable bar button
        // target - relfects where the action method can found
        // action - bar button tapped action
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        imageView.image = UIImage(named: imageToLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("No image found")
            return
        }
        
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}
