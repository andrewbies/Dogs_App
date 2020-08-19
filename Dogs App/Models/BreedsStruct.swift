//
//  BreedsStruct.swift
//  Dogs App
//
//  Created by Admin on 17.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import Foundation

// MARK: - Breeds
struct Breeds: Codable {
    let message: [String: [String]]
    let status: String
}

struct BreedsImages: Codable {
    let message: [String]
    let status: String
}
