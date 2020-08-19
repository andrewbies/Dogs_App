//
//  CollectionCell.swift
//  Dogs App
//
//  Created by Admin on 18.08.2020.
//  Copyright © 2020 Andrew Kuznetsov. All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {

            let objects = DBContainer.access.getAll()
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dogImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    
    
    
}
