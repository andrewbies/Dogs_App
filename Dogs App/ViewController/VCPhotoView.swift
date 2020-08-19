//
//  VCPhotoViewViewController.swift
//  Dogs App
//
//  Created by Admin on 18.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import UIKit

class VCPhotoView: UIViewController {

    
    // MARK: - Constants
    
    var isLikeTapped = true
    var imageCount = 0
    var imageUrl = ""
    
    // MARK: - Outlets
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleView: UILabel!
    
    
    // MARK: - Actions
    
    @IBAction func likeTapped(_ sender: Any) {
    
        DBContainer.access.deleteLike_By(photoUrl: imageUrl)
        print("deleted")
        likeButton.tintColor = .secondarySystemBackground
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lyfecycle
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let prevVC = presentingViewController as? VCLikedPhotos {
            prevVC.objects = DBContainer.access.getAll()
            prevVC.collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTitle()
        
        self.likeButton.tintColor = .systemPink
        self.photoView.layer.cornerRadius = 15
        
        let url = URL(string: imageUrl)
        DispatchQueue.main.async {
            let data = try? Data(contentsOf: url!)
            let imagee = UIImage(data: data!)
            self.photoView?.image = imagee
        }
        
        setBlurEffect()
    }
    
    
    // MARK: - Methods
    
    func setTitle() {
        let object = DBContainer.access.getBy(photoUrl: imageUrl)
        if object[0].subBreed.isEmpty {
            self.titleView.text = object[0].breed.capitalized
        } else {
            self.titleView.text = "\(object[0].breed.capitalized), \(object[0].subBreed.capitalized)"
        }
    }
    
    func setBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
    }
}
