//
//  DBContainer.swift
//  Dogs App
//
//  Created by Admin on 17.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import Foundation
import RealmSwift

class DBContainer {
    
    static let access = DBContainer()
    

    func getAll() -> [BreedModel] {
        let realm = try! Realm()
        return Array(realm.objects(BreedModel.self))
    }
    
    func getBy(photoUrl: String) -> [BreedModel] {
        let realm = try! Realm()
        let results = Array(realm.objects(BreedModel.self).filter("photoUrl == %@", photoUrl))
        
        return results
    }
    
    func saveLikeObject(object: Object) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.add(object, update: .modified)
        }
    }
    
    func isContains(photoUrl: String) -> Bool {
        let realm = try! Realm()
        let results = realm.objects(BreedModel.self).filter("photoUrl == %@", photoUrl)
        if results.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    func saveLike(isNew: Bool, idIfNotNew: Int, breed: String, subBreed: String, photoUrl: String, isLiked: Bool, image: Data?) {
        let realm = try! Realm()
        dump(realm.objects(BreedModel.self))
        
        let like = BreedModel()
        let id = isNew ? (realm.objects(BreedModel.self).count ) + 1 : idIfNotNew
        
        like.id = id
        like.breed = breed
        like.subBreed = subBreed
        like.photoUrl = photoUrl
        like.isLiked = false
        like.image = image ?? Data()
        
        try! realm.write {
            realm.add(like)
        }
    }
    
    
    func deleteLike(like: Object) {
        let realm = try! Realm()
        
        try! realm.write {
            realm.delete(like)
        }
    }
    
    func deleteLike_By(photoUrl: String) {
        let realm = try! Realm()
        
        let object = realm.objects(BreedModel.self).filter("photoUrl = %@", photoUrl).first
        try! realm.write {
            if let obj = object {
                realm.delete(obj)
            }
        }
    }
    
}
