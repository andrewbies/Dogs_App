//
//  VCImages.swift
//  Dogs App
//
//  Created by Admin on 17.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import UIKit

class VCImages: UIViewController {

    
    // MARK: - Constants
        
    var breedIndexPath = 0
    var subBreedIndexPath = -1
    var imageCount = 0
    var isLikeTapped = false
    
    
    // MARK: - Outlet
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var imagesLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeOutlet: UIButton!
    
    // MARK: - Actions
    
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        imagesArray.removeAll()
    }
    
    @IBAction func nextImage(_ sender: Any) {
        if imageCount == (imagesArray.count - 1) {
            imageCount = 0
        } else {
            imageCount += 1
        }
        
        getImage(count: imageCount)
        
    }
    @IBAction func prevImage(_ sender: Any) {
        if imageCount == 0 {
            imageCount = imagesArray.count - 1
        } else {
            imageCount = imageCount - 1
        }
        
        getImage(count: imageCount)
    }
    
    @IBAction func likeTapped(_ sender: Any) {
        
        let object = BreedModel()
        object.breed = dogsArray[self.breedIndexPath].breedName
        object.photoUrl = "\(imagesArray[imageCount])"
        object.isLiked = true
        if subBreedIndexPath == (-1) {
            object.subBreed = ""
        } else {
            object.subBreed = dogsArray[self.breedIndexPath].subBreed[self.subBreedIndexPath].subBreed
        }
        
        if isLikeTapped == false {
            print(object)
            DBContainer.access.saveLikeObject(object: object)
            likeOutlet.tintColor = .systemPink
            
        } else {
            likeOutlet.tintColor = .secondarySystemBackground
            DBContainer.access.deleteLike_By(photoUrl: imagesArray[imageCount])
            print("deleted")
            likeOutlet.tintColor = .secondarySystemBackground
        }
    }
    
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.layer.cornerRadius = 10
        getImageData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            self.getImage(count: self.imageCount)
            self.setTitle()
        })
    }
    
    // MARK: - Methods
    
    func setTitle() {

        if dogsArray[self.breedIndexPath].subBreed.isEmpty == true {
            self.topLabel.text = dogsArray[self.breedIndexPath].breedName
        } else {
            self.topLabel.text = "\(dogsArray[self.breedIndexPath].breedName.capitalized), \(dogsArray[self.breedIndexPath].subBreed[self.subBreedIndexPath].subBreed.capitalized)"
        }
    }
    
    
    func getImageData() {
        if dogsArray[self.breedIndexPath].subBreed.isEmpty == true {
            ApiService.access.getImages(
                breed: dogsArray[self.breedIndexPath].breedName,
                subBreed: "")
        } else {
            ApiService.access.getImages(
                breed: dogsArray[self.breedIndexPath].breedName,
                subBreed: dogsArray[self.breedIndexPath].subBreed[self.subBreedIndexPath].subBreed)
        }
    }
    
    func getImage(count: Int) {
        
        imagesLabel.text = "\(count + 1) фото из \(imagesArray.count)"
        print(count)
        let url = URL(string: imagesArray[count])
        let data = try? Data(contentsOf: url!)
        DispatchQueue.main.async {
            self.imageView.image = UIImage(data: data!)
        }
        if DBContainer.access.isContains(photoUrl: imagesArray[count]) {
            isLikeTapped = true
            likeOutlet.tintColor = .systemPink
        } else {
            isLikeTapped = false
            likeOutlet.tintColor = .secondarySystemBackground
        }
    }
    
}
