//
//  Material.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

class Material: Square {
    convenience init(with materialType: MaterialType) {
        self.init()
        self.squareType = .material
        self.materialType = materialType
    }
}
