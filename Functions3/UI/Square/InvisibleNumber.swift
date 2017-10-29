//
//  InvisibleNumber.swift
//  Functions3
//
//  Created by Erdi Kanik on 29/10/2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

class InvisibleNumber: Square {

    var isInvisible = false

    convenience init(with InvisibleNumber: Int) {
        self.init()

        squareType = .invisibleNumber
        setUpEvent()
    }

    override func fireEvent() {
        super.fireEvent()

        tile?.fillColor = isInvisible ? FStyle.fNumberColor() : FStyle.fNumberTextColor()
        isInvisible = !isInvisible
    }
}
