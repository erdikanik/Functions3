//
//  InvisibleNumber.swift
//  Functions3
//
//  Created by Erdi Kanik on 29/10/2017.
//  Copyright © 2017 ekanik. All rights reserved.
//

class InvisibleNumber: Square {

    var isInvisible = false

    init(with InvisibleNumber: Int) {
        super.init()

        squareType = .invisibleNumber
        setUpEvent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func fireEvent() {
        super.fireEvent()

        tile?.fillColor = isInvisible ? FStyle.fNumberColor() : FStyle.fNumberTextColor()
        isInvisible = !isInvisible
    }
}
