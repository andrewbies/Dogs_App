//
//  VCBreeds.swift
//  Dogs App
//
//  Created by Admin on 17.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import UIKit
import RealmSwift

class VCBreeds: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - Outlets

    @IBOutlet weak var stackTopLabels: UIStackView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var startPicture: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var showButtonOutlet: UIButton!
    @IBOutlet weak var yConstraintPicture: NSLayoutConstraint!
    
    
    // MARK: - Actions
    
    @IBAction func likedListButton(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCLikedPhotos") as? VCLikedPhotos
        vc?.modalTransitionStyle   = .crossDissolve;
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    @IBAction func showButtonTapped(_ sender: UIButton) {
        
        self.tableView.reloadData()
        if dogsArray.isEmpty {
            let alert = UIAlertController(title: "Ой!", message: "Что-то не так с соединением!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Oк", style: .cancel, handler: nil))
            present(alert, animated: true)
        } else {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.showButtonOutlet.alpha = 0
                self.startPicture.alpha = 0
                self.tableView.alpha = 1
                self.topView.alpha = 1
                self.bottomView.alpha = 1
            })
        }
        
    }
    
    // MARK: - Lyfecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewInitialize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? VCSubBreeds else { return }
    }
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "breedCell", for: indexPath)
        
        if dogsArray.isEmpty {
            return cell
        } else {
            let currentBreedName = dogsArray[indexPath.row].breedName.capitalized
            let currentBreedTypes = dogsArray[indexPath.row].subBreed.count
            
            if currentBreedTypes != 0 {
                cell.textLabel?.text = "\(currentBreedName), видов: \(currentBreedTypes)"
                cell.detailTextLabel?.text = "\(currentBreedTypes)"
            } else {
                cell.textLabel?.text = "\(currentBreedName)"
            }
            
            print(currentBreedTypes)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if dogsArray[indexPath.row].subBreed.isEmpty == true {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCImages") as? VCImages
            vc?.modalTransitionStyle   = .crossDissolve;
            vc?.modalPresentationStyle = .overFullScreen
            vc?.breedIndexPath = indexPath.row
            self.present(vc!, animated: true, completion: nil)
            
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCSubBreeds") as? VCSubBreeds
            vc?.modalTransitionStyle   = .crossDissolve;
            vc?.modalPresentationStyle = .overFullScreen
            vc?.breedIndexPath = indexPath.row
            self.present(vc!, animated: true, completion: nil)
        }
    }

    
    // MARK: - Methods
    
    func viewInitialize() {
        
        self.startPicture.center.y = 30
        self.showButtonOutlet.center.y = 40
        self.tableView.alpha = 0
        self.stackTopLabels.alpha = 0
        self.topView.alpha = 0
        self.bottomView.alpha = 0
        self.showButtonOutlet.layer.cornerRadius = showButtonOutlet.frame.height / 2
        self.showButtonOutlet.alpha = 0
        ApiService.access.getData()
        
        UIView.animate(withDuration: 1, animations: {
            self.startPicture.center.y = 0
            self.showButtonOutlet.center.y = 0
            self.showButtonOutlet.alpha = 1
            self.startPicture.alpha = 1
            self.stackTopLabels.alpha = 1
        })

    }
}
