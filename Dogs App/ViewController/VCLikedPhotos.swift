//
//  VCLikedPhotos.swift
//  Dogs App
//
//  Created by Admin on 18.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import UIKit

class VCLikedPhotos: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    // MARK: - Constants

    var objects = DBContainer.access.getAll()
    
    // MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: - Actions

    @IBAction func goToMain(_ sender: Any) {
                self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goBack(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.destination is VCPhotoView else { return }
    }
    
    
    // MARK: - CollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if objects.isEmpty {
            collectionView.isHidden = true
        }
        return objects.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        
        cell.contentView.layer.cornerRadius = 5
        print(self.objects[indexPath.row].photoUrl)
        
        let url = URL(string: self.objects[indexPath.row].photoUrl)
        
        DispatchQueue.main.async {
            let data = try? Data(contentsOf: url!)
            if data != nil {
                let imagee = UIImage(data: data!)
                cell.dogImage?.image = imagee
            } else {
                cell.label.text = "Ошибка загрузки"
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionCell
        //        if objects[indexPath.row].photoUrl.isEmpty {
        //                    let alert = UIAlertController(title: "Ой!", message: "Вы уже удалили эту фотографию!", preferredStyle: .alert)
        //                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        //                    present(alert, animated: true)
        //        } else {
        //
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCPhotoView") as? VCPhotoView
        vc?.modalTransitionStyle   = .crossDissolve;
        vc?.modalPresentationStyle = .overFullScreen
        vc?.imageUrl = self.objects[indexPath.row].photoUrl
        self.present(vc!, animated: true, completion: nil)
        
    }
    
}



