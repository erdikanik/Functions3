//
//  Number.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

import Foundation

final class Number: Square {
    
    init(with number: Int) {
        super.init()
        squareType = .number
        self.number = number
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
