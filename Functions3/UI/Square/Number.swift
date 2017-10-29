//
//  Number.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

import Foundation

final class Number: Square {
    
    convenience init(with number: Int) {
        self.init()
        squareType = .number
        self.number = number
    }
}
