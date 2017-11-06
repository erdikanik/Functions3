//
//  ColorShifterNumber.swift
//  Functions3
//
//  Created by Erdi Kanık on 29.10.2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

final class ColorShifter: Square {
    var counter = 0
    var numbersArray: [Int] = []

    init(withNumbersArray numbersArray: [Int]) {
        super.init()
        squareType = .changableNumber
        self.numbersArray = numbersArray

        setUpEvent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func fireEvent() {
        if counter == numbersArray.count - 1 {
            counter = 0
        } else {
            counter += 1
        }

        number = numbersArray[counter]
        tile?.fillColor = FStyle.fNumberColorArray()[counter]
        innerLabel?.text = String(describing: number)
    }
}
