//
//  ColorShifterNumber.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

class ColorShifter: Square {
    convenience init(withNumbersArray numbersArray: [Int]) {
        self.init()
        squareType = .changableNumber
    }
}
