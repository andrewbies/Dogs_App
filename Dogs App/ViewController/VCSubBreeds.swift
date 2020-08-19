//
//  VCSubBreeds.swift
//  Dogs App
//
//  Created by Admin on 17.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import UIKit

class VCSubBreeds: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - Constants
    
    var breedIndexPath = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var topTitle: UILabel!
    
    
    // MARK: - Actions
    
    @IBAction func goBack(_ sender: UIButton) {
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goTomain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func goToLiked(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCLikedPhotos") as? VCLikedPhotos
        vc?.modalTransitionStyle   = .crossDissolve;
        vc?.modalPresentationStyle = .overFullScreen
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    // MARK: - Lyfecycle
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.destination is VCImages else { return }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.reloadData()
        self.topTitle.text = dogsArray[breedIndexPath].breedName.capitalized
    }
    
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogsArray[breedIndexPath].subBreed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subBreedCell", for: indexPath)
        
        let currentSubBreed = dogsArray[breedIndexPath].subBreed[indexPath.row].subBreed
        cell.textLabel?.text = currentSubBreed.capitalized
        print(currentSubBreed)
        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
                    
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "VCImages") as? VCImages
        vc?.modalTransitionStyle   = .crossDissolve;
        vc?.modalPresentationStyle = .overFullScreen
        vc?.breedIndexPath = breedIndexPath
        vc?.subBreedIndexPath = indexPath.row
        
        self.present(vc!, animated: true, completion: nil)
    }

}
