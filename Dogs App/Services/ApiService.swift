//
//  ApiService.swift
//  Dogs App
//
//  Created by Admin on 17.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import Foundation
import Alamofire

class ApiService {
    
    
    static let access = ApiService()
    
    func getData() {
        
        guard let url = URL(string:"https://dog.ceo/api/breeds/list/all") else { return }
        let request = AF.request(url)
        
        request.responseDecodable(of: Breeds.self) { (response) in
            guard let breedsList = response.value else { return }
            let dogs = breedsList.message
            
            for (key, value) in dogs {
                let subBreeds = value as? [String] ?? [""]
                let breedName = key
                var subbreedsArray = [SubBreed]()
                for subBreed in subBreeds {
                    subbreedsArray.append(SubBreed(subBreed: subBreed))
                }
                dogsArray.append(Dogs(breedName: breedName, subBreed: subbreedsArray))
            }
            
            print("dogs count \(dogsArray.count)")
        }
    }
    
    
    
    func getImages(breed: String, subBreed: String) {
        
        var mergedUrl = ""
        if subBreed != "" {
            mergedUrl = "https://dog.ceo/api/breed/\(breed)/\(subBreed)/images"
        } else {
            mergedUrl = "https://dog.ceo/api/breed/\(breed)/images"
        }
        
        print(mergedUrl)
        guard let url = URL(string: mergedUrl) else { return }
        let request = AF.request(url)
        
        request.responseDecodable(of: BreedsImages.self) { (response) in
            guard let imagesList = response.value else { return }
            imagesArray.append(contentsOf: imagesList.message)
            print(imagesList.message)
            print(imagesArray.count)
            
        }
        
    }
}
