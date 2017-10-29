//
//  BombNumber.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

class BombNumber: Square {
    
    init(with number: Int)
    {
        self.init()
        number = self.number
        squareType = .bomb
    }
}
