//
//  DogsModel.swift
//  Dogs App
//
//  Created by Admin on 17.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import Foundation
import RealmSwift

struct Dogs {
    let breedName: String
    let subBreed: [SubBreed]
}

struct SubBreed {
    let subBreed: String
}

class BreedModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var breed = ""
    @objc dynamic var subBreed = ""
    @objc dynamic var photoUrl = ""
    @objc dynamic var isLiked = false
    @objc dynamic var image = Data()
    
    override class func primaryKey() -> String? {
        return "photoUrl"
    }
}

