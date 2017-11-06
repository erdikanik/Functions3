//
//  Square+Factory.swift
//  Functions3
//
//  Created by Erdi Kanik on 29/10/2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

extension Square {

    static func getRandomSquare() -> Square? {

        let num = Int(FMath.getRandomGenerator(givenRange: 0, withSecond: 1000))
        var square: Square?

        square = Number(with: getRandomNumber())

        return square
    }

    private static func getRandomNumber() -> Int {
        return Int(FMath.getRandomGenerator(givenRange: -10, withSecond: 9))
    }
}
